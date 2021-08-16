# ハンズオン

ハンズオンでは、Ruby on Rails プロジェクトに GraphQL Ruby を導入し、Query と Mutation に1つずつフィールドを追加します。

## graphql gem のインストールと Rails アプリへの導入

graphql gem をインストールします。
[`Gemfile`](../minimart/Gemfile) に `gem 'graphql'` を追加して `bundle install` を実行してください。

```diff
diff --git a/minimart/Gemfile b/minimart/Gemfile
index b8b75d3..c390adb 100644
--- a/minimart/Gemfile
+++ b/minimart/Gemfile
@@ -13,6 +13,7 @@ gem 'puma', '~> 5.0'
 # Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
 # gem 'rack-cors'
 
+gem 'graphql'
 gem 'grpc'
 gem 'ridgepole', require: false
```

```console
$ bundle install
```

インストールできたら、次のコマンドで Rails アプリにおいて GraphQL エンドポイントを提供するためのコードを生成します。

```console
$ bin/rails generate graphql:install
```

## 自動生成されたコードの確認

ここから、生成されたコードを見ていきます。

まず、[`config/routes.rb`](../minimart/config/routes.rb) に次の1行が追加されています。

```ruby
post "/graphql", to: "graphql#execute"
```

`config/routes.rb` ではルーティングを設定します。
上記は、`POST /graphql` のリクエストを `GraphqlController` の `execute` アクションに割り当てています。

次に、対応する `app/controllers/graphql_controller.rb` のメソッド `#execute` の実装を見ます。

```ruby
variables = prepare_variables(params[:variables])
query = params[:query]
operation_name = params[:operationName]
context = {
  # Query context goes here, for example:
  # current_user: current_user,
}
result = MinimartSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
render json: result
```

ここでは `params` に入っているリクエストのパラメータを整形し、`MinimartSchema.execute` に渡して GraphQL query を実行、その結果を JSON として返しています（Rails のコントローラについて詳しくは https://railsguides.jp/action_controller_overview.html を参照してください）。

`MinimartSchema` も自動生成されたクラスで、`GraphQL::Schema` を継承しています。

また、`app/graphql` 以下に `base_` prefix のクラスがたくさん生成されていますが、これらは graphql gem のクラスを継承した基底クラスです。
graphql gem のクラスを直接継承するのではなく、これらの基底クラスを継承するようにすることで、たとえばアプリケーションのすべてのフィールドに共通の振る舞いを持たせたくなったとき、基底クラスにその振る舞いを追加することでそれを達成できます（が、今回これらにあえて変更を加える必要はないでしょう）。

ここで一度 git commit しておきましょう。

```console
$ git add .
$ git commit -m 'Introduce graphql gem'
```

## context と current_user について

minimart API では、擬似的な認証としてリクエストヘッダー `X-User-Name` の値をリクエストしたユーザーの名前とみなすようになっています（もちろん、容易に他人に成りすませてしまうので、本番環境で稼働するアプリケーションで同様の手段を用いてはいけません）。

こうした GraphQL クエリ外のアプリケーション特有の値は、`context` としてクエリの実行時に渡すと、リゾルバからアクセスできるようになります。

`GraphqlController#execute` で `context` ハッシュの `:current_user` にユーザーオブジェクトを入れて `MinimartSchema.execute` に渡すようにしましょう。

```diff
diff --git a/minimart/app/controllers/graphql_controller.rb b/minimart/app/controllers/graphql_controller.rb
index 36446ac..e0c4331 100644
--- a/minimart/app/controllers/graphql_controller.rb
+++ b/minimart/app/controllers/graphql_controller.rb
@@ -9,8 +9,7 @@ class GraphqlController < ApplicationController
     query = params[:query]
     operation_name = params[:operationName]
     context = {
-      # Query context goes here, for example:
-      # current_user: current_user,
+      current_user: current_user,
     }
     result = MinimartSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
     render json: result
```

実は、`#current_user` は継承元の `ApplicationController` で事前に実装済みのため、`GraphqlController#execute` の当該部分をコメントを外すだけで構いません。
`#current_user` の実装が気になる方は [`app/controllers/application_controller.rb`](../minimart/app/controllers/application_controller.rb) を見てください。

合わせて、以下もあらかじめ実装済みです。

- `users` と `pickup_locations` のテーブル定義 ([Schemafile](../minimart/Schemafile))
- [`User`](../minimart/app/models/user.rb) と [`PickupLocation`]((../minimart/app/models/pickup_location.rb)) のモデル

## Query のフィールド viewer の実装

リクエストしたユーザー自身を返す Query のフィールド `viewer` を実装します。
実現する GraphQL スキーマは以下の通りです。

```graphql
type Query {
  viewer: User
}

type User {
  id: ID!
  name: String!
}
```

はじめに、GraphQL の型 `User` を定義します。
以下のコマンドを実行して `Types::UserType` を生成します。

```console
$ bin/rails g graphql:object User
      create  app/graphql/types/user_type.rb
```

`users` テーブルのカラム（[`Schemafile`](../minimart/Schemafile) で定義されています）から GraphQL の型が類推されて生成されるので、不要なフィールドを削除します。

```ruby
module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
  end
end
```

続いて、`Types::QueryType` で `viewer` フィールドを定義します。

```diff
diff --git a/minimart/app/graphql/types/query_type.rb b/minimart/app/graphql/types/query_type.rb
index e884f8b..4043c35 100644
--- a/minimart/app/graphql/types/query_type.rb
+++ b/minimart/app/graphql/types/query_type.rb
@@ -6,6 +6,7 @@ module Types
 
     # Add root-level fields here.
     # They will be entry points for queries on your schema.
+    field :viewer, Types::UserType, null: true
 
     # TODO: remove me
     field :test_field, String, null: false,
```

`viewer` のリゾルバを実装します。
先述のとおり、リゾルバから `context` にアクセスできます。

```diff
diff --git a/minimart/app/graphql/types/query_type.rb b/minimart/app/graphql/types/query_type.rb
index 4043c35..926b2c5 100644
--- a/minimart/app/graphql/types/query_type.rb
+++ b/minimart/app/graphql/types/query_type.rb
@@ -8,6 +8,10 @@ module Types
     # They will be entry points for queries on your schema.
     field :viewer, UserType, null: true
 
+    def viewer
+      context[:current_user]
+    end
+
     # TODO: remove me
     field :test_field, String, null: false,
       description: "An example field added by the generator"
```

`Types::UserType` の `id`、`name` フィールドのリゾルバですが、`User` オブジェクトに `id` と `name` のメソッドが生えているので、変更を加えなくともこれらのメソッドが呼ばれます。

アプリケーションサーバーを起動して、`viewer` クエリが実行できることを確認しましょう。

```console
$ curl -X POST -H 'Content-Type:application/json' -H 'X-User-Name:tomart' -d '{"query":"{viewer{name}}"}' http://localhost:3000/graphql
{"data":{"viewer":{"name":"tomart"}}}%
```

また、1日目・2日目に利用したような GraphQL Playground の導入については、[補足資料](appendix.md) を参照してください。

これで GraphQL Ruby の導入と最初のエントリーポイントの実装は完了です 🎉

ここで一度 git commit しておきましょう。

## Mutation のフィールド updatePickupLocation の実装

ユーザー自身のデフォルトの受け取り場所を変更する Mutation のフィールド `updatePickupLocation` を実装します。
実現する GraphQL スキーマは以下の通りです。

```graphql
type Mutation {
  updatePickupLocation(input: UpdatePickupLocationInput!): UpdatePickupLocationPayload
}

input UpdatePickupLocationInput {
  clientMutationId: String
  pickupLocationId: ID!
}

type UpdatePickupLocationPayload {
  clientMutationId: String
  pickupLocation: PickupLocation
}

type PickupLocation {
  id: ID!
  name: String!
}
```

まず、`User` 型と同様に `PickupLocation` 型を定義します。

```console
$ bin/rails g graphql:object PickupLocation
```

```ruby
module Types
  class PickupLocationType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
  end
end
```

次に、`Types::MutationType` に `updatePickupLocation` フィールドを追加するのですが、これは以下のコマンドが用意されています。

```console
$ bin/rails g graphql:mutation updatePickupLocation
       exist  app/graphql/mutations
   identical  app/graphql/mutations/.keep
   identical  app/graphql/mutations/base_mutation.rb
   identical  app/graphql/types/mutation_type.rb
add_root_type  mutation
      create  app/graphql/mutations/update_pickup_location.rb
        gsub  app/graphql/types/mutation_type.rb
```

`app/graphql/types/mutation_type.rb` を見ると、以下の1行が追加されているはずです。

```ruby
field :update_pickup_location, mutation: Mutations::UpdatePickupLocation
```

Query の `viewer` フィールドとちがって返り値の型等がなく、代わりに `mutation` オプションに `Mutations::UpdatePickupLocation` が渡されています。

Mutation では副作用を伴う操作を行うため、Query に比べて複雑度が上がります。
そのため、`Types::MutationType` のメソッドにするのではなく、`Mutations::UpdatePickupLocation` のクラスにリゾルバを委譲しています（Query でも同様のことは可能です）。

委譲先の `app/graphql/mutations/update_pickup_location.rb` は次のようになっています。

```ruby
module Mutations
  class UpdatePickupLocation < BaseMutation
    # TODO: define return fields
    # field :post, Types::PostType, null: false

    # TODO: define arguments
    # argument :name, String, required: true

    # TODO: define resolve method
    # def resolve(name:)
    #   { post: ... }
    # end
  end
end
```

`Mutations::UpdatePickupLocation` は `Mutations::BaseMutation` を継承しており、これはさらに `GraphQL::Schema::RelayClassicMutation` を継承しています。
GraphQL Ruby には Mutation のクラスとして `GraphQL::Schema::Mutation` と `GraphQL::Schema::RelayClassicMutation` の2つがあり、後者は [Relay](https://relay.dev/) の規約をサポートします。
先述のスキーマにある `clientMutationId` などは、`GraphQL::Schema::RelayClassicMutation` により自動的に追加・処理されます。

引数と返り値のフィールドを定義していきましょう。
引数は `argument` で定義します。
`field` と似ていますが、non-null の場合は `required: true` のオプションを渡します。

```ruby
module Mutations
  class UpdatePickupLocation < BaseMutation
    field :pickup_location, Types::PickupLocationType, null: true

    argument :pickup_location_id, ID, required: true
  end
end
```

続いて、リゾルバを定義します。
メソッド `#resolve` がリゾルバになり、必要な操作を行なったうえでフィールドと一致する Hash を返すようにします。
GraphQL の引数はリゾルバにキーワード引数として渡されます。

```ruby
module Mutations
  class UpdatePickupLocation < BaseMutation
    field :pickup_location, Types::PickupLocationType, null: true

    argument :pickup_location_id, ID, required: true

    def resolve(pickup_location_id:)
      pickup_location = PickupLocation.find_by(id: pickup_location_id)
      context[:current_user].update(pickup_location: pickup_location)
      { pickup_location: pickup_location }
    end
  end
end
```

これで `current_user` のデフォルトの受け取り場所を変更し、`pickup_location` を返すことができるはずです 🎉
`curl` や GraphQL Playground で動作確認してみましょう。

しかし、この実装には以下の問題があります。

- 存在しない `pickup_location_id` が渡された場合に受け取り場所が null になる
- `context[:current_user]` が nil の場合にエラーになる

これらの問題の対応は、https://graphql-ruby.org/mutations/mutation_errors.html#raising-errors などを参照しながら自分で実装してみてください。

---

[基本課題へ](03-basic.md)

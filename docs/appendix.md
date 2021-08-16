# 補足資料

## GraphQL Playground の導入

[graphql_playground-rails](https://github.com/papodaca/graphql_playground-rails) gem を使用します。

[`Gemfile`](../minimart/Gemfile) に追加して `bundle install` してください。

```diff
diff --git a/minimart/Gemfile b/minimart/Gemfile
index c390adb..6272ffc 100644
--- a/minimart/Gemfile
+++ b/minimart/Gemfile
@@ -14,6 +14,7 @@ gem 'puma', '~> 5.0'
 # gem 'rack-cors'

 gem 'graphql'
+gem 'graphql_playground-rails'
 gem 'grpc'
 gem 'ridgepole', require: false
```

次に、[`config/routes.rb`](../minimart/config/routes.rb) に以下の1行を追加してください。

```diff
diff --git a/minimart/config/routes.rb b/minimart/config/routes.rb
index 9bba2ff..a155201 100644
--- a/minimart/config/routes.rb
+++ b/minimart/config/routes.rb
@@ -1,4 +1,5 @@
 Rails.application.routes.draw do
+  mount GraphqlPlayground::Rails::Engine, at: '/', graphql_path: '/graphql'
   post "/graphql", to: "graphql#execute"
   # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 end
```

すると、http://localhost:3000 で GraphQL Playground が利用できます。

graphql_playground-rails gem の詳細は https://github.com/papodaca/graphql_playground-rails を参照してください。

## Ridgepole を用いた DB スキーマの変更

DB スキーマの定義は [`Schemafile`](../minimart/Schemafile) にあります。
このファイルに変更を加えて以下のコマンドを実行すると、現在の環境の DB スキーマに変更が適用されます。

```console
$ bin/rails ridgepole:apply
```

また、適用前に以下のコマンドを一度実行することをお勧めします。
このコマンドは、変更を適用することなく発行される SQL の表示だけを行います。

```console
$ bin/rails ridgepole:dry-run
```

これらのコマンドは rake タスクとして [`lib/tasks/ridgepole.rake`](../minimart/lib/tasks/ridgepole.rake) で定義されています。

Ridgepole の詳細は https://github.com/ridgepole/ridgepole を参照してください。

## 初期データの作成

開発用の初期データ (seed data) の追加は Rails の seed 機能を使います。

[`db/seeds.rb`](../minimart/db/seeds.rb) に Ruby コードを記述して rake タスク `db:seed` を実行すればデータが追加されます。
また、初期データの作成をやり直したい場合は `db:seed:replant` で既存のデータを削除したうえで、再度初期データの追加を行います。

詳細は [`db/seeds.rb`](../minimart/db/seeds.rb) のコメントや、rake タスクの説明を参照してください。

```console
$ bin/rails --describe db:seed
rails db:seed
    Loads the seed data from db/seeds.rb

rails db:seed:replant
    Truncates tables of each database for current environment and loads the seeds
```

ユーザーと受け取り場所のデータ作成のコードは事前に用意しているので参考にしてください。

## 画像など静的コンテンツの配信

Rails では、[`public`](../minimart/public) ディレクトリ以下にあるファイルはそのまま外部に公開されます。
今回 [`public/images/products`](../minimart/public/images/products) に商品画像として利用してよい画像をあらかじめ用意してあるので、ローカルでサーバーを起動した場合、たとえば http://localhost:3000/images/products/1.jpg でこれらにアクセスできます。

ここで、GraphQL の型 `Product` は `imageUrl` という文字列型のフィールドを持っており、上記のような画像 URL を返すことを期待されています。
しかし、アプリケーションのコンテンツについて `http://localhost:3000/images/products/1.jpg` のようにホスト名まで含んだ URL を DB に保存するべきではありません。
この例の場合、`bin/rails s -p 3001` のように 3001 番ポートで起動した場合にアクセスできなくなってしまいますし、また、後述するように静的コンテンツの配信を別のホストに切り替える可能性もあるからです。

minimart API の開発にあたっては、以下のように `GraphqlController#execute` で `request.base_url` を context に入れて渡すようにし、リゾルバでそれをもとに画像 URL を組み立てるようにしてください。

```diff
diff --git a/minimart/app/controllers/graphql_controller.rb b/minimart/app/controllers/graphql_controller.rb
index e0c4331..64adad8 100644
--- a/minimart/app/controllers/graphql_controller.rb
+++ b/minimart/app/controllers/graphql_controller.rb
@@ -10,6 +10,7 @@ class GraphqlController < ApplicationController
     operation_name = params[:operationName]
     context = {
       current_user: current_user,
+      image_base_url: request.base_url,
     }
     result = MinimartSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
     render json: result
```

```ruby
def image_url # リゾルバ
  image_path = '/images/products/1.jpg'
  File.join(context[:image_base_url], image_path)
end
```

Rails にはこのように静的コンテンツ配信のための仕組みがありますが、本番環境の設定 [`config/environments/production.rb`](../minimart/config/environments/production.rb) を見るとデフォルトではオフになっています。

```ruby
# Disable serving static files from the `/public` folder by default since
# Apache or NGINX already handles this.
config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

# Enable serving of images, stylesheets, and JavaScripts from an asset server.
# config.asset_host = 'http://assets.example.com'
```

コメントにある通り、本番環境ではアプリケーションサーバーのパフォーマンスに影響しないよう、Apache や NGINX など前段の Web サーバーでハンドリングするようにしたり、Amazon S3 など静的コンテンツに適した別のホストから配信したりするのが一般的です。

また、今回のようにレコードに画像が紐づくようなケースに関しては、Rails に [Active Storage](https://railsguides.jp/active_storage_overview.html) という仕組みもあります。

クックパッドでは、[Tofu](https://www.slideshare.net/mirakui/ss-8150494) という独自の画像配信システムを利用しています。

## Protocol Buffers をもとにした gRPC コードの生成

[grpc-tools](https://rubygems.org/gems/grpc-tools/) gem を使用します。
この gem は事前に Gemfile に追加してあり、`grpc_tools_ruby_protoc` コマンドをラップした rake タスク `grpc:protoc` も用意してあります。

```console
$ bin/rails grpc:protoc
grpc_tools_ruby_protoc --ruby_out lib --grpc_out lib --proto_path ../protobuf-definitions ../protobuf-definitions/minifinancier.proto
```

このコマンドにより、[`lib`](../minimart/lib) 以下に gRPC のコードが自動生成されます。

注意点として、Rails では `lib` 以下をオートロードの対象に含まないので、利用する際は明示的に `require` する必要があります。

```ruby
require 'minifinancier_services_pb'
```

## minifinancier の開発

minifinancier ディレクトリ以下に変更を加えたあと、`docker-compose` で動かしている minifinancier に変更を反映するにはイメージをビルドし直す必要があります。

```console
$ docker-compose -d --build
```

また、ログを確認したいときは、`docker-compose logs` を使用します。

```console
$ docker-compose logs minifinancier -f
```

minifinancier 単体の開発については [README](../minifinancier/README.md) に簡単に書いています。

## minimart-web からアクセスできるようにするための CORS の対応

minimart-web のフロントエンドから minimart API のリソースにアクセスできるようにするには、minimart API 側で [CORS](https://developer.mozilla.org/ja/docs/Web/HTTP/CORS) に対応する必要があります。

Rails で CORS を扱うには、[rack-cors](https://github.com/cyu/rack-cors) gem を使用します。
[Gemfile](../minimart/Gemfile) のコメントを外して、`bundle install` してください。

```diff
diff --git a/minimart/Gemfile b/minimart/Gemfile
index b8b75d3..5d48583 100644
--- a/minimart/Gemfile
+++ b/minimart/Gemfile
@@ -11,7 +11,7 @@ gem 'puma', '~> 5.0'
 # gem 'bcrypt', '~> 3.1.7'
 
 # Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
-# gem 'rack-cors'
+gem 'rack-cors'
 
 gem 'grpc'
 gem 'ridgepole', require: false
```

```console
$ bundle install
```

次に、[`config/initializers/cors.rb`](../minimart/config/initializers/cors.rb) で任意のオリジンから `/graphql` エンドポイントへアクセスできるよう設定を追加します。

```diff
diff --git a/minimart/config/initializers/cors.rb b/minimart/config/initializers/cors.rb
index 3b1c1b5..6892293 100644
--- a/minimart/config/initializers/cors.rb
+++ b/minimart/config/initializers/cors.rb
@@ -5,12 +5,12 @@
 
 # Read more: https://github.com/cyu/rack-cors
 
-# Rails.application.config.middleware.insert_before 0, Rack::Cors do
-#   allow do
-#     origins 'example.com'
-#
-#     resource '*',
-#       headers: :any,
-#       methods: [:get, :post, :put, :patch, :delete, :options, :head]
-#   end
-# end
+Rails.application.config.middleware.insert_before 0, Rack::Cors do
+  allow do
+    origins '*'
+
+    resource '/graphql',
+      headers: :any,
+      methods: [:get, :post, :put, :patch, :delete, :options, :head]
+  end
+end
```

CORS について詳しくは https://developer.mozilla.org/ja/docs/Web/HTTP/CORS を、rack-cors については https://github.com/cyu/rack-cors を参照してください。

## Ruby のコーディングスタイル

クックパッドでは、Ruby コーディング規準を定めて公開しています。<br>
https://github.com/cookpad/styleguide/blob/master/ruby.ja.md

Ruby のコーディングスタイルに迷ったら参考にしてください。

また、Ruby の linter/formatter として [RuboCop](https://github.com/rubocop/rubocop) という gem が標準的です。
minimart API には事前に導入してあり、以下のコマンドでクックパッドのコーディング基準に反している箇所を確認・修正できます。

```console
$ bundle exec rubocop
$ bundle exec rubocop --auto-correct
```

RuboCop の設定は [`.rubocop.yml`](../minimart/.rubocop.yml) にあります。

RuboCop について詳しくは https://github.com/rubocop/rubocop を参照してください。

## VS Code

VS Code を利用する場合は、[`cookpad-summer-internship-2021-api.code-workspace`](../cookpad-summer-internship-2021-api.code-workspace) を利用すれば、[Multi-root workspace](https://code.visualstudio.com/docs/editor/multi-root-workspaces) として開くことができます。

```console
$ code cookpad-summer-internship-2021-api.code-workspace
```

以下はおすすめの拡張機能です。

- [`rebornix.ruby`](https://marketplace.visualstudio.com/items?itemName=rebornix.Ruby)
  - デバッガや linter/formatter など、Ruby を用いた開発に便利なもろもろの機能を追加してくれます（[`.vscode/settings.json`](../minimart/.vscode/settings.json) に設定を追加しています）
- [`kaiwood.endwise`](https://marketplace.visualstudio.com/items?itemName=kaiwood.endwise)
  - `end` を自動で足してくれます
- [`castwide.solargraph`](https://marketplace.visualstudio.com/items?itemName=castwide.solargraph)
  - solargraph gem を使って intellisense や code completion をいい感じにしてくれます

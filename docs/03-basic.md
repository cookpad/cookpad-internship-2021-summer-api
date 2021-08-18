# 基本課題

minimart API で下記の GraphQL スキーマを実装してください。
Query → Mutation の順で、上から実装していくのがおすすめです。

講義やハンズオンで扱っていない次のような事柄については、[補足資料](appendix.md)を参照してください。

- Ridgepole を用いた DB スキーマの変更
- 初期データの作成
- 画像など静的コンテンツの配信
- Protocol Buffers をもとにした gRPC コードの生成

基本課題が完了したら、コミットをプッシュして講師・TAに声をかけ、発展課題に進んでください。

```graphql
scalar ISO8601DateTime

type Query {
  # リクエストしたユーザー自身を返す
  viewer: User
  
  # すべての受け取り場所を返す
  pickupLocations: [PickupLocation!]!
  
  # すべての商品を返す
  products: [Product!]!
  
  # 引数の id に該当する商品があればその商品を、なければ null を返す
  # フィールドの引数については https://graphql-ruby.org/fields/arguments.html を参照
  product(id: ID!): Product
}

type Mutation {
  # 自身のデフォルトの受け取り場所を引数で与えられた受け取り場所に変更する
  updatePickupLocation(input: UpdatePickupLocationInput!): UpdatePickupLocationPayload

  # 引数で与えられた商品で注文を作成し、minifinancier の API を叩いてユーザーに合計金額を請求する
  # 受け取り場所は、引数で与えられていればその受け取り場所を、与えられてなければユーザーのデフォルトの受け取り場所とする
  # Input Object の定義については https://graphql-ruby.org/type_definitions/input_objects.html を参照
  createOrder(input: CreateOrderInput!): CreateOrderPayload
}

type User {
  id: ID!
  name: String!

  # デフォルトの受け取り場所
  pickupLocation: PickupLocation
}

type PickupLocation {
  id: ID!
  name: String!
}

# 商品
type Product {
  id: ID!
  name: String!
  description: String!
  price: Int!
  imageUrl: String!
}

# 注文
type Order {
  id: ID!
  user: User!
  pickupLocation: PickupLocation!
  
  # 注文した商品とその個数のリスト
  items: [OrderItem!]!
  
  # 注文の合計金額
  totalAmount: Int!

  # 注文確定日時
  orderedAt: ISO8601DateTime!

  # 受け取り場所への配達日時（注文確定日の翌日正午）
  deliveryDate: ISO8601DateTime!
}

type OrderItem {
  product: Product!
  quantity: Int!
}

input UpdatePickupLocationInput {
  clientMutationId: String
  pickupLocationId: ID!
}

type UpdatePickupLocationPayload {
  clientMutationId: String
  pickupLocation: PickupLocation
}

input CreateOrderInput {
  clientMutationId: String
  items: [OrderItemInput!]!
  pickupLocationId: ID
}

input OrderItemInput {
  # 注文商品の id
  productId: ID!

  # 注文個数
  quantity: Int!
}

type CreateOrderPayload {
  clientMutationId: String
  order: Order
}
```

---

[発展課題へ](04-advanced.md)

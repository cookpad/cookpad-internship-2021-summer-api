module Types
  class OrderType < Types::BaseObject
    description '注文'

    implements GraphQL::Types::Relay::Node
    global_id_field :id

    field :user, Types::UserType, '注文したユーザー', null: false
    field :pickup_location, Types::PickupLocationType, '商品の受け取り場所', null: false
    field :items, [Types::OrderItemType], '注文した商品とその個数のリスト', null: false, method: :order_items
    field :total_amount, Integer, '合計金額', null: false
    field :ordered_at, GraphQL::Types::ISO8601DateTime, '注文確定日時', null: false
    field :delivery_date, GraphQL::Types::ISO8601DateTime, '受け取り場所への配達日時', null: false
  end
end

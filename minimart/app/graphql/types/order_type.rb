module Types
  class OrderType < Types::BaseObject
    description '注文'

    implements GraphQL::Types::Relay::Node
    global_id_field :id

    field :user, Types::UserType, '注文したユーザー', null: false
    field :pickup_location, Types::PickupLocationType, '商品の受け取り場所', null: false
    field :items, [Types::OrderItemType], '注文した商品とその個数のリスト', null: false
    field :total_amount, Integer, '合計金額', null: false
    field :ordered_at, GraphQL::Types::ISO8601DateTime, '注文確定日時', null: false
    field :delivery_date, GraphQL::Types::ISO8601DateTime, '受け取り場所への配達日時', null: false
    field :canceled_at, GraphQL::Types::ISO8601DateTime, '注文キャンセル日時', null: true

    def self.authorized?(object, context)
      super && context[:current_user]&.id == object.user_id
    end

    def user
      Loaders::AssociationLoader.for(Order, :user).load(object)
    end

    def pickup_location
      Loaders::AssociationLoader.for(Order, :pickup_location).load(object)
    end

    def items
      Loaders::AssociationLoader.for(Order, :order_items).load(object)
    end
  end
end

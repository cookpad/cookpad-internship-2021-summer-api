module Types
  class OrderType < Types::BaseObject
    field :id, ID, null: false
    field :user, Types::UserType, null: false
    field :pickup_location, Types::PickupLocationType, null: false

    field :items, [Types::OrderItemType], null: false

    def items
      OrderItem.where('order_id = ?', object.id)
    end

    field :total_amount, Integer, null: false
    field :orderedAt, GraphQL::Types::ISO8601DateTime, null: false
    field :deliveryDate, GraphQL::Types::ISO8601DateTime, null: false
  end
end

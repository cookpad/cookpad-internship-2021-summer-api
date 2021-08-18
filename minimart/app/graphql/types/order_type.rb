require 'date'

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

    field :orderedAt, GraphQL::Types::ISO8601DateTime, null: true
    def orderedAt
      object.created_at
    end

    field :deliveryDate, GraphQL::Types::ISO8601DateTime, null: true
    def deliveryDate
      delivery_date = object.created_at
      delivery_date += 1.days
      DateTime.parse(delivery_date.strftime("%Y-%m-%d 12:00:00 +0900"))
    end
  end
end

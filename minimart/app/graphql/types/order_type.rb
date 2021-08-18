module Types
  class OrderType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer, null: false
    field :pickup_location_id, Integer, null: false
    field :totalAmount, Integer, null: false
    field :deliveryDate, GraphQL::Types::ISO8601DateTime, null: false
    field :orderedAt, GraphQL::Types::ISO8601DateTime, null: false
  end
end

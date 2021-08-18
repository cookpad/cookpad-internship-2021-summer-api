module Types
  class OrderType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer, null: true
    field :pickup_location_id, Integer, null: true
    field :total_amountm, Integer, null: false
    field :orderd_at, GraphQL::Types::ISO8601DateTime, null: false
    field :delivery_date, GraphQL::Types::ISO8601DateTime, null: false
  end
end

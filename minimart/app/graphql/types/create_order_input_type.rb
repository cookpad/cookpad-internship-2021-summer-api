module Types
  class CreateOrderInputType < Types::BaseObject
    field :items, [Types::OrderItemInputType], null: false
    field :pickupLocationId, ID, null: true
  end
end

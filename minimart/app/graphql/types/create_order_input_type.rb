module Types
  class CreateOrderInputType < Types::BaseInputObject
    description "Inputs for creating an order"
    argument :items, [Types::OrderItemType], required: true
    argument :pickup_location_id, ID
  end
end
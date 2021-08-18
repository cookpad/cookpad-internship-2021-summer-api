module Types
  class CreateOrderInput < Types::BaseInputObject
    argument :items, [Types::OrderItemInput], required: true
    argument :pickup_location_id, ID, required: false
    argument :client_mutation_id, String, required: false
  end
end

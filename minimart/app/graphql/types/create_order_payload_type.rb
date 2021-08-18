module Types
  class CreateOrderPayloadType < Types::BaseObject
    field :id, ID, null: false
    field :client_mutation_id, String, null: true
    field :order_id, Integer, null: true
  end
end

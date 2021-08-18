module Types
  class OrderItemType < Types::BaseInputObject
    argument :id, ID, required: true
    argument :product_id, Integer, required: true
    argument :order_id, Integer, required: true
    argument :quantity, Integer, required: true
    argument :created_at, GraphQL::Types::ISO8601DateTime, required: true
    argument :updated_at, GraphQL::Types::ISO8601DateTime, required: true
  end
end

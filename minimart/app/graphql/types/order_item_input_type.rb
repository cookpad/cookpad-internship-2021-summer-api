module Types
  class OrderItemInputType < Types::BaseInputObject
    argument :id, ID, required: false
    argument :product_id, Integer, required: true
    argument :quantity, Integer, required: false
  end
end

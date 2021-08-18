module Types
  class OrderItemInputType < Types::BaseInputObject
    argument :product_id, ID, required: true
    argument :quantity, Integer, required: true
  end
end

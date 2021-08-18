module Types
  class OrderItemInput < Types::BaseInputObject
    argument :product_id, ID, required: true
    argument :quantity, Integer, required: true
  end
end

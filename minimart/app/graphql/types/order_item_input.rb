module Types
  class OrderItemInput < Types::BaseInputObject
    argument :product_id, ID, required: true
    argument :quantity, Integer, required: true, validates: { numericality: { greater_than: 0 } }
  end
end

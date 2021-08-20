module Types
  class OrderItemInput < Types::BaseInputObject
    argument :product_id, ID, '注文する商品の ID', required: true, loads: Types::ProductType
    argument :quantity, Integer, '注文する商品の個数', required: true, validates: { numericality: { greater_than: 0 } }
  end
end

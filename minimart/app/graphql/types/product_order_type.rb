module Types
  class ProductOrderType < Types::BaseObject
    field :product, Types::ProductType, null: false
    field :quantity, Int, null: false, method: :product_count
  end
end

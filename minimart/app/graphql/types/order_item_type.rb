module Types
  class OrderItemType < Types::BaseObject
    field :product, [Types::ProductType], null: false
    field :quantity, Integer, null: false
  end
end

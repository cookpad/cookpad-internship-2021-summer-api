module Types
  class OrderType < Types::BaseObject
    field :id, ID, null: false
    field :products, ProductType, null: true
    field :quantity, Integer, null: false
  end
end

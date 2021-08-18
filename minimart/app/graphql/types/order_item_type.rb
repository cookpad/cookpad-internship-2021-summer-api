module Types
  class OrderItemType < Types::BaseObject
    field :product_id, Integer, null: false
    field :quantity, Integer, null: false
  end
end

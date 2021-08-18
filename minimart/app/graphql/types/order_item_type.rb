module Types
  class OrderItemType < Types::BaseObject
    field :id, ID, null: false
    field :product_id, String, null: false
    field :order_id, Integer, null: true
    field :quantity, Integer, null: false
  end
end

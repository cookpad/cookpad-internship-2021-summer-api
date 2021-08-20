module Types
  class OrderItemType < Types::BaseObject
    field :product, Types::ProductType, '注文した商品', null: false
    field :quantity, Integer, '注文した商品の個数', null: false
  end
end

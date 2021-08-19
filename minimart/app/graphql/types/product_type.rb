module Types
  class ProductType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :description, null: true
    field :price, null: true
    field :imageUrl, null: true
  end
end

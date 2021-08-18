module Types
  class ProductType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: true
    field :price, Integer, null: false
    field :imageUrl, String, null: true
  end
end

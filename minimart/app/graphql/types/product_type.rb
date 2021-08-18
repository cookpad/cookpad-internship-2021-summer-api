module Types
  class ProductType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: false
    field :price, Integer, null: false
    field :image_url, String, null: false

    def image_url
      File.join(context[:image_base_url], object.image_path)
    end
  end
end

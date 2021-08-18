module Types
  class ProductType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: false
    field :price, Integer, null: false
    field :image_url, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    
    def image_url # リゾルバ
      image_path = "/images/products/1.jpg"
      File.join(context[:image_base_url], image_path)
    end
  end
end

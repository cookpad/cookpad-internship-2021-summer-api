module Types
  class ProductType < Types::BaseObject
    description '商品'

    implements GraphQL::Types::Relay::Node
    global_id_field :id

    field :name, String, '商品名', null: false
    field :description, String, '商品の詳細', null: false
    field :price, Integer, '商品の価格', null: false
    field :image_url, String, '商品画像の URL', null: false
    field :categories, [Types::CategoryType], '商品の属するカテゴリ', null: false

    def image_url
      File.join(context[:image_base_url].to_s, object.image_path)
    end

    def categories
      Loaders::AssociationLoader.for(Product, :categories).load(object)
    end
  end
end

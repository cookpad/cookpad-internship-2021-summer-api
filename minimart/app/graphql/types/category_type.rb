module Types
  class CategoryType < Types::BaseObject
    description '商品カテゴリ'

    implements GraphQL::Types::Relay::Node
    global_id_field :id

    field :id, ID, null: false
    field :name, String, 'カテゴリ名', null: false
    field :products, [Types::ProductType], 'カテゴリに属するすべての商品', null: false

    def products
      Loaders::AssociationLoader.for(Category, :products).load(object)
    end
  end
end

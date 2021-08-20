module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :pickup_locations, [Types::PickupLocationType], 'すべての受け取り場所を返す', null: false
    def pickup_locations
      PickupLocation.all
    end

    field :product, Types::ProductType, 'ID で商品を引く', null: true do
      argument :id, ID, required: true, loads: Types::ProductType, as: :product
    end
    def product(product:)
      product
    end

    field :products, [Types::ProductType], 'すべての商品を返す', null: false
    def products
      Product.all
    end

    field :viewer, Types::UserType, 'リクエストしたユーザー自身を返す', null: true
    def viewer
      context[:current_user]
    end
  end
end

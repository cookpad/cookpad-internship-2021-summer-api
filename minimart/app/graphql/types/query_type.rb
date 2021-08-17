module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :viewer, Types::UserType, null: true

    def viewer
      context[:current_user]
    end

    field :pickup_locations, [Types::PickupLocationType], null: false

    def pickup_locations
      PickupLocation.all
    end

    field :products, [Types::ProductType], null: false

    def products
      Product.all
    end

    field :product, Types::ProductType, null: true do
      argument :id, ID, required: true
    end

    def product(id:)
      Product.find_by(id: id)
    end
  end
end

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

    field :users, [Types::UserType], null: true

    def users
      User.all
    end

    field :pickup_location, [Types::PickupLocationType], null: true

    def pickUpLocation
      PickupLocation.all
    end

    field :products, [Types::ProductType], null: true

    def products
      Product.all
    end

    field :product, Types::ProductType, null: true

    def test_field
      "Hello World!"
    end
  end
end

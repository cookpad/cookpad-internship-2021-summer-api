module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end

    field :viewer, Types::UserType, null: true

    def viewer
      context[:current_user]
    end

    field :products, [Types::ProductType], null: false

    def products
      Product.all
    end

    field :product,Types::ProductType, null: false do
          argument :id, Int, required: true
    end

    def product(id:)
      Product.find_by!(id: id)
    end

    field :pickup_locations, [Types::PickupLocationType], null: false

    def pickup_locations
      PickupLocation.all
    end


  end
end

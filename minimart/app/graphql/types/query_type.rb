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

    field :pickupLocations, [Types::PickupLocationType], null: false
    def pickupLocations
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
      if product = Product.find_by(id: id)
        product
      else
        nil
      end
    end

    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end
  end
end

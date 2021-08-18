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
      argument :product_id, ID, required: true
    end

    def product(product_id:)
      res = Product.find(product_id)
      if res
        res
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

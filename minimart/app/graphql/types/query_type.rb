module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.
    field :viewer, Types::UserType, null: true
    field :pickup_locations, [Types::PickupLocationType], null: true
    field :products, [Types::ProductType], null: true
    field :product, Types::ProductType, null: true do
      argument :id, ID, required: false
    end
    field :order_item, Types::OrderItem, null:false do
      argument :id, ID, required: false
    end
    
    def viewer
      context[:current_user]
    end

    def pickup_locations
      PickupLocation.all
    end

    def products
      Product.all
    end

    def product(id:)
      a = Product.all
      a.find_by(id: id)
    end

    def order_item(id:)
      a = OrderItem.all
      a.find_by(id: id)
    end

    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end
  end
end

module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.
    field :viewer, Types::UserType, null:true
    field :pickupLocations, [Types::PickupLocationType], null:true
    field :products, [Types::ProductType], null:true

    def viewer
      context[:current_user]
    end
    
    def pickupLocations
      PickupLocation.all
    end

    
    def products
      Product.all
    end

    field :product, Types::ProductType, null:true do argument :product_id,ID,required:true 
    end
    def product(product_id:)
      Product.find_by(id: product_id)
    end
  
    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end
    

  end
end



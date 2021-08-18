module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.
    field :viewer, Types::UserType, null: true
    
    field :pickupLocations, [Types::PickupLocationType], null: false
    
   field :products, [Types::ProductType], null: true
  

    def products
      Product.all
    end
    


    def viewer
      context[:current_user]
    end
    
    def pickupLocations
      PickupLocation.all
    end


    field :product, Types::ProductType, null: false do
      argument :id, ID, required: true
    end

    def product(id:)
      if Product.find_by(id: id)
        product = Product.find_by(id: id)
      else
        raise GraphQL::ExecutionError, "Product id #{id} is not found"
      end
    end



  end
end

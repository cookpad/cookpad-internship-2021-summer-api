module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.
    field :viewer, Types::UserType, null: true
    
    field :pickupLocations, [Types::PickupLocationType], null: false

    def viewer
      context[:current_user]
    end
    
    def pickupLocations
      PickupLocation.all
    end

  end
end

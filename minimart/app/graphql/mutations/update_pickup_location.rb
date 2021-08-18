module Mutations
  class UpdatePickupLocation < BaseMutation

    field :pickup_location, Types::PickupLocationType, null: true

    argument :pickup_location_id, ID, required: true

    def resolve(pickup_location_id:)
      pickup_location = PickupLocation.find_by(id: pickup_location_id)

      unless pickup_location
        raise GraphQL::ExecutionError, "pickup_location not found"
      end

      unless context[:current_user]
        raise GraphQL::ExecutionError, "X-User-Name not set"
      end

      context[:current_user].update(pickup_location: pickup_location)
      { pickup_location: pickup_location }
    end

    # TODO: define return fields
    # field :post, Types::PostType, null: false

    # TODO: define arguments
    # argument :name, String, required: true

    # TODO: define resolve method
    # def resolve(name:)
    #   { post: ... }
    # end
  end
end

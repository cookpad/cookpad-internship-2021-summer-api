module Mutations
  class UpdatePickupLocation < BaseMutation
    field :pickup_location, Types::PickupLocationType, null: true

    argument :pickup_location_id, ID, required: true

    def resolve(pickup_location_id:)
      pickup_location = PickupLocation.find_by(id: pickup_location_id)
      if context[:current_user].update(pickup_location: pickup_location)
        { pickup_location: pickup_location }
      else
        raise GraphQL::ExecutionError, post.errors.full_messages.join(", ")
      end
    end
  end
end

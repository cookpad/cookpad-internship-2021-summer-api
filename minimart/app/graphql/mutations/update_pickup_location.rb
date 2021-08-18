module Mutations
  class UpdatePickupLocation < BaseMutation
    field :pickup_location, Types::PickupLocationType, null: true

    argument :pickup_location_id, ID, required: true

    def resolve(pickup_location_id:)
      if PickupLocation.find_by(id: pickup_location_id) && context[:current_user]
        pickup_location = PickupLocation.find_by(id: pickup_location_id)
        context[:current_user].update(pickup_location: pickup_location)
        { pickup_location: pickup_location }
      else
        raise GraphQL::ExecutionError, "Failed!"
      end
    end
  end
end

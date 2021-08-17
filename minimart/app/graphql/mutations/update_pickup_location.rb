module Mutations
  class UpdatePickupLocation < BaseMutation
    field :pickup_location, Types::PickupLocationType, null: true

    argument :pickup_location_id, ID, required: true

    def resolve(pickup_location_id:)
      raise GraphQL::ExecutionError, 'User name is required' if context[:current_user].nil?

      pickup_location = PickupLocation.find_by(id: pickup_location_id)
      raise GraphQL::ExecutionError, "No PickupLocattion found for id=#{pickup_location_id}" if pickup_location.nil?

      context[:current_user].update!(pickup_location: pickup_location)
      { pickup_location: pickup_location }
    end
  end
end

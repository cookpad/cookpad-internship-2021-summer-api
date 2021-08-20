module Mutations
  class UpdatePickupLocation < BaseMutation
    field :pickup_location, Types::PickupLocationType, null: true

    argument :pickup_location_id, ID, required: true, loads: Types::PickupLocationType

    def resolve(pickup_location:)
      raise GraphQL::ExecutionError, 'User name is required' if context[:current_user].nil?

      context[:current_user].update!(pickup_location: pickup_location)
      { pickup_location: pickup_location }
    end
  end
end

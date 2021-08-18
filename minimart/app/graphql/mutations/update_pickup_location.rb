module Mutations
  class UpdatePickupLocation < BaseMutation
    field :pickup_location, Types::PickupLocationType, null: false

    argument :pickup_location_id, ID, required: true

    def resolve(pickup_location_id:)
      pickup_location = PickupLocation.find_by(id: pickup_location_id)
      raise GraphQL::ExecutionError, "認証に失敗しました。" unless context[:current_user]
      context[:current_user].update(pickup_location: pickup_location)
      { pickup_location: pickup_location }
    end
  end
end

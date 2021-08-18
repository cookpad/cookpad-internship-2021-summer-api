module Mutations
  class UpdatePickupLocation < BaseMutation
    # TODO: define return fields
    field :pickup_location, Types::PickupLocationType, null: true

    # TODO: define arguments(引数を定義)
    argument :pickup_location_id, ID, required: true

    # TODO: define resolve method
    def resolve(pickup_location_id:)
      pickup_location = PickupLocation.find_by(id: pickup_location_id)
      context[:current_user].update(pickup_location: pickup_location)
      {pickup_location: pickup_location}
    end
  end
end


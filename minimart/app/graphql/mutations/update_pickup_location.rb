module Mutations
  class UpdatePickupLocation < BaseMutation
    #戻り値(clientMutationIdは自動的に追加)
    field :pickup_location, Types::PickupLocationType, null: true 

    argument :pickup_location_id, ID, required: true # 引数

    def resolve(pickup_location_id:)
      pickup_location = PickupLocation.find_by(id: pickup_location_id)
      context[:current_user].update(pickup_location: pickup_location)
      { pickup_location: pickup_location }
    end

  end
end

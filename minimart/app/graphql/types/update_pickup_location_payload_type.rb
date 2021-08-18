module Types
  class UpdatePickupLocationPayloadType < Types::BaseObject
    field :id, ID, null: false
    field :client_mutation_id, String, null: true
    field :pickup_location, Types::PickupLocationType, null: true
  end
end

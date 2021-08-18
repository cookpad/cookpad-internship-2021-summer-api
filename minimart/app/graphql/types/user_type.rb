module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :pickup_location, Types::PickupLocationType, null: false
  end
end

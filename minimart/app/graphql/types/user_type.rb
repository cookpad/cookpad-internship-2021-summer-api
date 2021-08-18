module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :pickup_location, Types::PickupLocationType , null: true
    field :name, String, null: false
  end
end

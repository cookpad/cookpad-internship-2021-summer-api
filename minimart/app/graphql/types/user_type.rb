module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :pickup_location_id, Integer, null: true
    field :name, String, null: false
  end
end

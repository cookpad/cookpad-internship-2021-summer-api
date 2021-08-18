module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :pickup_location, PickupLocationType, null: true #デフォルトの受け取り場所
  end
end

module Types
  class UserType < Types::BaseObject
    implements GraphQL::Types::Relay::Node
    global_id_field :id

    field :name, String, null: false
    field :pickup_location, Types::PickupLocationType, null: true
  end
end

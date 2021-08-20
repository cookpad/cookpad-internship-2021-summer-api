module Types
  class PickupLocationType < Types::BaseObject
    implements GraphQL::Types::Relay::Node
    global_id_field :id

    field :name, String, null: false
  end
end

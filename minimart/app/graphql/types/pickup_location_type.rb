module Types
  class PickupLocationType < Types::BaseObject
    description '受け取り場所'

    implements GraphQL::Types::Relay::Node
    global_id_field :id

    field :name, String, '受け取り場所の名前', null: false
  end
end

module Types
  class UserType < Types::BaseObject
    description 'ユーザー'

    implements GraphQL::Types::Relay::Node
    global_id_field :id

    field :name, String, 'ユーザー名', null: false
    field :pickup_location, PickupLocationType, 'デフォルトの受け取り場所', null: true
  end
end

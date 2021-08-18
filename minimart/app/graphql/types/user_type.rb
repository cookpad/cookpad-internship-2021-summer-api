module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :pickup_location_id, Integer, null: true
    field :name, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end

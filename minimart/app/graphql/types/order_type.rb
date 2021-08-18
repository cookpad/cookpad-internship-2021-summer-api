module Types
  class OrderType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer, null: true
    field :pickup_location, String, null: false
    field :ordered_at, String, null: false
    field :delivery_date, String, null: false
  end
end

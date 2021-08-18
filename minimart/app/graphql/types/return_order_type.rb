module Types
  class ReturnOrderType < Types::BaseObject
    field :id, ID, null: false
    field :user, Types::UserType, null: true
    field :pickup_location, Types::PickupLocationType, null: false
    field :items, [Types::OrderItemType], null: false
    field :totalAmount, Integer, null: false
    field :ordered_at, String, null: false
    field :delivery_date, String, null: false
  end
end
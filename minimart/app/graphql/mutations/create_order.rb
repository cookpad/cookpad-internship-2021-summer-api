module Mutations
  class CreateOrder < BaseMutation
    field :order, Types::OrderType, null: false

    argument :items, [Types::OrderItemType], required: true
    argument :pickup_location_id, ID, required: true

    def resolve(items:, pickup_location_id:)
      order = Order.create(
        items: items,
        pickup_location_id: pickup_location_id
      )

      order
    end
  end
end

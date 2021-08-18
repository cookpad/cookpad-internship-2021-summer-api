module Mutations
  class CreateOrder < BaseMutation
    field :order, Types::OrderType, null: false

    argument :pickup_location_id, ID, required: false
    argument :items, [Types::OrderItemInput], required: true

    def resolve(pickup_location_id: context[:current_user].pickup_location.id, items:)
      order = Order.create!(
        user: context[:current_user],
        pickup_location_id: pickup_location_id,
        total_amount: 0,
        ordered_at: "",
        delivery_date: "",
      )
      items.each do |item|
        OrderItem.create!(
          product_id: item.product_id,
          quantity: item.quantity,
          order_id: order.id
        )
      end
      puts order
      { order: order }
    end
  end
end

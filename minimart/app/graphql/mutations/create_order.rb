module Mutations
  class CreateOrder < BaseMutation
    field :order, Types::OrderType, null: true

    argument :pickup_location_id, ID, required: false
    argument :items, [Types::OrderItemInput], required: true

    def resolve(items:, pickup_location_id:)
      if pickup_location_id
        pickup_location = PickupLocation.find(pickup_location_id)
      else
        pickup_location = PickupLocation.find(context[:current_user].pickup_location_id)
      end
      order = Order.create(
        user_id: context[:current_user].id,
        pickup_location_id: pickup_location.id,
        total_amount: 0
      )
      total_amount = 0
      items.map { |item| 
        order_item = OrderItem.create(
          product_id: item.product_id,
          order_id: order.id,
          quantity: item.quantity,
        )
        total_amount += item.quantity
      }
      order.total_amount = total_amount
      {
        order: order,
      }
    end 

  end
end

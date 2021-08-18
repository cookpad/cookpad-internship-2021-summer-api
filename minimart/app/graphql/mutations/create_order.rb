require "date"

module Mutations
  class CreateOrder < BaseMutation
    field :order, Types::ReturnOrderType, null: true

    # TODO: define arguments
    argument :items, [Types::OrderItemInputType], required: true
    argument :pickup_location_id, ID, required: true

    # TODO: define resolve method
    def resolve(items:, pickup_location_id:)
      user = User.find_by(id: context[:current_user])
      pickup_location = PickupLocation.find_by(id: pickup_location_id)

      new_order = Order.new
      new_order.user = user
      new_order.pickup_location = pickup_location.id
      # 後で設定
      new_order.ordered_at = DateTime.now
      new_order.delivery_date = DateTime.new(2018, 7, 16, 10, 11, 12, '+09:00')

      new_order.save

      total = 0
      items.each do |item|
        new_order_item = OrderItem.new
        new_order_item.quantity = item.quantity
        new_order_item.product_id = item.product_id
        new_order_item.order = new_order
        new_order_item.save

        product_price = Product.find_by(id: item.product_id).price
        total = total + product_price * item.quantity
      end

      {
        order: {
          id: new_order.id,
          user: user,
          pickup_location: pickup_location,
          items: items,
          totalAmount: total,
          ordered_at: new_order.ordered_at,
          delivery_date: new_order.delivery_date
        }
      }
    end
  end
end


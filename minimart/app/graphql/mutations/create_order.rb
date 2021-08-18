module Mutations
  class CreateOrder < BaseMutation
    field :order, Types::OrderType, null: true

    argument :items, [Types::OrderItemAttributes], required: true
    argument :pickup_location_id, ID, required: false

    def resolve(items:, pickup_location_id: nil)
      order = Order.new(
        user: context[:current_user],
        pickup_location_id: pickup_location_id || context[:current_user].pickup_location.id,
        delivery_date: Time.current.tomorrow
      )

      total_amount = 0
      items.each do |item|
        product = Product.find(item.product_id)
        total_amount += product.price * item.quantity
        order.order_items.build(product: product, quantity: item.quantity)
      end

      order.total_amount = total_amount
      order.save

      { order: order }
    end
  end
end

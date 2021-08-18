module Mutations
  class CreateOrder < BaseMutation
    #return fields
    field :order, Types::OrderType, null: false

    #arguments
    argument :items, [Types::OrderItemType], null: false, required: true
    argument :pickup_location_id, ID, required: true

    #define resolve method
    def resolve(items:, pickup_location_id:){
      pickup_location = PickupLocation.find_by(id: pickup_location_id)
      order_items = items.map do |item|
        OrderItem.new(product_id: item.product_id, quantity: item.quantity)
      end
      order = Order.new(user: context[:current_user], pickup_location: pickup_location, order_items: order_items)
      {order: order}
    }
  end
end

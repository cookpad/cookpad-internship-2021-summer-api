module Mutations
  class CreateOrder < BaseMutation
    # field :client_mutation_id, String, null: false
    field :order, Types::OrderType, null: false

    argument :pickup_location_id, ID, required: true
    argument :items, [Types::OrderItemInputType], required: true

    def resolve(pickup_location_id:, items:)
      total_amount = 0
      items.each do |item|
        puts item[:product_id]
        total_amount += Product.find_by(id: item[:product_id]).price * item[:quantity].to_i
      end
      pickup_location = PickupLocation.find_by(id: pickup_location_id)
      order = Order.create!(
        user: context[:current_user],
        pickup_location: pickup_location,
        ordered_at: Time.now,
        delivery_date: Date.tomorrow + 12.hours,
        total_amount: total_amount
      )
      items.each do |item|
        ProductOrder.create!(order: order, product: Product.find_by(id: item[:product_id]), product_count: item[:quantity])
      end
      if order
        { order: order }
      else
        raise GraphQL::ExecutionError, order.error.full_messages
      end
    end
  end
end

module Mutations
  class CreateOrder < BaseMutation
    field :order, Types::OrderType, null: false

    argument :items, [Types::OrderItemInputType], required: true
    argument :pickup_location_id, ID, required: false

    def resolve(items:, pickup_location_id:)
      user = context[:current_user]
      total_amount = 0
      items.each do |item|
        puts Product.find_by(id: item.product_id).price
        total_amount += Product.find_by(id: item.product_id).price * item.quantity
      end
      pickup_location_id ||= user.pickup_location_id
      ordered_at = Date.today
      delivery_date = Date.today + 1
      { user: user.id, pickup_location: pickup_location_id, total_amount: total_amount,
        ordered_at: ordered_at, delivery_date: delivery_date }
    end
  end
end

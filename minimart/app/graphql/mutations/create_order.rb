module Mutations
  class CreateOrder < BaseMutation
    description '注文を確定する'

    field :order, Types::OrderType, '確定した注文', null: true

    argument :items, [Types::OrderItemInput], '注文する商品とその個数のリスト', required: true, validates: { length: { minimum: 1 } }
    argument :pickup_location_id, ID, '注文した商品の届け先となる受け取り場所の ID', required: false, loads: Types::PickupLocationType

    def ready?(**args)
      if context[:current_user]
        true
      else
        raise GraphQL::ExecutionError, 'User name is required'
      end
    end

    def resolve(items:, pickup_location: nil)
      order = Order.create!(
        user: context[:current_user],
        pickup_location: pickup_location || context[:current_user].pickup_location,
        order_items: items.map do |item|
          OrderItem.new(product: item.product, quantity: item.quantity)
        end,
      )

      payment = minifinancier_client.charge(
        user_id: context[:current_user].id,
        amount: order.total_amount,
      )

      order.fix!(
        minifinancier_payment_id: payment.id,
        time: Time.zone.now,
      )

      { order: order }
    end

    private

    def minifinancier_client
      Rails.configuration.x.minifinancier_client
    end
  end
end

require 'minifinancier_services_pb'

module Mutations
  class CreateOrder < BaseMutation
    field :order, Types::OrderType, null: true

    argument :items, [Types::OrderItemInput], required: true, validates: { length: { minimum: 1 } }
    argument :pickup_location_id, ID, required: false

    def resolve(items:, pickup_location_id: nil)
      raise GraphQL::ExecutionError, 'User name is required' if context[:current_user].nil?

      pickup_location = if pickup_location_id
                          PickupLocation.find_by(id: pickup_location_id)
                        else
                          context[:current_user].pickup_location
                        end
      raise GraphQL::ExecutionError, 'No PickupLocattion found' if pickup_location.nil?

      order_items = items.map do |item|
        product = Product.find_by(id: item.product_id)
        raise GraphQL::ExecutionError, "No Product found for id=#{item.product_id}" if product.nil?

        OrderItem.new(product_id: item.product_id, quantity: item.quantity)
      end

      order = Order.new(user: context[:current_user], pickup_location: pickup_location, order_items: order_items)
      order.calculate_total_amount
      order.save!

      payment_id = charge!(user_id: context[:current_user].id, amount: order.total_amount)

      order.fix!(minifinancier_payment_id: payment_id, time: Time.zone.now)

      { order: order }
    end

    private

    def charge!(user_id:, amount:)
      payment_gateway_service = Minifinancier::PaymentGateway::Stub.new(
        ENV.fetch('MINIFINANCIER_HOST', 'localhost:50051'),
        ENV['ENABLE_GRPC_TLS'] ? GRPC::Core::ChannelCredentials.new : :this_channel_is_insecure,
      )
      request = Minifinancier::ChargeRequest.new(user_id: user_id, amount: amount)
      payment = payment_gateway_service.charge(request)
      payment.id
    end
  end
end

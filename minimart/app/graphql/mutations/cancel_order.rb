module Mutations
  class CancelOrder < BaseMutation
    description '注文をキャンセルする'

    field :order, Types::OrderType, 'キャンセルした注文', null: true

    argument :order_id, ID, 'キャンセルしたい注文の ID', required: true, loads: Types::OrderType

    def resolve(order:)
      begin
        order.cancel!(time: Time.zone.now)
      rescue Order::AlreadyCanceledError => e
        context.add_error(GraphQL::ExecutionError.new(e.message))
        return { order: order }
      rescue Order::NotCancelableError => e
        raise GraphQL::ExecutionError, e.message
      end

      minifinancier_client.refund(order.minifinancier_payment_id)

      { order: order }
    end

    private

    def minifinancier_client
      Rails.configuration.x.minifinancier_client
    end
  end
end

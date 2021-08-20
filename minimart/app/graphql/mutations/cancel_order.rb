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

      { order: order }
    end
  end
end

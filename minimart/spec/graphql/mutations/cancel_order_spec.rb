require 'rails_helper'

RSpec.describe 'GraphQL mutation: cancelOrder(input: CancelOrderInput!)' do
  let(:query) do
    <<~GRAPHQL
      mutation($orderId: ID!) {
        cancelOrder(input: { orderId: $orderId }) {
          order {
            canceledAt
          }
        }
      }
    GRAPHQL
  end
  let(:variables) { { orderId: MinimartSchema.id_from_object(order, Types::OrderType) } }
  let(:context) { { current_user: user } }

  let(:order) { create(:order_with_item, user: user) }
  let(:user) { create(:user) }

  context 'with valid condition' do
    it 'cancels the order' do
      result = MinimartSchema.execute(query, context: context, variables: variables)

      expect(order.reload).to be_canceled
      expect(result.to_h).not_to include('errors')
      expect(result['data']['cancelOrder']['order']['canceledAt']).to be_present
    end
  end

  context 'when the order have been canceled' do
    before do
      order.update!(canceled_at: Time.zone.now)
    end

    it 'returns an error and an order' do
      result = MinimartSchema.execute(query, context: context, variables: variables)

      expect(result['errors']).to match([hash_including('message' => 'Already canceled')])
      expect(result['data']['cancelOrder']['order']['canceledAt']).to be_present
    end
  end

  context 'when the order is not cancelable' do
    let(:order) { create(:order_with_item, user: user, ordered_at: 1.day.ago) }

    it 'returns an error' do
      result = MinimartSchema.execute(query, context: context, variables: variables)

      expect(order.reload).not_to be_canceled
      expect(result['errors']).to match([hash_including('message' => 'Cancellation deadline exceeded')])
    end
  end
end

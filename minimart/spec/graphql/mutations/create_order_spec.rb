require 'rails_helper'

RSpec.describe 'GraphQL mutation: createOrder(input: CreateOrderInput!)' do
  let(:query) do
    <<~GRAPHQL
      mutation($items: [OrderItemInput!]!, $pickupLocationId: ID) {
        createOrder(input: { items: $items, pickupLocationId: $pickupLocationId }) {
          order {
            id
          }
        }
      }
    GRAPHQL
  end
  let(:variables) do
    {
      items: products.map do |product|
        { productId: MinimartSchema.id_from_object(product, Types::ProductType), quantity: 1 }
      end,
    }
  end
  let(:context) { { current_user: user } }

  let(:products) { create_list(:product, 3) }
  let(:user) { create(:user) }

  context 'with valid condition' do
    it 'creates an order' do
      result = MinimartSchema.execute(query, context: context, variables: variables)

      expect(user.paid_orders.size).to eq 1
      expect(user.paid_orders.first.order_items.size).to eq 3
      expect(result.to_h).not_to include('errors')
      expect(result['data']['createOrder']['order']['id']).to be_present
    end
  end

  context 'with pickup_location_id' do
    let(:variables) do
      {
        items: [{ productId: MinimartSchema.id_from_object(products.first, Types::ProductType), quantity: 2 }],
        pickupLocationId: MinimartSchema.id_from_object(pickup_location, Types::PickupLocationType),
      }
    end
    let(:pickup_location) { create(:pickup_location) }

    it 'creates an order with the given pickup location' do
      result = MinimartSchema.execute(query, context: context, variables: variables)

      expect(user.paid_orders.size).to eq 1
      expect(user.paid_orders.first.pickup_location_id).to eq pickup_location.id
      expect(result.to_h).not_to include('errors')
      expect(result['data']['createOrder']['order']['id']).to be_present
    end
  end

  context 'with blank items' do
    let(:variables) { { items: [] } }

    it 'returns an error' do
      result = MinimartSchema.execute(query, context: context, variables: variables)

      expect(user.paid_orders).to be_empty
      expect(result['errors'].size).to eq 1
    end
  end

  context 'without pickup_location' do
    let(:user) { create(:user, pickup_location: nil) }

    it 'returns an error' do
      result = MinimartSchema.execute(query, context: context, variables: variables)

      expect(user.paid_orders).to be_empty
      expect(result['errors']).to match([hash_including('message' => /validation failed/)])
    end
  end

  context 'without user' do
    let(:context) { {} }

    it 'returns an error' do
      result = MinimartSchema.execute(query, context: context, variables: variables)

      expect(user.paid_orders).to be_empty
      expect(result['errors']).to match([hash_including('message' => 'User name is required')])
    end
  end
end

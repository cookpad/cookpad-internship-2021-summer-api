require 'rails_helper'

RSpec.describe 'GraphQL query: order(id: ID!)' do
  let(:query) do
    <<~GRAPHQL
      query($id: ID!) {
        order(id: $id) {
          id
          user {
            name
          }
          pickupLocation {
            name
          }
          items {
            product {
              name
            }
            quantity
          }
          totalAmount
          orderedAt
          deliveryDate
        }
      }
    GRAPHQL
  end
  let(:variables) { { id: MinimartSchema.id_from_object(order, Types::OrderType) } }
  let(:context) { { current_user: user } }

  let(:order) do
    create(
      :order_with_item,
      user: user,
      ordered_at: Time.zone.parse('2021-08-18T12:34:56+09:00'),
      delivery_date: Time.zone.parse('2021-08-19T12:00:00+09:00'),
    )
  end
  let(:user) { create(:user, name: 'tomart') }

  it 'returns an order' do
    result = MinimartSchema.execute(query, context: context, variables: variables)

    expect(result.to_h).not_to include('errors')
    expect(result['data'].deep_symbolize_keys).to match(
      {
        order: {
          id: String,
          user: {
            name: 'tomart',
          },
          pickupLocation: {
            name: String,
          },
          items: [
            {
              product: {
                name: String,
              },
              quantity: Integer,
            },
          ],
          totalAmount: Integer,
          orderedAt: '2021-08-18T12:34:56+09:00',
          deliveryDate: '2021-08-19T12:00:00+09:00',
        },
      },
    )
  end

  context 'with invalid user' do
    let(:context) { { current_user: create(:user) } }

    it 'returns null' do
      result = MinimartSchema.execute(query, context: context, variables: variables)

      expect(result.to_h).not_to include('errors')
      expect(result['data']['order']).to be_nil
    end
  end
end

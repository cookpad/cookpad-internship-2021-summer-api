require 'rails_helper'

RSpec.describe 'GraphQL query: orders' do
  let(:query) do
    <<~GRAPHQL
      query {
        orders {
          id
        }
      }
    GRAPHQL
  end
  let(:context) { { current_user: user } }
  let(:user) { create(:user) }

  before do
    create_list(:order_with_item, 3, user: user)
  end

  it 'returns orders' do
    result = MinimartSchema.execute(query, context: context)

    expect(result.to_h).not_to include('errors')
    expect(result['data']['orders'].size).to eq 3
  end

  context 'without user' do
    let(:context) { {} }

    it 'returns an empty array' do
      result = MinimartSchema.execute(query, context: context)

      expect(result.to_h).not_to include('errors')
      expect(result['data']['orders']).to be_empty
    end
  end
end

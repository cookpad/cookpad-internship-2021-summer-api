require 'rails_helper'

RSpec.describe 'GraphQL query: viewer' do
  let(:query) do
    <<~GRAPHQL
      query {
        viewer {
          id
          name
          pickupLocation {
            id
            name
          }
        }
      }
    GRAPHQL
  end
  let(:context) { { current_user: user } }
  let(:user) { create(:user, name: 'tomart') }

  it 'returns the viewer' do
    result = MinimartSchema.execute(query, context: context)

    expect(result.to_h).not_to include('errors')
    expect(result['data'].deep_symbolize_keys).to match(
      {
        viewer: {
          id: String,
          name: 'tomart',
          pickupLocation: {
            id: String,
            name: String,
          },
        },
      },
    )
  end

  context 'without user' do
    let(:context) { {} }

    it 'returns null' do
      result = MinimartSchema.execute(query, context: context)

      expect(result.to_h).not_to include('errors')
      expect(result['data']['viewer']).to be_nil
    end
  end
end

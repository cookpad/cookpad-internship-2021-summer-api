require 'rails_helper'

RSpec.describe 'GraphQL query: pickupLocations' do
  let(:query) do
    <<~GRAPHQL
      query {
        pickupLocations {
          id
        }
      }
    GRAPHQL
  end

  before do
    create_list(:pickup_location, 3)
  end

  it 'returns pickup locations' do
    result = MinimartSchema.execute(query)

    expect(result.to_h).not_to include('errors')
    expect(result['data']['pickupLocations'].size).to eq 3
  end
end

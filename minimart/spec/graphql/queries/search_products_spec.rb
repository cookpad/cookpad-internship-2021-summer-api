require 'rails_helper'

RSpec.describe 'GraphQL query: searchProducts(query: String!)' do
  let(:query) do
    <<~GRAPHQL
      query($query: String!) {
        searchProducts(query: $query) {
          name
        }
      }
    GRAPHQL
  end
  let(:variables) { { query: 'トマト' } }

  before do
    create(:product, name: 'トマト')
    create(:product, name: 'レタス')
  end

  it 'returns products matched with the given query' do
    result = MinimartSchema.execute(query, variables: variables)

    expect(result.to_h).not_to include('errors')
    expect(result['data']['searchProducts']).to eq([{ 'name' => 'トマト' }])
  end
end

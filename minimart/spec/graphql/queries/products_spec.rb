require 'rails_helper'

RSpec.describe 'GraphQL query: products' do
  let(:query) do
    <<~GRAPHQL
      query {
        products {
          id
        }
      }
    GRAPHQL
  end

  before do
    create_list(:product, 3)
  end

  it 'returns products' do
    result = MinimartSchema.execute(query)

    expect(result.to_h).not_to include('errors')
    expect(result['data']['products'].size).to eq 3
  end
end

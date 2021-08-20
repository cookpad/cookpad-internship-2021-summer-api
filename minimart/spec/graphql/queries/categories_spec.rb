require 'rails_helper'

RSpec.describe 'GraphQL query: categories' do
  let(:query) do
    <<~GRAPHQL
      query {
        categories {
          id
        }
      }
    GRAPHQL
  end

  before do
    create_list(:category, 3)
  end

  it 'returns categories' do
    result = MinimartSchema.execute(query)

    expect(result.to_h).not_to include('errors')
    expect(result['data']['categories'].size).to eq 3
  end
end

require 'rails_helper'

RSpec.describe 'GraphQL query: category' do
  let(:query) do
    <<~GRAPHQL
      query($id: ID!) {
        category(id: $id) {
          id
          name
          products {
            id
          }
        }
      }
    GRAPHQL
  end
  let(:variables) { { id: MinimartSchema.id_from_object(category, Types::CategoryType) } }
  let(:category) { create(:category, name: '野菜') }

  before do
    create_list(:product, 3, categories: [category])
  end

  it 'returns a category' do
    result = MinimartSchema.execute(query, variables: variables)

    expect(result.to_h).not_to include('errors')
    expect(result['data'].deep_symbolize_keys).to match(
      {
        category: {
          id: String,
          name: '野菜',
          products: [
            { id: String },
            { id: String },
            { id: String },
          ],
        },
      },
    )
  end
end

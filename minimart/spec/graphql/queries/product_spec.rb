require 'rails_helper'

RSpec.describe 'GraphQL query: product(id: ID!)' do
  let(:query) do
    <<~GRAPHQL
      query($id: ID!) {
        product(id: $id) {
          id
          name
          description
          price
          imageUrl
        }
      }
    GRAPHQL
  end
  let(:variables) { { id: MinimartSchema.id_from_object(product, Types::ProductType) } }
  let(:product) { create(:product, name: 'トマト', description: '新鮮なトマト', price: 150, image_path: '/tomato.jpg') }

  it 'returns a product' do
    result = MinimartSchema.execute(query, variables: variables)

    expect(result.to_h).not_to include('errors')
    expect(result['data'].deep_symbolize_keys).to match(
      {
        product: {
          id: String,
          name: 'トマト',
          description: '新鮮なトマト',
          price: 150,
          imageUrl: %r{/tomato.jpg\z},
        },
      },
    )
  end
end

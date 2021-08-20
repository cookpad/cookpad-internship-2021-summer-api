require 'rails_helper'

RSpec.describe 'current_user', type: :request do
  describe 'POST /graphql with query "{viewer{name}}"' do
    let(:query) do
      <<~GRAPHQL
        query {
          viewer {
            name
          }
        }
      GRAPHQL
    end

    context 'with X-User-Name request header' do
      let(:headers) { { 'X-User-Name': 'tomart' } }

      it 'assigns current_user' do
        post graphql_path, headers: headers, params: { query: query }

        expect(response).to have_http_status :ok
        parsed_body = JSON.parse(response.body, symbolize_names: true)
        expect(parsed_body).to eq({ data: { viewer: { name: 'tomart' } } })
      end
    end

    context 'without X-User-Name request header' do
      let(:headers) { {} }

      it 'does not assign current_user' do
        post graphql_path, headers: headers, params: { query: query }

        expect(response).to have_http_status :ok
        parsed_body = JSON.parse(response.body, symbolize_names: true)
        expect(parsed_body).to eq({ data: { viewer: nil } })
      end
    end
  end
end

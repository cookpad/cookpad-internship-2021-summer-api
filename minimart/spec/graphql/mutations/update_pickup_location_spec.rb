require 'rails_helper'

RSpec.describe 'GraphQL mutation: updatePickupLocation(input: UpdatePickupLocationInput!)' do
  let(:query) do
    <<~GRAPHQL
      mutation($pickupLocationId: ID!) {
        updatePickupLocation(input: { pickupLocationId: $pickupLocationId }) {
          pickupLocation {
            name
          }
        }
      }
    GRAPHQL
  end
  let(:variables) { { pickupLocationId: MinimartSchema.id_from_object(pickup_location, Types::PickupLocationType) } }
  let(:context) { { current_user: user } }

  let(:pickup_location) { create(:pickup_location, name: 'WMM') }
  let(:user) { create(:user, pickup_location: create(:pickup_location)) }

  context 'with valid condition' do
    it 'updates pickup_location of current user' do
      result = MinimartSchema.execute(query, context: context, variables: variables)

      expect(user.reload.pickup_location.name).to eq 'WMM'
      expect(result.to_h).not_to include('errors')
      expect(result['data']['updatePickupLocation']['pickupLocation']['name']).to eq 'WMM'
    end
  end

  context 'with invalid pickup_location_id' do
    let(:variables) { { pickupLocationId: MinimartSchema.id_from_object(user, Types::UserType) } }

    it 'returns an error' do
      result = MinimartSchema.execute(query, context: context, variables: variables)

      expect(user.reload.pickup_location.name).not_to eq 'WMM'
      expect(result['errors'].size).to eq 1
    end
  end

  context 'without user' do
    let(:context) { {} }

    it 'returns an error' do
      result = MinimartSchema.execute(query, context: context, variables: variables)

      expect(user.reload.pickup_location.name).not_to eq 'WMM'
      expect(result['errors']).to match([hash_including('message' => 'User name is required')])
    end
  end
end

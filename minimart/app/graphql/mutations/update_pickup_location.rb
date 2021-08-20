module Mutations
  class UpdatePickupLocation < BaseMutation
    description '自身のデフォルトの受け取り場所を変更する'

    field :pickup_location, Types::PickupLocationType, '変更後のデフォルトの受け取り場所', null: true

    argument :pickup_location_id, ID, 'デフォルトにしたい受け取り場所の ID', required: true, loads: Types::PickupLocationType

    def ready?(**args)
      if context[:current_user]
        true
      else
        raise GraphQL::ExecutionError, 'User name is required'
      end
    end

    def resolve(pickup_location:)
      context[:current_user].update!(pickup_location: pickup_location)
      { pickup_location: pickup_location }
    end
  end
end

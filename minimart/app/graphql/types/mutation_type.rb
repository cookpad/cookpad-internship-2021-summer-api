module Types
  class MutationType < Types::BaseObject
    field :update_pickup_location, mutation: Mutations::UpdatePickupLocation, description: "ユーザー自身のデフォルトの受け取り場所を変更する"


  end
end

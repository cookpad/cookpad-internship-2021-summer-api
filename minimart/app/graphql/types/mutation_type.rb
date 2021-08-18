module Types
  class MutationType < Types::BaseObject
    field :create_order, mutation: Mutations::CreateOrder, description: "注文を作成"
    field :update_pickup_location, mutation: Mutations::UpdatePickupLocation, description: "ユーザー自身のデフォルトの受け取り場所を変更する"
  
  end
end

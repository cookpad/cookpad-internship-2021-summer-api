module Mutations
  class CreateOrder < BaseMutation
    field :order, Types::OrderType, null: true

    argument :items, [OrderItemType], required: true
    argument :pickup_location_id, ID

    def resolve()
    end  
    # TODO: define return fields
    # field :post, Types::PostType, null: false

    # TODO: define arguments
    # argument :name, String, required: true

    # TODO: define resolve method
    # def resolve(name:)
    #   { post: ... }
    # end
  end
end

module Types
  class BaseInputObject < GraphQL::Schema::InputObject
    argument_class Types::BaseArgument
  end

  class OrderItemInput < Types::BaseInputObject
    argument :product_id, ID, required: true
    argument :quantity, Integer, required: true
  end
end

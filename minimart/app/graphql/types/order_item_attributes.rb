module Types
  class OrderItemAttributes < BaseInputObject
    description "createOrder MutationのitemsフィールドのInput"
    argument :product_id, ID, required: true
    argument :quantity, Int, required: true
  end
end

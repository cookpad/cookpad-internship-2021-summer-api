module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.
    field :viewer, Types::UserType, null: true
    field :pickup_locations, [Types::PickupLocationType], null: false
    field :products, [Types::ProductType], null: false

    field :product, Types::ProductType, null: false do
      argument :id, ID, required: true
    end

    def viewer
      context[:current_user]
    end

    def pickup_locations
      PickupLocation.all
    end

    def products
      products = Product.all
      products.each do |product|
        product.image_url = set_image_url(product)
      end
      products
    end

    def product(id:)
      product = Product.find_by(id: id)
      product.image_url = set_image_url(product)
      product
    end

    def set_image_url(product)
      File.join(context[:image_base_url], product.image_url)
    end
  end
end

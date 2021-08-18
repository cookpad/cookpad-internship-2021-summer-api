module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.
    field :viewer, Types::UserType, null: true

    def viewer
      context[:current_user]
    end

    field :pickup_locations, [Types::PickupLocationType], null: true

    def pickup_locations
      PickupLocation.all
    end

    field :products, [Types::ProductType], null: true

    def products
      products = Product.all.map do |product|
        product.image_url = image_url(product.image_url)
        product
      end
      products
    end

    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end

    private

    def image_url(image_url)
      image_path = "/images/products/#{image_url}"
      File.join(context[:image_base_url], image_path)
    end
  end
end

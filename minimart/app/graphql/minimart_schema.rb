class MinimartSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  rescue_from(ActiveRecord::RecordNotFound) do |err, obj, args, ctx, field|
    raise GraphQL::ExecutionError, "#{field.type.unwrap.graphql_name} not found"
  end

  # Union and Interface Resolution
  def self.resolve_type(abstract_type, obj, ctx)
    type_class_name = "#{obj.class.name}Type"
    if Types.const_defined?(type_class_name)
      Types.const_get(type_class_name)
    else
      raise "Unexpected object: #{obj}"
    end
  end

  # Relay-style Object Identification:

  # Return a string UUID for `object`
  def self.id_from_object(object, type_definition, query_ctx)
    # Here's a simple implementation which:
    # - joins the type name & object.id
    # - encodes it with base64:
    GraphQL::Schema::UniqueWithinType.encode(type_definition.graphql_name, object.id)
  end

  # Given a string UUID, find the object
  def self.object_from_id(id, query_ctx)
    graphql_type_name, item_id = GraphQL::Schema::UniqueWithinType.decode(id)
    graphql_type_name.constantize.find(item_id)
  end
end

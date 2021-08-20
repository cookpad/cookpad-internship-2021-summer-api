require 'minifinancier_services_pb'

class MinifinancierClient
  def initialize(host:, enable_tls:)
    @host = host
    @enable_tls = enable_tls
  end

  def charge(user_id:, amount:)
    request = Minifinancier::ChargeRequest.new(user_id: user_id, amount: amount)
    payment_gateway_service.charge(request)
  end

  private

  def payment_gateway_service
    @payment_gateway_service ||= Minifinancier::PaymentGateway::Stub.new(
      @host,
      @enable_tls ? GRPC::Core::ChannelCredentials.new : :this_channel_is_insecure,
    )
  end
end

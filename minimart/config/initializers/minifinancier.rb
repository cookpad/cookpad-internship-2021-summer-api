require 'minifinancier_client'

Rails.configuration.x.minifinancier_client = MinifinancierClient.new(
  host: ENV.fetch('MINIFINANCIER_HOST', 'localhost:50051'),
  enable_tls: ENV['ENABLE_GRPC_TLS'].present?,
)

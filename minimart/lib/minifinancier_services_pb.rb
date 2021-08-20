# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: minifinancier.proto for package 'minifinancier'

require 'grpc'
require 'minifinancier_pb'

module Minifinancier
  module PaymentGateway
    class Service

      include ::GRPC::GenericService

      self.marshal_class_method = :encode
      self.unmarshal_class_method = :decode
      self.service_name = 'minifinancier.PaymentGateway'

      # ユーザーに請求を行う
      rpc :Charge, ::Minifinancier::ChargeRequest, ::Minifinancier::Payment
      # 引数の請求に対して返金を行う
      rpc :Refund, ::Minifinancier::RefundRequest, ::Minifinancier::Payment
      # ヘルスチェック
      rpc :CheckHealth, ::Minifinancier::HealthCheckRequest, ::Minifinancier::Health
    end

    Stub = Service.rpc_stub_class
  end
end

// GENERATED CODE -- DO NOT EDIT!

'use strict';
var grpc = require('@grpc/grpc-js');
var minifinancier_pb = require('./minifinancier_pb.js');
var google_protobuf_timestamp_pb = require('google-protobuf/google/protobuf/timestamp_pb.js');

function serialize_minifinancier_ChargeRequest(arg) {
  if (!(arg instanceof minifinancier_pb.ChargeRequest)) {
    throw new Error('Expected argument of type minifinancier.ChargeRequest');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_minifinancier_ChargeRequest(buffer_arg) {
  return minifinancier_pb.ChargeRequest.deserializeBinary(new Uint8Array(buffer_arg));
}

function serialize_minifinancier_Health(arg) {
  if (!(arg instanceof minifinancier_pb.Health)) {
    throw new Error('Expected argument of type minifinancier.Health');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_minifinancier_Health(buffer_arg) {
  return minifinancier_pb.Health.deserializeBinary(new Uint8Array(buffer_arg));
}

function serialize_minifinancier_HealthCheckRequest(arg) {
  if (!(arg instanceof minifinancier_pb.HealthCheckRequest)) {
    throw new Error('Expected argument of type minifinancier.HealthCheckRequest');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_minifinancier_HealthCheckRequest(buffer_arg) {
  return minifinancier_pb.HealthCheckRequest.deserializeBinary(new Uint8Array(buffer_arg));
}

function serialize_minifinancier_Payment(arg) {
  if (!(arg instanceof minifinancier_pb.Payment)) {
    throw new Error('Expected argument of type minifinancier.Payment');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_minifinancier_Payment(buffer_arg) {
  return minifinancier_pb.Payment.deserializeBinary(new Uint8Array(buffer_arg));
}


var PaymentGatewayService = exports.PaymentGatewayService = {
  // ユーザーに請求を行う
charge: {
    path: '/minifinancier.PaymentGateway/Charge',
    requestStream: false,
    responseStream: false,
    requestType: minifinancier_pb.ChargeRequest,
    responseType: minifinancier_pb.Payment,
    requestSerialize: serialize_minifinancier_ChargeRequest,
    requestDeserialize: deserialize_minifinancier_ChargeRequest,
    responseSerialize: serialize_minifinancier_Payment,
    responseDeserialize: deserialize_minifinancier_Payment,
  },
  // ヘルスチェック
checkHealth: {
    path: '/minifinancier.PaymentGateway/CheckHealth',
    requestStream: false,
    responseStream: false,
    requestType: minifinancier_pb.HealthCheckRequest,
    responseType: minifinancier_pb.Health,
    requestSerialize: serialize_minifinancier_HealthCheckRequest,
    requestDeserialize: deserialize_minifinancier_HealthCheckRequest,
    responseSerialize: serialize_minifinancier_Health,
    responseDeserialize: deserialize_minifinancier_Health,
  },
};

exports.PaymentGatewayClient = grpc.makeGenericClientConstructor(PaymentGatewayService);

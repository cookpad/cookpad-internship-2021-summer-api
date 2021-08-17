// package: minifinancier
// file: minifinancier.proto

/* tslint:disable */
/* eslint-disable */

import * as grpc from "@grpc/grpc-js";
import * as minifinancier_pb from "./minifinancier_pb";
import * as google_protobuf_timestamp_pb from "google-protobuf/google/protobuf/timestamp_pb";

interface IPaymentGatewayService extends grpc.ServiceDefinition<grpc.UntypedServiceImplementation> {
    charge: IPaymentGatewayService_ICharge;
    checkHealth: IPaymentGatewayService_ICheckHealth;
}

interface IPaymentGatewayService_ICharge extends grpc.MethodDefinition<minifinancier_pb.ChargeRequest, minifinancier_pb.Payment> {
    path: "/minifinancier.PaymentGateway/Charge";
    requestStream: false;
    responseStream: false;
    requestSerialize: grpc.serialize<minifinancier_pb.ChargeRequest>;
    requestDeserialize: grpc.deserialize<minifinancier_pb.ChargeRequest>;
    responseSerialize: grpc.serialize<minifinancier_pb.Payment>;
    responseDeserialize: grpc.deserialize<minifinancier_pb.Payment>;
}
interface IPaymentGatewayService_ICheckHealth extends grpc.MethodDefinition<minifinancier_pb.HealthCheckRequest, minifinancier_pb.Health> {
    path: "/minifinancier.PaymentGateway/CheckHealth";
    requestStream: false;
    responseStream: false;
    requestSerialize: grpc.serialize<minifinancier_pb.HealthCheckRequest>;
    requestDeserialize: grpc.deserialize<minifinancier_pb.HealthCheckRequest>;
    responseSerialize: grpc.serialize<minifinancier_pb.Health>;
    responseDeserialize: grpc.deserialize<minifinancier_pb.Health>;
}

export const PaymentGatewayService: IPaymentGatewayService;

export interface IPaymentGatewayServer extends grpc.UntypedServiceImplementation {
    charge: grpc.handleUnaryCall<minifinancier_pb.ChargeRequest, minifinancier_pb.Payment>;
    checkHealth: grpc.handleUnaryCall<minifinancier_pb.HealthCheckRequest, minifinancier_pb.Health>;
}

export interface IPaymentGatewayClient {
    charge(request: minifinancier_pb.ChargeRequest, callback: (error: grpc.ServiceError | null, response: minifinancier_pb.Payment) => void): grpc.ClientUnaryCall;
    charge(request: minifinancier_pb.ChargeRequest, metadata: grpc.Metadata, callback: (error: grpc.ServiceError | null, response: minifinancier_pb.Payment) => void): grpc.ClientUnaryCall;
    charge(request: minifinancier_pb.ChargeRequest, metadata: grpc.Metadata, options: Partial<grpc.CallOptions>, callback: (error: grpc.ServiceError | null, response: minifinancier_pb.Payment) => void): grpc.ClientUnaryCall;
    checkHealth(request: minifinancier_pb.HealthCheckRequest, callback: (error: grpc.ServiceError | null, response: minifinancier_pb.Health) => void): grpc.ClientUnaryCall;
    checkHealth(request: minifinancier_pb.HealthCheckRequest, metadata: grpc.Metadata, callback: (error: grpc.ServiceError | null, response: minifinancier_pb.Health) => void): grpc.ClientUnaryCall;
    checkHealth(request: minifinancier_pb.HealthCheckRequest, metadata: grpc.Metadata, options: Partial<grpc.CallOptions>, callback: (error: grpc.ServiceError | null, response: minifinancier_pb.Health) => void): grpc.ClientUnaryCall;
}

export class PaymentGatewayClient extends grpc.Client implements IPaymentGatewayClient {
    constructor(address: string, credentials: grpc.ChannelCredentials, options?: Partial<grpc.ClientOptions>);
    public charge(request: minifinancier_pb.ChargeRequest, callback: (error: grpc.ServiceError | null, response: minifinancier_pb.Payment) => void): grpc.ClientUnaryCall;
    public charge(request: minifinancier_pb.ChargeRequest, metadata: grpc.Metadata, callback: (error: grpc.ServiceError | null, response: minifinancier_pb.Payment) => void): grpc.ClientUnaryCall;
    public charge(request: minifinancier_pb.ChargeRequest, metadata: grpc.Metadata, options: Partial<grpc.CallOptions>, callback: (error: grpc.ServiceError | null, response: minifinancier_pb.Payment) => void): grpc.ClientUnaryCall;
    public checkHealth(request: minifinancier_pb.HealthCheckRequest, callback: (error: grpc.ServiceError | null, response: minifinancier_pb.Health) => void): grpc.ClientUnaryCall;
    public checkHealth(request: minifinancier_pb.HealthCheckRequest, metadata: grpc.Metadata, callback: (error: grpc.ServiceError | null, response: minifinancier_pb.Health) => void): grpc.ClientUnaryCall;
    public checkHealth(request: minifinancier_pb.HealthCheckRequest, metadata: grpc.Metadata, options: Partial<grpc.CallOptions>, callback: (error: grpc.ServiceError | null, response: minifinancier_pb.Health) => void): grpc.ClientUnaryCall;
}

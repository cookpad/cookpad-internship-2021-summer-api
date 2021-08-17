// package: minifinancier
// file: minifinancier.proto

/* tslint:disable */
/* eslint-disable */

import * as jspb from "google-protobuf";
import * as google_protobuf_timestamp_pb from "google-protobuf/google/protobuf/timestamp_pb";

export class ChargeRequest extends jspb.Message { 
    getUserId(): number;
    setUserId(value: number): ChargeRequest;
    getAmount(): number;
    setAmount(value: number): ChargeRequest;

    serializeBinary(): Uint8Array;
    toObject(includeInstance?: boolean): ChargeRequest.AsObject;
    static toObject(includeInstance: boolean, msg: ChargeRequest): ChargeRequest.AsObject;
    static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
    static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
    static serializeBinaryToWriter(message: ChargeRequest, writer: jspb.BinaryWriter): void;
    static deserializeBinary(bytes: Uint8Array): ChargeRequest;
    static deserializeBinaryFromReader(message: ChargeRequest, reader: jspb.BinaryReader): ChargeRequest;
}

export namespace ChargeRequest {
    export type AsObject = {
        userId: number,
        amount: number,
    }
}

export class Payment extends jspb.Message { 
    getId(): string;
    setId(value: string): Payment;
    getUserId(): number;
    setUserId(value: number): Payment;
    getAmount(): number;
    setAmount(value: number): Payment;

    hasCreateTime(): boolean;
    clearCreateTime(): void;
    getCreateTime(): google_protobuf_timestamp_pb.Timestamp | undefined;
    setCreateTime(value?: google_protobuf_timestamp_pb.Timestamp): Payment;

    serializeBinary(): Uint8Array;
    toObject(includeInstance?: boolean): Payment.AsObject;
    static toObject(includeInstance: boolean, msg: Payment): Payment.AsObject;
    static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
    static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
    static serializeBinaryToWriter(message: Payment, writer: jspb.BinaryWriter): void;
    static deserializeBinary(bytes: Uint8Array): Payment;
    static deserializeBinaryFromReader(message: Payment, reader: jspb.BinaryReader): Payment;
}

export namespace Payment {
    export type AsObject = {
        id: string,
        userId: number,
        amount: number,
        createTime?: google_protobuf_timestamp_pb.Timestamp.AsObject,
    }
}

export class HealthCheckRequest extends jspb.Message { 

    serializeBinary(): Uint8Array;
    toObject(includeInstance?: boolean): HealthCheckRequest.AsObject;
    static toObject(includeInstance: boolean, msg: HealthCheckRequest): HealthCheckRequest.AsObject;
    static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
    static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
    static serializeBinaryToWriter(message: HealthCheckRequest, writer: jspb.BinaryWriter): void;
    static deserializeBinary(bytes: Uint8Array): HealthCheckRequest;
    static deserializeBinaryFromReader(message: HealthCheckRequest, reader: jspb.BinaryReader): HealthCheckRequest;
}

export namespace HealthCheckRequest {
    export type AsObject = {
    }
}

export class Health extends jspb.Message { 
    getStatus(): Health.ServingStatus;
    setStatus(value: Health.ServingStatus): Health;

    serializeBinary(): Uint8Array;
    toObject(includeInstance?: boolean): Health.AsObject;
    static toObject(includeInstance: boolean, msg: Health): Health.AsObject;
    static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
    static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
    static serializeBinaryToWriter(message: Health, writer: jspb.BinaryWriter): void;
    static deserializeBinary(bytes: Uint8Array): Health;
    static deserializeBinaryFromReader(message: Health, reader: jspb.BinaryReader): Health;
}

export namespace Health {
    export type AsObject = {
        status: Health.ServingStatus,
    }

    export enum ServingStatus {
    UNKNOWN = 0,
    SERVING = 1,
    NOT_SERVING = 2,
    SERVICE_UNKNOWN = 3,
    }

}

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

export class RefundRequest extends jspb.Message { 
    getPaymentId(): string;
    setPaymentId(value: string): RefundRequest;

    serializeBinary(): Uint8Array;
    toObject(includeInstance?: boolean): RefundRequest.AsObject;
    static toObject(includeInstance: boolean, msg: RefundRequest): RefundRequest.AsObject;
    static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
    static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
    static serializeBinaryToWriter(message: RefundRequest, writer: jspb.BinaryWriter): void;
    static deserializeBinary(bytes: Uint8Array): RefundRequest;
    static deserializeBinaryFromReader(message: RefundRequest, reader: jspb.BinaryReader): RefundRequest;
}

export namespace RefundRequest {
    export type AsObject = {
        paymentId: string,
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
    getIsRefunded(): boolean;
    setIsRefunded(value: boolean): Payment;

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
        isRefunded: boolean,
    }
}

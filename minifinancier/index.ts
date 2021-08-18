import { randomUUID } from "crypto";
import {
  sendUnaryData,
  Server,
  ServerCredentials,
  ServerUnaryCall,
} from "@grpc/grpc-js";
import { Timestamp } from "google-protobuf/google/protobuf/timestamp_pb";
import { ChargeRequest, Payment, RefundRequest } from "./minifinancier_pb";
import { PaymentGatewayService } from "./minifinancier_grpc_pb";

function charge(
  call: ServerUnaryCall<ChargeRequest, Payment>,
  callback: sendUnaryData<Payment>
) {
  console.log(
    `charge requested: userId=${call.request.getUserId()} amount=${call.request.getAmount()}`
  );

  const response = new Payment()
    .setId(randomUUID())
    .setUserId(call.request.getUserId())
    .setAmount(call.request.getAmount())
    .setCreateTime(Timestamp.fromDate(new Date()))
    .setIsRefunded(false);

  callback(null, response);
}

function refund(
  call: ServerUnaryCall<RefundRequest, Payment>,
  callback: sendUnaryData<Payment>
) {
  const paymentId = call.request.getPaymentId();
  console.log(
    `refund requested: paymentId=${paymentId}`
  );

  // paymentIdとisRefunded以外は適当なデータ
  const response = new Payment()
    .setId(paymentId)
    .setUserId(1)
    .setAmount(100)
    .setCreateTime(Timestamp.fromDate(new Date()))
    .setIsRefunded(true);

  callback(null, response);
}

const server = new Server();
server.addService(PaymentGatewayService, { charge, refund });

const port = process.env.PORT || 50051;
server.bindAsync(
  `0.0.0.0:${port}`,
  ServerCredentials.createInsecure(),
  (error, port) => {
    if (error) {
      console.error(error);
    }
    server.start();
    console.log(`server started listing on port ${port}`);
  }
);

import { randomUUID } from "crypto";
import {
  sendUnaryData,
  Server,
  ServerCredentials,
  ServerUnaryCall,
  status,
} from "@grpc/grpc-js";
import { Timestamp } from "google-protobuf/google/protobuf/timestamp_pb";
import {
  ChargeRequest,
  Health,
  HealthCheckRequest,
  Payment,
  RefundRequest,
} from "./minifinancier_pb";
import { PaymentGatewayService } from "./minifinancier_grpc_pb";

const paymentMap = new Map<string, Payment>();

function charge(
  call: ServerUnaryCall<ChargeRequest, Payment>,
  callback: sendUnaryData<Payment>
) {
  console.log(
    `charge requested: userId=${call.request.getUserId()} amount=${call.request.getAmount()}`
  );

  const id = randomUUID();
  const payment = new Payment()
    .setId(id)
    .setUserId(call.request.getUserId())
    .setAmount(call.request.getAmount())
    .setCreateTime(Timestamp.fromDate(new Date()));
  paymentMap.set(id, payment);

  callback(null, payment);
}

function refund(
  call: ServerUnaryCall<RefundRequest, Payment>,
  callback: sendUnaryData<Payment>
) {
  console.log(`refund requested: paymentId=${call.request.getPaymentId()}`);

  const payment = paymentMap.get(call.request.getPaymentId());
  if (payment) {
    payment.setRefundTime(Timestamp.fromDate(new Date()));
    callback(null, payment);
  } else {
    callback({
      code: status.NOT_FOUND,
      message: `Payment not found for id=${call.request.getPaymentId()}`,
    });
  }
}

function checkHealth(
  _call: ServerUnaryCall<HealthCheckRequest, Payment>,
  callback: sendUnaryData<Health>
) {
  const response = new Health().setStatus(1);
  callback(null, response);
}

const server = new Server();
server.addService(PaymentGatewayService, { charge, refund, checkHealth });
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

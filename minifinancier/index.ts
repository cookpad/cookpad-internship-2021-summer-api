import { randomUUID } from "crypto";
import {
  sendUnaryData,
  Server,
  ServerCredentials,
  ServerUnaryCall,
} from "@grpc/grpc-js";
import { Timestamp } from "google-protobuf/google/protobuf/timestamp_pb";
import { ChargeRequest, Payment, HealthCheckRequest, Health } from "./minifinancier_pb";
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
    .setCreateTime(Timestamp.fromDate(new Date()));

  callback(null, response);
}

function checkHealth(
  _call: ServerUnaryCall<HealthCheckRequest, Payment>,
  callback: sendUnaryData<Health>
) {
  const response = new Health().setStatus(1);
  callback(null, response);
}

const server = new Server();
server.addService(PaymentGatewayService, { charge, checkHealth });
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

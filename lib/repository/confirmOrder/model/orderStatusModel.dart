// To parse this JSON data, do
//
//     final OrderStatusModel = OrderStatusModelFromJson(jsonString);

import 'dart:convert';

OrderStatusModel OrderStatusModelFromJson(String str) => OrderStatusModel.fromJson(json.decode(str));

String OrderStatusModelToJson(OrderStatusModel data) => json.encode(data.toJson());

class OrderStatusModel {
    OrderStatusModel({
        this.orderStatus,
        this.message,
        this.status,
    });

    String? orderStatus;
    String? message;
    String? status;

    factory OrderStatusModel.fromJson(Map<String, dynamic> json) => OrderStatusModel(
        orderStatus: json["order_status"],
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "order_status": orderStatus,
        "message": message,
        "status": status,
    };
}

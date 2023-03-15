// To parse this JSON data, do
//
//     final ConfirmOrderModel = ConfirmOrderModelFromJson(jsonString);

import 'dart:convert';

ConfirmOrderModel ConfirmOrderModelFromJson(String str) => ConfirmOrderModel.fromJson(json.decode(str));

String ConfirmOrderModelToJson(ConfirmOrderModel data) => json.encode(data.toJson());

class ConfirmOrderModel {
    ConfirmOrderModel({
        this.orderStatus,
        this.message,
        this.status,
    });

    String? orderStatus;
    String? message;
    String? status;

    factory ConfirmOrderModel.fromJson(Map<String, dynamic> json) => ConfirmOrderModel(
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

// To parse this JSON data, do
//
//     final ViewApllData = ViewApllDataFromJson(jsonString);

import 'dart:convert';

ViewApllData ViewApllDataFromJson(String str) => ViewApllData.fromJson(json.decode(str));

String ViewApllDataToJson(ViewApllData data) => json.encode(data.toJson());

class ViewApllData {
    ViewApllData({
        this.message,
        this.data,
        this.status,
    });

    String? message;
    List<Datum>? data;
    String? status;

    factory ViewApllData.fromJson(Map<String, dynamic> json) => ViewApllData(
        message: json["message"] ?? "",
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "status": status,
    };
}

class Datum {
    Datum({
        this.orderId,
        this.date,
        this.name,
        this.phone,
        this.expectedDeliveryDate,
        this.totalProductPrice,
        this.totalDisc,
        this.noItems,
        this.subTotal,
        this.paymentType,
        this.orderStatus,
        this.couponCode,
        this.couponOffer,
        this.items,
    });

    String? orderId;
    String? date;
    String? name;
    String? phone;
    String? expectedDeliveryDate;
    String? totalProductPrice;
    String? totalDisc;
    String? noItems;
    String? subTotal;
    String? paymentType;
    String? orderStatus;
    String? couponCode;
    String? couponOffer;
    List<Item>? items;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        orderId: json["order_id"] ?? "",
        date: json["date"] ?? "",
        name: json["name"] ?? "",
        phone: json["phone"] ?? "",
        expectedDeliveryDate: json["expected_delivery_date"] ?? "",
        totalProductPrice: json["total_product_price"] ?? "",
        totalDisc: json["total_disc"] ?? "",
        noItems: json["no_items"] ?? "",
        subTotal: json["sub_total"] ?? "",
        paymentType: json["payment_type"] ?? "",
        orderStatus: json["order_status"] ?? "",
        couponCode: json["coupon_code"] ?? "",
        couponOffer: json["coupon_offer"] ?? "",
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "date": date,
        "name": name,
        "phone": phone,
        "expected_delivery_date": expectedDeliveryDate,
        "total_product_price": totalProductPrice,
        "total_disc": totalDisc,
        "no_items": noItems,
        "sub_total": subTotal,
        "payment_type": paymentType,
        "order_status": orderStatus,
        "coupon_code": couponCode,
        "coupon_offer": couponOffer,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
    };
}

class Item {
    Item({
        this.id,
        this.productName,
        this.image,
    });

    String? id;
    String? productName;
    dynamic image;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"] ?? "",
        productName: json["product_name"] ?? "",
        image: json["image"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "image": image,
    };
}

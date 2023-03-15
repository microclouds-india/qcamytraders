// To parse this JSON data, do
//
//     final InvoiceProduct = InvoiceProductFromJson(jsonString);

import 'dart:convert';

InvoiceProduct InvoiceProductFromJson(String str) => InvoiceProduct.fromJson(json.decode(str));

String InvoiceProductToJson(InvoiceProduct data) => json.encode(data.toJson());

class InvoiceProduct {
    InvoiceProduct({
        this.message,
        this.data,
        this.status,
    });

    String? message;
    List<Datum>? data;
    String? status;

    factory InvoiceProduct.fromJson(Map<String, dynamic> json) => InvoiceProduct(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
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
        this.address,
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
    DateTime? date;
    String? name;
    String? address;
    String? expectedDeliveryDate;
    String? totalProductPrice;
    String? totalDisc;
    String? noItems;
    String? subTotal;
    String? paymentType;
    String? orderStatus;
    String ?couponCode;
    String? couponOffer;
    List<Item>? items;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        orderId: json["order_id"],
        date: DateTime.parse(json["date"]),
        name: json["name"],
        address: json["address"],
        expectedDeliveryDate: json["expected_delivery_date"],
        totalProductPrice: json["total_product_price"],
        totalDisc: json["total_disc"],
        noItems: json["no_items"],
        subTotal: json["sub_total"],
        paymentType: json["payment_type"],
        orderStatus: json["order_status"],
        couponCode: json["coupon_code"],
        couponOffer: json["coupon_offer"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "name": name,
        "address": address,
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
        this.productId,
        this.price,
        this.qty,
        this.totalPrice,
        this.cutPrice,
        this.offerPer,
        this.cstatus,
        this.productName,
        this.image,
    });

    String? id;
    String? productId;
    String? price;
    String? qty;
    String? totalPrice;
    String? cutPrice;
    String? offerPer;
    String? cstatus;
    String? productName;
    dynamic image;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        productId: json["product_id"],
        price: json["price"],
        qty: json["qty"],
        totalPrice: json["total_price"],
        cutPrice: json["cut_price"],
        offerPer: json["offer_per"],
        cstatus: json["cstatus"],
        productName: json["product_name"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "price": price,
        "qty": qty,
        "total_price": totalPrice,
        "cut_price": cutPrice,
        "offer_per": offerPer,
        "cstatus": cstatus,
        "product_name": productName,
        "image": image,
    };
}

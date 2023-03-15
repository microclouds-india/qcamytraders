class OrdersModel {
  OrdersModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
    message: json["message"] ?? "",
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    status: json["status"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
  };
}

class Datum {
  Datum({
    required this.orderId,
    required this.date,
    required this.expectedDeliveryDate,
    required this.totalProductPrice,
    required this.totalDisc,
    required this.noItems,
    required this.subTotal,
    required this.paymentType,
    required this.orderStatus,
    required this.couponCode,
    required this.couponOffer,
    required this.items,
  });

  String orderId;
  String date;
  String expectedDeliveryDate;
  String totalProductPrice;
  String totalDisc;
  String noItems;
  String subTotal;
  String paymentType;
  String orderStatus;
  String couponCode;
  String couponOffer;
  List<Item> items;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    orderId: json["order_id"] ?? "",
    date: json["date"] ?? "",
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
    "expected_delivery_date": expectedDeliveryDate,
    "total_product_price": totalProductPrice,
    "total_disc": totalDisc,
    "no_items": noItems,
    "sub_total": subTotal,
    "payment_type": paymentType,
    "order_status": orderStatus,
    "coupon_code": couponCode,
    "coupon_offer": couponOffer,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  Item({
    required this.id,
    required this.productName,
    this.image,
  });

  String id;
  String productName;
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

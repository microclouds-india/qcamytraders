class SaleReportModel {
  SaleReportModel({
    required this.message,
    required this.data,
    required this.status,
    required this.grandtotal,
    required this.tax_total,
    required this.cgst,
    required this.sgst,
  });

  String message;
  List<Datum?> data;
  String status;
  String grandtotal;
  String tax_total;
  String cgst;
  String sgst;

  factory SaleReportModel.fromJson(Map<String, dynamic> json) => SaleReportModel(
    message: json["message"] ?? "",
    data: List<Datum>.from(json["data"]?.map((x) => Datum.fromJson(x)) ?? []),
    status: json["status"] ?? "",
    grandtotal: json["grandtotal"] ?? "",
    tax_total: json["tax_total"] ?? "",
    cgst: json["cgst"] ?? "",
    sgst: json["sgst"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data.map((x) => x?.toJson())),
    "status": status,
    "grandtotal": grandtotal,
    "tax_total": tax_total,
    "cgst": cgst,
    "sgst": sgst,
  };
}

class Datum {
  Datum({
    required this.id,
    required this.userId,
    required this.noProducts,
    required this.totalProductPrice,
    required this.totalDisc,
    required this.subTotal,
    required this.orderStatus,
    required this.tdate,
    required this.ttime,
  });

  String id;
  String userId;
  String noProducts;
  String totalProductPrice;
  String totalDisc;
  String subTotal;
  String orderStatus;
  String tdate;
  String ttime;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] ?? "",
    userId: json["user_id"] ?? "",
    noProducts: json["no_products"] ?? "",
    totalProductPrice: json["total_product_price"] ?? "",
    totalDisc: json["total_disc"] ?? "",
    subTotal: json["sub_total"] ?? "",
    orderStatus: json["order_status"] ?? "",
    tdate: json["tdate"] ?? "",
    ttime: json["ttime"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "no_products": noProducts,
    "total_product_price": totalProductPrice,
    "total_disc": totalDisc,
    "sub_total": subTotal,
    "order_status": orderStatus,
    "tdate": tdate,
    "ttime": ttime,
  };
}

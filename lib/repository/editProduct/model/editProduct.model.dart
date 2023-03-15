class EditProductModel {
  EditProductModel({
    required this.hsncode,
    required this.traderId,
    required this.specTemplateId,
    required this.brandId,
    required this.together,
    required this.slno,
    required this.taxPer,
    required this.taxAmount,
    required this.taxType,
    required this.cgst,
    required this.sgst,
    required this.actualPrice,
    required this.catid,
    required this.productName,
    required this.price,
    required this.mrp,
    required this.specifications,
    required this.descri,
    required this.stock,
    required this.tdate,
    required this.ttime,
    required this.specDetails,
    required this.status,
  });

  String hsncode;
  String traderId;
  String specTemplateId;
  String brandId;
  String together;
  String slno;
  String taxPer;
  String taxAmount;
  String taxType;
  String cgst;
  String sgst;
  String actualPrice;
  String catid;
  String productName;
  String price;
  String mrp;
  String specifications;
  String descri;
  String stock;
  String tdate;
  String ttime;
  List<SpecDetail> specDetails;
  String status;

  factory EditProductModel.fromJson(Map<String, dynamic> json) => EditProductModel(
    hsncode: json["hsncode"] ?? "",
    traderId: json["trader_id"] ?? "",
    specTemplateId: json["spec_template_id"] ?? "",
    brandId: json["brand_id"] ?? "",
    together: json["together"] ?? "",
    slno: json["slno"] ?? "",
    taxPer: json["tax_per"] ?? "",
    taxAmount: json["tax_amount"] ?? "",
    taxType: json["tax_type"] ?? "",
    cgst: json["cgst"] ?? "",
    sgst: json["sgst"] ?? "",
    actualPrice: json["actual_price"] ?? "",
    catid: json["catid"] ?? "",
    productName: json["product_name"] ?? "",
    price: json["price"] ?? "",
    mrp: json["mrp"] ?? "",
    specifications: json["specifications"] ?? "",
    descri: json["descri"] ?? "",
    stock: json["stock"] ?? "",
    tdate: json["tdate"] ?? "",
    ttime: json["ttime"] ?? "",
    specDetails: List<SpecDetail>.from(json["spec_details"].map((x) => SpecDetail.fromJson(x))),
    status: json["status"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "hsncode": hsncode,
    "trader_id": traderId,
    "spec_template_id": specTemplateId,
    "brand_id": brandId,
    "together": together,
    "slno": slno,
    "tax_per": taxPer,
    "tax_amount": taxAmount,
    "tax_type": taxType,
    "cgst": cgst,
    "sgst": sgst,
    "actual_price": actualPrice,
    "catid": catid,
    "product_name": productName,
    "price": price,
    "mrp": mrp,
    "specifications": specifications,
    "descri": descri,
    "stock": stock,
    "tdate": tdate,
    "ttime": ttime,
    "spec_details": List<dynamic>.from(specDetails.map((x) => x.toJson())),
    "status": status,
  };
}

class SpecDetail {
  SpecDetail({
    required this.specCat,
    required this.catValue,
    required this.measure,
    required this.ttime,
    required this.tdate,
    this.productId,
  });

  String specCat;
  String catValue;
  String measure;
  String ttime;
  String tdate;
  String? productId;

  factory SpecDetail.fromJson(Map<String, dynamic> json) => SpecDetail(
    specCat: json["spec_cat"] ?? "",
    catValue: json["cat_value"] ?? "",
    measure: json["measure"] ?? "",
    ttime: json["ttime"] ?? "",
    tdate: json["tdate"] ?? "",
    productId: json["product_id"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "spec_cat": specCat,
    "cat_value": catValue,
    "measure": measure,
    "ttime": ttime,
    "tdate": tdate,
    "product_id": productId,
  };
}

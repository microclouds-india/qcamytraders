// To parse this JSON data, do
//
//     final addProductModel = addProductModelFromJson(jsonString);

import 'dart:convert';

AddProductModel addProductModelFromJson(String str) => AddProductModel.fromJson(json.decode(str));

String addProductModelToJson(AddProductModel data) => json.encode(data.toJson());

class AddProductModel {
  AddProductModel({
    required this.hsncode,
    required this.specTemplateId,
    required this.slno,
    required this.traderId,
    required this.together,
    required this.brandId,
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
    required this.status,
  });

  String hsncode;
  String specTemplateId;
  String slno;
  String traderId;
  String together;
  String brandId;
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
  String status;

  factory AddProductModel.fromJson(Map<String, dynamic> json) => AddProductModel(
    hsncode: json["hsncode"] ?? "",
    specTemplateId: json["spec_template_id"] ?? "",
    slno: json["slno"] ?? "",
    traderId: json["trader_id"] ?? "",
    together: json["together"] ?? "",
    brandId: json["brand_id"] ?? "",
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
    status: json["status"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "hsncode": hsncode,
    "spec_template_id": specTemplateId,
    "slno": slno,
    "trader_id": traderId,
    "together": together,
    "brand_id": brandId,
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
    "status": status,
  };
}

class AllProductsModel {
  AllProductsModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory AllProductsModel.fromJson(Map<String, dynamic> json) => AllProductsModel(
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
    required this.id,
    required this.wishlistId,
    required this.categoryName,
    required this.brandName,
    required this.productName,
    required this.price,
    required this.cutPrice,
    required this.mrp,
    required this.offerPer,
    required this.specifications,
    required this.taxPer,
    required this.cgst,
    required this.sgst,
    required this.gst,
    required this.actualPrice,
    required this.image,
  });

  String id;
  String wishlistId;
  String categoryName;
  String brandName;
  String productName;
  String price;
  String cutPrice;
  String mrp;
  String offerPer;
  String specifications;
  String taxPer;
  String cgst;
  String sgst;
  String gst;
  String actualPrice;
  String image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] ?? "",
    wishlistId: json["wishlist_id"] ?? "",
    categoryName: json["category_name"] ?? "",
    brandName: json["brand_name"] ?? "",
    productName: json["product_name"] ?? "",
    price: json["price"] ?? "",
    cutPrice: json["cut_price"] ?? "",
    mrp: json["mrp"] ?? "",
    offerPer: json["offer_per"] ?? "",
    specifications: json["specifications"] ?? "",
    taxPer: json["tax_per"] ?? "",
    cgst: json["cgst"] ?? "",
    sgst: json["sgst"] ?? "",
    gst: json["gst"] ?? "",
    actualPrice: json["actual_price"] ?? "",
    image: json["image"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "wishlist_id": wishlistId,
    "category_name": categoryName,
    "brand_name": brandName,
    "product_name": productName,
    "price": price,
    "cut_price": cutPrice,
    "mrp": mrp,
    "offer_per": offerPer,
    "specifications": specifications,
    "tax_per": taxPer,
    "cgst": cgst,
    "sgst": sgst,
    "gst": gst,
    "actual_price": actualPrice,
    "image": image,
  };
}

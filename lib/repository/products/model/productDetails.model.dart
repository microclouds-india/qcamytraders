class ProductDetailsModel {
  ProductDetailsModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<ProductDetailsModelDatum> data;
  String status;

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) => ProductDetailsModel(
    message: json["message"] ?? "",
    data: List<ProductDetailsModelDatum>.from(json["data"].map((x) => ProductDetailsModelDatum.fromJson(x))),
    status: json["status"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
  };
}

class ProductDetailsModelDatum {
  ProductDetailsModelDatum({
    required this.id,
    required this.productName,
    required this.categoryName,
    required this.price,
    required this.brandName,
    required this.mrp,
    required this.actualPrice,
    required this.offerPer,
    required this.specifications,
    required this.description,
    required this.taxPer,
    required this.cgst,
    required this.sgst,
    required this.gst,
    required this.slno,
    required this.hsncode,
    required this.stock,
    required this.together,
    required this.startDate,
    required this.endDate,
    required this.specTemplate,
    required this.specDetails,
    required this.image,
  });

  String id;
  String productName;
  String categoryName;
  String price;
  String brandName;
  String mrp;
  String actualPrice;
  String offerPer;
  String specifications;
  String description;
  String taxPer;
  String cgst;
  String sgst;
  String gst;
  String slno;
  String hsncode;
  String stock;
  dynamic together;
  String startDate;
  String endDate;
  String specTemplate;
  dynamic specDetails;
  Image image;

  factory ProductDetailsModelDatum.fromJson(Map<String, dynamic> json) => ProductDetailsModelDatum(
    id: json["id"] ?? "",
    productName: json["product_name"] ?? "",
    categoryName: json["category_name"] ?? "",
    price: json["price"] ?? "",
    brandName: json["brand_name"] ?? "",
    mrp: json["mrp"] ?? "",
    actualPrice: json["actual_price"] ?? "",
    offerPer: json["offer_per"] ?? "",
    specifications: json["specifications"] ?? "",
    description: json["description"] ?? "",
    taxPer: json["tax_per"] ?? "",
    cgst: json["cgst"] ?? "",
    sgst: json["sgst"] ?? "",
    gst: json["gst"] ?? "",
    slno: json["slno"] ?? "",
    hsncode: json["hsncode"] ?? "",
    stock: json["stock"] ?? "",
    startDate: json["start_date"] ?? "",
    endDate: json["end_date"] ?? "",
    specTemplate: json["spec_template"] ?? "",
    together: json["together"] == "no Items" ? json["together"] : Together.fromJson(json["together"]),
    specDetails: json["spec_details"] == "no Items" ? json["spec_details"] : SpecDetails.fromJson(json["spec_details"]),
    image: Image.fromJson(json["image"] == null ? null : json["image"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_name": productName,
    "category_name": categoryName,
    "price": price,
    "brand_name": brandName,
    "mrp": mrp,
    "actual_price": actualPrice,
    "offer_per": offerPer,
    "specifications": specifications,
    "description": description,
    "tax_per": taxPer,
    "cgst": cgst,
    "sgst": sgst,
    "gst": gst,
    "slno": slno,
    "hsncode": hsncode,
    "stock": stock,
    "together": together.toString(),
    "start_date": startDate,
    "end_date": endDate,
    "spec_template": specTemplate,
    "spec_details": specDetails.toJson(),
    "image": image.toJson(),
  };
}

class Image {
  Image({
    required this.data,
  });

  List<ImageDatum> data;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    data: List<ImageDatum>.from(json["data"].map((x) => ImageDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ImageDatum {
  ImageDatum({
    required this.id,
    required this.image,
  });

  String id;
  String image;

  factory ImageDatum.fromJson(Map<String, dynamic> json) => ImageDatum(
    id: json["id"] ?? "",
    image: json["image"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
  };
}

class SpecDetails {
  SpecDetails({
    required this.data,
  });

  List<SpecDetailsDatum> data;

  factory SpecDetails.fromJson(Map<String, dynamic> json) => SpecDetails(
    data: List<SpecDetailsDatum>.from(json["data"].map((x) => SpecDetailsDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SpecDetailsDatum {
  SpecDetailsDatum({
    required this.id,
    required this.templateId,
    required this.specCat,
    required this.catValue,
    required this.measure,
  });

  String id;
  String templateId;
  String specCat;
  String catValue;
  String measure;

  factory SpecDetailsDatum.fromJson(Map<String, dynamic> json) => SpecDetailsDatum(
    id: json["id"] ?? "",
    templateId: json["template_id"] ?? "",
    specCat: json["spec_cat"] ?? "",
    catValue: json["cat_value"] ?? "",
    measure: json["measure"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "template_id": templateId,
    "spec_cat": specCat,
    "cat_value": catValue,
    "measure": measure,
  };
}


class Together {
  Together({
    required this.data,
  });

  List<TogetherDatum> data;

  factory Together.fromJson(Map<String, dynamic> json) => Together(
    data: List<TogetherDatum>.from(json["data"].map((x) => TogetherDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class TogetherDatum {
  TogetherDatum({
    required this.id,
    required this.product_name,
  });

  String id;
  String product_name;

  factory TogetherDatum.fromJson(Map<String, dynamic> json) => TogetherDatum(
    id: json["id"] ?? "",
    product_name: json["product_name"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_name": product_name,
  };
}

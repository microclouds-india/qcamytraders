class TaxModel {
  TaxModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory TaxModel.fromJson(Map<String, dynamic> json) => TaxModel(
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
    required this.tax,
  });

  String id;
  String tax;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] ?? "",
    tax: json["tax"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tax": tax,
  };
}

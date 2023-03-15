class SpecTemplateModel {
  SpecTemplateModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory SpecTemplateModel.fromJson(Map<String, dynamic> json) => SpecTemplateModel(
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
    required this.specCat,
    required this.measure,
  });

  String id;
  String specCat;
  String measure;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] ?? "",
    specCat: json["spec_cat"] ?? "",
    measure: json["measure"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "spec_cat": specCat,
    "measure": measure,
  };
}

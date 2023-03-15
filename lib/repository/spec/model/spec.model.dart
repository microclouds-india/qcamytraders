class SpecModel {
  SpecModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory SpecModel.fromJson(Map<String, dynamic> json) => SpecModel(
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
    required this.templateName,
  });

  String id;
  String templateName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] ?? "",
    templateName: json["template_name"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "template_name": templateName,
  };
}

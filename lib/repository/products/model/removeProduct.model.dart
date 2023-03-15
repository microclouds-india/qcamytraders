class RemoveProductModel {
  RemoveProductModel({
    required this.message,
    required this.status,
  });

  String message;
  String status;

  factory RemoveProductModel.fromJson(Map<String, dynamic> json) => RemoveProductModel(
    message: json["message"] ?? "",
    status: json["status"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
  };
}

class ProfileModel {
  ProfileModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
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
    required this.name,
    required this.companyName,
    required this.phone,
    required this.username,
    required this.password,
    required this.city,
    required this.state,
    required this.email,
    required this.address,
  });

  String id;
  String name;
  String companyName;
  String phone;
  String username;
  String password;
  String city;
  String state;
  String email;
  String address;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] ?? "",
    name: json["name"] ?? "",
    companyName: json["company_name"] ?? "",
    phone: json["phone"] ?? "",
    username: json["username"] ?? "",
    password: json["password"] ?? "",
    city: json["city"] ?? "",
    state: json["state"] ?? "",
    email: json["email"] ?? "",
    address: json["address"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "company_name": companyName,
    "phone": phone,
    "username": username,
    "password": password,
    "city": city,
    "state": state,
    "email": email,
    "address": address,
  };
}


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qcamytraders/repository/brands/model/brands.model.dart';

class BrandsNetworking {

  static const String urlENDPOINT = "https://cashbes.com/photography/apis/brands";
  final client = http.Client();

  late BrandsModel brandsModel;

  Future<BrandsModel> getBrands({required String token}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "token": token,
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        brandsModel = BrandsModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return brandsModel;
  }
}

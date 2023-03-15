import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qcamytraders/repository/allProducts/model/allProducts.model.dart';

class AllProductsNetworking {

  static const String urlENDPOINT = "https://cashbes.com/photography/apis/products";
  final client = http.Client();

  late AllProductsModel allProductsModel;

  Future<AllProductsModel> getAllProducts({required String token}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "token": token,
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        allProductsModel = AllProductsModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return allProductsModel;
  }
}

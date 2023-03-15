import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamytraders/repository/products/model/productDetails.model.dart';

class ProductDetailsNetworking {

  static const String urlENDPOINT = "https://cashbes.com/photography/apis/trader_product_view";
  final client = http.Client();

  late ProductDetailsModel productDetailsModel;

  Future<ProductDetailsModel> getProductDetails({required String id}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "id": id,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        productDetailsModel = ProductDetailsModel.fromJson(response);
      }
    } catch (e) {
      throw Exception(e);
    }
    return productDetailsModel;
  }
}

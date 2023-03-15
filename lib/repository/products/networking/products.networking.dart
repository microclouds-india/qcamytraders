import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qcamytraders/repository/products/model/products.model.dart';
import 'package:qcamytraders/repository/products/model/removeProduct.model.dart';

class ProductsNetworking {

  static const String urlENDPOINT = "https://cashbes.com/photography/apis/trader_products";
  static const String removeproducturlENDPOINT = "https://cashbes.com/photography/apis/trader_product_remove";
  final client = http.Client();

  late ProductsModel productsModel;
  late RemoveProductModel removeProductModel;

  Future<ProductsModel> getProducts({required String token}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "token": token,
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        productsModel = ProductsModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return productsModel;
  }

  Future<RemoveProductModel> removeProduct({required String id}) async {
    try {
      final request = await client.post(Uri.parse(removeproducturlENDPOINT), body: {
        "id": id,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        removeProductModel = RemoveProductModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return removeProductModel;
  }
}

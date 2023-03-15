import 'package:flutter/material.dart';
import 'package:qcamytraders/core/token_storage/storage.dart';
import 'package:qcamytraders/repository/products/model/products.model.dart';
import 'package:qcamytraders/repository/products/model/removeProduct.model.dart';
import 'package:qcamytraders/repository/products/networking/products.networking.dart';

class ProductsNotifier extends ChangeNotifier {

  final ProductsNetworking _productsNetworking = ProductsNetworking();

  bool isLoading = false;
  LocalStorage localStorage = LocalStorage();

  late ProductsModel productsModel;
  late RemoveProductModel removeProductModel;

  var productName;

  loading(bool isLoading) {
    this.isLoading = isLoading;
  }

  getProducts() async {
    loading(true);

    try {

      final String? token = await localStorage.getToken();
      productsModel = await _productsNetworking.getProducts(token: token!);

      loading(false);
      return productsModel;
    } catch (e) {
      loading(false);
    }
  }

  Future removeProduct({required String id}) async {
    try {
      removeProductModel = await _productsNetworking.removeProduct(id: id);
      notifyListeners();
    } catch (e) {
      return Future.error(e);
    }
    return removeProductModel;
  }
}

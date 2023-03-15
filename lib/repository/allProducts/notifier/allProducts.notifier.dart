import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qcamytraders/core/token_storage/storage.dart';
import 'package:qcamytraders/repository/allProducts/model/allProducts.model.dart';
import 'package:qcamytraders/repository/allProducts/networking/allProducts.networking.dart';

class AllProductsNotifier extends ChangeNotifier {
  final AllProductsNetworking _allProductsNetworking = AllProductsNetworking();

  bool isLoading = false;
  LocalStorage localStorage = LocalStorage();

  late AllProductsModel allProductsModel;
  var togetherproducts;
  var togetherproductsItems = [];
  var togetherproductsName = [];
  List<XFile>? imageFileList = [];

  loading(bool isLoading) {
    this.isLoading = isLoading;
  }

  getAllProducts() async {
    loading(true);

    try {

      final String? token = await localStorage.getToken();
      allProductsModel = await _allProductsNetworking.getAllProducts(token: token!);

      loading(false);
      return allProductsModel;
    } catch (e) {
      loading(false);
    }
  }

}

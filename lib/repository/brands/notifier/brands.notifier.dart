import 'package:flutter/material.dart';
import 'package:qcamytraders/core/token_storage/storage.dart';
import 'package:qcamytraders/repository/brands/model/brands.model.dart';
import 'package:qcamytraders/repository/brands/networking/brands.networking.dart';
import 'package:qcamytraders/repository/orders/model/orders.model.dart';
import 'package:qcamytraders/repository/orders/networking/orders.networking.dart';

class BrandsNotifier extends ChangeNotifier {
  final BrandsNetworking _brandsNetworking = BrandsNetworking();

  bool isLoading = false;
  LocalStorage localStorage = LocalStorage();

  late BrandsModel brandsModel;
  var brandname;

  loading(bool isLoading) {
    this.isLoading = isLoading;
  }

  getBrands() async {
    loading(true);

    try {

      final String? token = await localStorage.getToken();
      brandsModel = await _brandsNetworking.getBrands(token: token!);

      loading(false);
      return brandsModel;
    } catch (e) {
      loading(false);
    }
  }
}

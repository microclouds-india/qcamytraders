import 'package:flutter/material.dart';
import 'package:qcamytraders/repository/spec/model/specDetails.model.dart';
import 'package:qcamytraders/repository/spec/networking/specDetails.networking.dart';

class SpecDetailsNotifier extends ChangeNotifier {
  final SpecDetailsNetworking _specDetailsNetworking = SpecDetailsNetworking();

  bool isLoading = false;

  late SpecDetailsModel specDetailsModel;

  loading(bool isLoading) {
    this.isLoading = isLoading;
  }

  getSpecDetails({required String product_id}) async {
    loading(true);

    try {

      specDetailsModel = await _specDetailsNetworking.getSpecDetails(product_id: product_id);

      loading(false);
      return specDetailsModel;
    } catch (e) {
      loading(false);
    }
  }
}

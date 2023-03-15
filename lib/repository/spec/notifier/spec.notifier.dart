import 'package:flutter/material.dart';
import 'package:qcamytraders/core/token_storage/storage.dart';
import 'package:qcamytraders/repository/spec/model/spec.model.dart';
import 'package:qcamytraders/repository/spec/networking/spec.networking.dart';

class SpecNotifier extends ChangeNotifier {
  final SpecNetworking _specNetworking = SpecNetworking();

  bool isLoading = false;
  LocalStorage localStorage = LocalStorage();

  late SpecModel specModel;
  var product_id;

  loading(bool isLoading) {
    this.isLoading = isLoading;
  }

  getSpec() async {
    loading(true);

    try {

      specModel = await _specNetworking.getSpec();

      loading(false);
      return specModel;
    } catch (e) {
      loading(false);
    }
  }
}

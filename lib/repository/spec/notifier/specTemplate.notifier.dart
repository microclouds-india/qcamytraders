import 'package:flutter/material.dart';
import 'package:qcamytraders/repository/spec/model/specTemplate.model.dart';
import 'package:qcamytraders/repository/spec/networking/specTemplate.networking.dart';

class SpecTemplateNotifier extends ChangeNotifier {
  final SpecTemplateNetworking _specTemplateNetworking = SpecTemplateNetworking();

  bool isLoading = false;
  var product_id;

  late SpecTemplateModel specTemplateModel;

  loading(bool isLoading) {
    this.isLoading = isLoading;
  }

  getSpecTemplate({required String id}) async {
    loading(true);

    try {

      specTemplateModel = await _specTemplateNetworking.getSpecTemplate(id: id);

      loading(false);
      return specTemplateModel;
    } catch (e) {
      loading(false);
    }
  }
}

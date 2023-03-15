import 'package:flutter/material.dart';
import 'package:qcamytraders/core/token_storage/storage.dart';
import 'package:qcamytraders/repository/category/model/category.model.dart';
import 'package:qcamytraders/repository/category/networking/category.networking.dart';
import 'package:qcamytraders/repository/spec/model/spec.model.dart';
import 'package:qcamytraders/repository/spec/networking/spec.networking.dart';

class CategoryNotifier extends ChangeNotifier {
  final CategoryNetworking _categoryNetworking = CategoryNetworking();

  bool isLoading = false;
  LocalStorage localStorage = LocalStorage();
  var categoryname;

  late CategoryModel categoryModel;

  loading(bool isLoading) {
    this.isLoading = isLoading;
  }

  getCategory() async {
    loading(true);

    try {

      categoryModel = await _categoryNetworking.getCategory();

      loading(false);
      return categoryModel;

    } catch (e) {
      loading(false);
    }
  }
}

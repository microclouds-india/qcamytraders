import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qcamytraders/repository/products/model/productDetails.model.dart';
import 'package:qcamytraders/repository/products/networking/productDetails.networking.dart';


class ProductDetailsNotifier extends ChangeNotifier {
  final ProductDetailsNetworking _productDetailsNetworking = ProductDetailsNetworking();

  late String productId;
  List<XFile>? imageFileList = [];

  late ProductDetailsModel productDetailsModel;

  bool isDataLoaded = false;

  Future getProductDetails() async {
    try {
      productDetailsModel = await _productDetailsNetworking.getProductDetails(id: productId);
      isDataLoaded = true;
      notifyListeners();

      return productDetailsModel;
    } catch (e) {
      return Future.error(e);
    }
  }

  String selectedImage = "";

  changeSelectedImage(var image) {
    selectedImage = image;
    notifyListeners();
  }
}

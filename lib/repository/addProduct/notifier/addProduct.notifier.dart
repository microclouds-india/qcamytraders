import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qcamytraders/core/token_storage/storage.dart';
import 'package:qcamytraders/repository/addProduct/model/addProduct.model.dart';
import 'package:qcamytraders/repository/addProduct/networking/addProduct.networking.dart';
import 'package:qcamytraders/repository/orders/model/orders.model.dart';
import 'package:qcamytraders/repository/orders/networking/orders.networking.dart';

class AddProductNotifier extends ChangeNotifier {
  final AddProductNetworking _addProductNetworking = AddProductNetworking();

  bool isLoading = false;
  late AddProductModel addProductModel;
  LocalStorage localStorage = LocalStorage();

  loading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  Future addProducts({
    required List<XFile> imageList,
    required String product_name,
    required String price,
    required String actual_price,
    required String mrp,
    required String hsncode,
    required String slno,
    required String brand_id,
    required String taxamount,
    required String tax_type,
    required String gst,
    required String tax_per,
    required String catid,
    required String descri,
    required String specifications,
    required String stock,
    required String together,
    required String spec_template_id,
    required String spec_values,
  }) async {

    loading(true);
    final String? token = await localStorage.getToken();

    try {

      addProductModel = await _addProductNetworking.addProducts(token: token!,
        imageList: imageList,
        product_name: product_name,
        descri: descri,
        specifications: specifications,
        price: price,
        actual_price: actual_price,
        stock: stock,
        hsncode: hsncode,
        mrp: mrp,
        slno: slno,
        brand_id: brand_id,
        catid: catid,
        gst: gst,
        spec_template_id: spec_template_id,
        spec_values: spec_values,
        tax_per: tax_per,
        tax_type: tax_type,
        taxamount: taxamount,
        together: together,
      );

      loading(false);
      return addProductModel;
    } on Exception {
      //catch late initialization error
      addProductModel = await _addProductNetworking.addProducts(token: token!,
        imageList: imageList,
        product_name: product_name,
        descri: descri,
        specifications: specifications,
        price: price,
        actual_price: actual_price,
        hsncode: hsncode,
        mrp: mrp,
        slno: slno,
        brand_id: brand_id,
        catid: catid,
        gst: gst,
        spec_template_id: spec_template_id,
        spec_values: spec_values,
        tax_per: tax_per,
        tax_type: tax_type,
        taxamount: taxamount,
        together: together,
        stock: stock,
      );

      loading(false);
      return addProductModel;
    }
    catch (e) {
      loading(false);
      return Future.error(e.toString());
    }
  }
}

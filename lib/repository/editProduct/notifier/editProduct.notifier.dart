import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qcamytraders/core/token_storage/storage.dart';
import 'package:qcamytraders/repository/editProduct/model/editProduct.model.dart';
import 'package:qcamytraders/repository/editProduct/networking/editProduct.networking.dart';

class EditProductNotifier extends ChangeNotifier {
  final EditProductNetworking _editProductNetworking = EditProductNetworking();

  bool isLoading = false;
  late EditProductModel editProductModel;
  LocalStorage localStorage = LocalStorage();

  loading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  Future editProducts({
    required List<XFile> imageList,
    required String id,
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
    required String spec_values_edited,
  }) async {

    loading(true);
    final String? token = await localStorage.getToken();
    print(token);

    try {

      editProductModel = await _editProductNetworking.editProducts(
        id: id,
        token: token!,
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
        spec_values_edited: spec_values_edited,
        tax_per: tax_per,
        tax_type: tax_type,
        taxamount: taxamount,
        together: together,
      );

      loading(false);
      return editProductModel;
    } on Exception {
      //catch late initialization error
      editProductModel = await _editProductNetworking.editProducts(
        id: id,
        token: token!,
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
        spec_values_edited: spec_values_edited,
        tax_per: tax_per,
        tax_type: tax_type,
        taxamount: taxamount,
        together: together,
      );

      loading(false);
      return editProductModel;
    } catch (e) {
      loading(false);
      return Future.error(e.toString());
    }
  }
}

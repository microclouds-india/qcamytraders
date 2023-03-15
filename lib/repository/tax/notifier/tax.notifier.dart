import 'package:flutter/material.dart';
import 'package:qcamytraders/repository/tax/model/tax.model.dart';
import 'package:qcamytraders/repository/tax/networking/tax.networking.dart';

class TaxNotifier extends ChangeNotifier {
  final TaxNetworking _taxNetworking = TaxNetworking();

  bool isLoading = false;
  late TaxModel taxModel;
  var taxType;
  var calc,
      plus,
      total1,
      total,
      taxamount,
      taxamount1,
      gst1,
      gst,
      actualprice = "Total Price";

  loading(bool isLoading) {
    this.isLoading = isLoading;
  }

  getTax() async {
    loading(true);
    try {
      taxModel = await _taxNetworking.getTax();
      loading(false);
      return taxModel;
    } catch (e) {
      loading(false);
    }
  }
}

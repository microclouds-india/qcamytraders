import 'package:flutter/material.dart';
import 'package:qcamytraders/core/token_storage/storage.dart';
import 'package:qcamytraders/repository/orders/model/orders.model.dart';
import 'package:qcamytraders/repository/orders/networking/orders.networking.dart';

class OrdersNotifier extends ChangeNotifier {
  final OrdersNetworking _ordersNetworking = OrdersNetworking();

  bool isLoading = false;
  LocalStorage localStorage = LocalStorage();

  late OrdersModel ordersModel;

  loading(bool isLoading) {
    this.isLoading = isLoading;
  }

  getOrders() async {
    loading(true);

    try {

      final String? token = await localStorage.getToken();
      ordersModel = await _ordersNetworking.getOrders(token: token!);

      loading(false);
      return ordersModel;
    } catch (e) {
      loading(false);
    }
  }
}

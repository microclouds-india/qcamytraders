import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qcamytraders/repository/orders/model/orders.model.dart';

class OrdersNetworking {

  static const String urlENDPOINT = "https://cashbes.com/photography/apis/trader_orders";
  final client = http.Client();

  late OrdersModel ordersModel;

  Future<OrdersModel> getOrders({required String token}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "token": token,
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        ordersModel = OrdersModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return ordersModel;
  }
}

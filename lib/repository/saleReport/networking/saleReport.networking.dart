import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qcamytraders/repository/saleReport/model/saleReport.model.dart';

class SaleReportNetworking {

  static const String urlENDPOINT = "https://cashbes.com/photography/apis/sale_reports";
  final client = http.Client();

  late SaleReportModel salereportModel;

  Future<SaleReportModel> getSaleReport({required String token,
    // required String product_id,
    required String month,
    required String year,
    required String fromdate,
    required String todate}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "token": token,
        "fromdate": fromdate,
        "todate": todate,
        "month": month,
        "year": year,
        // "product_id": product_id,
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        salereportModel = SaleReportModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return salereportModel;
  }
}

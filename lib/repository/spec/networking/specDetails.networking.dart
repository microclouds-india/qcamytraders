import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qcamytraders/repository/spec/model/specDetails.model.dart';

class SpecDetailsNetworking {
  static const String urlENDPOINT = "https://cashbes.com/photography/apis/trader_product_spec_details";

  final client = http.Client();

  late SpecDetailsModel specDetailsModel;

  Future<SpecDetailsModel> getSpecDetails({required String product_id}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "product_id": product_id,
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        specDetailsModel = SpecDetailsModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return specDetailsModel;
  }
}

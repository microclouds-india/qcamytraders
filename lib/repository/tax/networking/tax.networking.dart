import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qcamytraders/repository/tax/model/tax.model.dart';

class TaxNetworking {

  static const String urlENDPOINT = "https://cashbes.com/photography/apis/taxs";
  final client = http.Client();

  late TaxModel taxModel;

  Future<TaxModel> getTax() async {
    try {
      final request = await client.get(Uri.parse(urlENDPOINT));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        taxModel = TaxModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return taxModel;
  }
}

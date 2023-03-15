import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qcamytraders/repository/login/model/login.model.dart';
import 'package:qcamytraders/repository/profile/model/profile.model.dart';
import 'package:qcamytraders/repository/spec/model/spec.model.dart';

class SpecNetworking {

  static const String urlENDPOINT = "https://cashbes.com/photography/apis/specs";

  final client = http.Client();

  late SpecModel specModel;

  Future<SpecModel> getSpec() async {
    try {
      final request = await client.get(Uri.parse(urlENDPOINT));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        specModel = SpecModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return specModel;
  }
}

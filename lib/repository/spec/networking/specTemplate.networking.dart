import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qcamytraders/repository/spec/model/specTemplate.model.dart';

class SpecTemplateNetworking {
  static const String urlENDPOINT = "https://cashbes.com/photography/apis/spectemplate_select";

  final client = http.Client();

  late SpecTemplateModel specTemplateModel;

  Future<SpecTemplateModel> getSpecTemplate({required String id}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "id": id,
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        specTemplateModel = SpecTemplateModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return specTemplateModel;
  }
}

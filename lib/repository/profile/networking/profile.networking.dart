import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qcamytraders/repository/login/model/login.model.dart';
import 'package:qcamytraders/repository/profile/model/profile.model.dart';

class ProfileNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/trader_profile";

  final client = http.Client();

  late ProfileModel profileModel;

  Future<ProfileModel> getProfile({required String token}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "token": token,
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        profileModel = ProfileModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return profileModel;
  }
}

// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class ReportNetworking {
//
//   static const String urlENDPOINT = "https://cashbes.com/photography/apis/order_reports";
//   final client = http.Client();
//
//   late ReportModel reportModel;
//
//   Future<ReportModel> getReport({required String token}) async {
//     try {
//       final request = await client.post(Uri.parse(urlENDPOINT), body: {
//         "token": token,
//       }).timeout(const Duration(seconds: 10));
//
//       if (request.statusCode == 200) {
//         final response = json.decode(request.body);
//         reportModel = ReportModel.fromJson(response);
//       }
//     } catch (e) {
//       return Future.error(e);
//     }
//     return reportModel;
//   }
// }

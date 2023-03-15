// import 'package:flutter/material.dart';
// import 'package:qcamytraders/core/token_storage/storage.dart';
// import 'package:qcamytraders/repository/report/networking/saleReport.networking.dart';
//
// class ReportNotifier extends ChangeNotifier {
//   final ReportNetworking _reportNetworking = ReportNetworking();
//
//   bool isLoading = false;
//   LocalStorage localStorage = LocalStorage();
//
//   late ReportModel reportModel;
//
//   loading(bool isLoading) {
//     this.isLoading = isLoading;
//   }
//
//   getReport() async {
//     loading(true);
//
//     try {
//
//       final String? token = await localStorage.getToken();
//       reportModel = await _reportNetworking.getReport(token: token!);
//
//       loading(false);
//       return reportModel;
//     } catch (e) {
//       loading(false);
//     }
//   }
// }

import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_month_picker/flutter_month_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qcamytraders/core/token_storage/storage.dart';
import 'package:qcamytraders/repository/saleReport/model/saleReport.model.dart';
import 'package:qcamytraders/repository/saleReport/networking/saleReport.networking.dart';
import 'package:intl/intl.dart';

class SaleReportNotifier extends ChangeNotifier {
  final SaleReportNetworking _salereportNetworking = SaleReportNetworking();

  bool isLoading = false;
  LocalStorage localStorage = LocalStorage();

  late SaleReportModel salereportModel;

  var formatter = new DateFormat('dd-MM-yyyy');
  var formatterMonth = new DateFormat(MM);
  var formatterYear = new DateFormat('yyyy');
  DateTime month = DateTime(DateTime.now().year, DateTime.now().month);
  DateTime year = DateTime(DateTime.now().year);
  DateTime fromDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime toDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  bool daily = true;
  bool monthly = false;
  bool yearly = false;

  bool search = false;

  bool downloading = false;
  var progress = "";
  var path = "No Data";
  var platformVersion = "Unknown";
  var _onPressed;
  late Directory externalDir;

  String convertCurrentDateTimeToString() {
    String formattedDateTime =
    DateFormat('yyyyMMdd_kkmmss').format(DateTime.now()).toString();
    return formattedDateTime;
  }

  loading(bool isLoading) {
    this.isLoading = isLoading;
  }

  getSaleReport({required String fromdate,
    required String todate,
    required String month,
    required String year,
    required String product_id}) async {
    loading(true);

    try {

      final String? token = await localStorage.getToken();
      salereportModel = await _salereportNetworking.getSaleReport(token: token!,
          fromdate: fromdate,
          todate: todate,
          month: month,
          year: year,
          product_id: product_id);

      loading(false);
      return salereportModel;
    } catch (e) {
      loading(false);
    }
  }


  Future<DateTime> selectDate(BuildContext context, DateTime _date) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2018),
      lastDate: DateTime(2130),
    );

    if (picked != null) {
      _date = picked;
    }
    notifyListeners();
    return _date;
  }

  Future<DateTime> selectMonth(BuildContext context, DateTime _date) async {
    final DateTime? picked = await showMonthPicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2018),
      lastDate: DateTime(2130),
    );

    if (picked != null) {
      _date = picked;
    }
    notifyListeners();
    return _date;
  }

  Future<DateTime> selectYear(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Year"),
          content: Container( // Need to use container to add size constraint.
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 10, 1),
              lastDate: DateTime(DateTime.now().year + 100, 1),
              initialDate: DateTime.now(),
              selectedDate: year,
              onChanged: (DateTime dateTime) {
                year = dateTime;
                notifyListeners();
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
    return year;
  }

  Future<void> downloadFile({required String pdfUrl}) async {
    Dio dio = Dio();
    final status = await Permission.storage.request();
    if (status.isGranted) {
      String dirloc = "";
      if (Platform.isAndroid) {
        dirloc = "/sdcard/download/";
      } else {
        dirloc = (await getApplicationDocumentsDirectory()).path;
      }

      try {
        // if (await Permission.manageExternalStorage.request().isGranted) {
          loading(true);
          FileUtils.mkdir([dirloc]);
          await dio.download(pdfUrl, dirloc + convertCurrentDateTimeToString() + ".pdf",
              onReceiveProgress: (receivedBytes, totalBytes) {
                print('here 1');
                downloading = true;
                progress = ((receivedBytes / totalBytes) * 100).toStringAsFixed(0) + "%";
                print(progress);
              });
        // }

      } catch (e) {
        print('catch catch catch');
        print(e);
      }

        loading(false);
        downloading = false;
        progress = "Download Completed.";
        path = dirloc + convertCurrentDateTimeToString() + ".pdf";
    } else {
        progress = "Permission Denied!";
        _onPressed = () {
          downloadFile(pdfUrl: pdfUrl);
        };
    }
  }

}

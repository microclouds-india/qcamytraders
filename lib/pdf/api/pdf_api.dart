import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class PdfApi {
  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }

  static Future saveInStorage(File file) async {
    if (Platform.isIOS) {
      final dir = await getApplicationDocumentsDirectory();
      file = File('${dir.path}/sales_report.pdf');
    }
    if (Platform.isAndroid) {
      var status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        status = await Permission.storage.request();
      } else if (status.isGranted) {
        const downloadsFolderPath = '/storage/emulated/0/Download';
        Directory dir = Directory(downloadsFolderPath);
        var file2 = File('');
        file2 = File('${dir.path}/sales_report.pdf');

        File fileDef = File(file2.path);
        await fileDef.create(recursive: true);
        Uint8List bytes = await file.readAsBytes();
        await fileDef.writeAsBytes(bytes);
      }
    }
  }
}

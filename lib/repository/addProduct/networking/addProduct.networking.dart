import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:qcamytraders/repository/addProduct/model/addProduct.model.dart';
import 'package:qcamytraders/repository/orders/model/orders.model.dart';

class AddProductNetworking {
  static const String urlENDPOINT = "https://cashbes.com/photography/apis/trader_add_product";
  final client = http.Client();

  late AddProductModel addProductModel;

  Future<AddProductModel> addProducts(
      {required String token,
        required List<XFile> imageList,
        required String product_name,
        required String price,
        required String actual_price,
        required String mrp,
        required String hsncode,
        required String slno,
        required String brand_id,
        required String taxamount,
        required String tax_type,
        required String gst,
        required String tax_per,
        required String catid,
        required String descri,
        required String specifications,
        required String stock,
        required String together,
        required String spec_template_id,
        required String spec_values,
      }) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(urlENDPOINT));
      request.fields['token'] = token;
      request.fields['product_name'] = product_name;
      request.fields['price'] = price;
      request.fields['actual_price'] = actual_price;
      request.fields['mrp'] = mrp;
      request.fields['hsncode'] = hsncode;
      request.fields['slno'] = slno;
      request.fields['brand_id'] = brand_id;
      request.fields['taxamount'] = taxamount;
      request.fields['tax_type'] = tax_type;
      request.fields['gst'] = gst;
      request.fields['tax_per'] = tax_per;
      request.fields['catid'] = catid;
      request.fields['descri'] = descri;
      request.fields['specifications'] = specifications;
      request.fields['stock'] = stock;
      request.fields['together[]'] = together;
      request.fields['spec_template_id'] = spec_template_id;
      request.fields['spec_values'] = spec_values;

      // print("images length : "+imageList.length.toString());

      //add multiple image to the request
      for (var i = 0; i < imageList.length; i++) {
        request.files.add(
          http.MultipartFile("image[]", imageList[i].readAsBytes().asStream(),
              await imageList[i].length(),
              filename: imageList[i].name),
        );
      }

      var requestResponse = await request.send();
      requestResponse.stream.transform(utf8.decoder).listen((value) {
        var jsonResponse = jsonDecode(value) as Map<String, dynamic>;
        if (requestResponse.statusCode == 200) {
          addProductModel = AddProductModel.fromJson(jsonResponse);
        }
      });
      return addProductModel;
    } catch (e) {
      return Future.error(e);
    }
  }
}

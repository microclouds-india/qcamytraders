import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qcamytraders/repository/category/model/category.model.dart';

class CategoryNetworking {

  static const String urlENDPOINT = "https://cashbes.com/photography/apis/categories";

  final client = http.Client();

  late CategoryModel categoryModel;

  Future<CategoryModel> getCategory() async {
    try {
      final request = await client.get(Uri.parse(urlENDPOINT));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        categoryModel = CategoryModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return categoryModel;
  }
}

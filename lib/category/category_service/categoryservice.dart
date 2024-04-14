import 'dart:convert';
import 'dart:developer';

import 'package:kaveri/category/model/cateogyr_product_model.dart';
import 'package:kaveri/constants/api_url.dart';
import 'package:kaveri/products/product_model/product_model.dart';
import 'package:kaveri/screens/selectedCategory/model/selectedCategoryModel.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  Future<List<Category>> fetchCategories() async {
    // try {
    final response = await http.get(
      Uri.parse('$kbaseUrl/admin/get_category'),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)["data"] as List<dynamic>;
      // log(response.body);
      final categories = jsonData
          .map((categoryJson) => Category.fromJson(categoryJson))
          .toList();
// from this thumbile image is not comming from api
      return categories;
    } else {
      throw jsonDecode(response.body)['messageobject']['message'];
    }
    // } catch (e) {
    //   throw Exception('Something went wrong$e');
    // }
  }

  Future<List<Product>> fetchProductsBasedOnCategories(
      {required String categoryId}) async {
    log('${categoryId}id by category');
    try {
      final response = await http.get(
        Uri.parse(
            '$kbaseUrl/admin/getcategoriesproduct?categoryId=$categoryId'),
      );
      log('${response.body}id by category');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'] as List<dynamic>;
        List<Product> categories =
            data.map((e) => Product.fromJson(e)).toList();
// from this thumbile image is not comming from api
        log('$categories');
        return categories;
      } else {
        throw jsonDecode(response.body)['messageobject']['message'];
      }
    } catch (e) {
      log('${e}id by category');

      throw Exception('Something went wrong');
    }
  }
}

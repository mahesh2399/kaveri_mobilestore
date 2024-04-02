import 'dart:convert';
import 'dart:developer';

import 'package:kaveri/constants/api_url.dart';
import 'package:kaveri/screens/selectedCategory/model/selectedCategoryModel.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  Future<List<Category>> fetchCategories() async {
    try {
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
        throw Exception('Failed to load Category: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to load Category: $e');
    }
  }
}

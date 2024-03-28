
import 'dart:convert';

import 'package:kaveri/constants/api_url.dart';
import 'package:kaveri/screens/selectedCategory/model/selectedCategoryModel.dart';
import 'package:http/http.dart' as http;

class SelectedCategoryService {

  
  Future<List<Category>> fetchCategories(String categoryId) async {
    try {
      final response = await http.get(
        Uri.parse('$kbaseUrl/admin/get_products/$categoryId'),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body)["data"] as List<dynamic>;
        final categories = jsonData
            .map((categoryJson) => Category.fromJson(categoryJson))
            .toList();

        return categories;
      } else {
        throw Exception('Failed to load categories: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }
}
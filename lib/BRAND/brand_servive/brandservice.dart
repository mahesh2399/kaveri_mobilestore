import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';

import 'package:kaveri/BRAND/brand)_model/brand_model.dart';
import 'package:http/http.dart' as http;
import 'package:kaveri/constants/api_url.dart';

class BrandService {
  // Future<List<Brand>> fetchBrands() async {
  //   try {
  //     final jsonString = await rootBundle.loadString('lib/json/brands.json');
  //     //  log(jsonString);
  //     final jsonData = jsonDecode(jsonString)["data"] as List<dynamic>;
  //     return jsonData.map((brandJson) => Brand.fromJson(brandJson)).toList();
  //   } catch (e) {
  //     throw Exception('Failed to load brands: $e');
  //   }
  // }
  Future<List<Brand>> fetchBrands() async {
    try {
      final response = await http.get(
        Uri.parse('$kbaseUrl/admin/getbrands'),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body)["data"] as List<dynamic>;
        log(response.body);  
        final brand =
            jsonData.map((brandJson) => Brand.fromJson(brandJson)).toList();

        return brand;
      } else {
        throw Exception('Failed to load products: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}

import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:kaveri/BRAND/brand)_model/brand_model.dart';

class BrandService {
  Future<List<Brand>> fetchBrands() async {
    try {
      final jsonString = await rootBundle.loadString('lib/json/brands.json');
      //  log(jsonString);
      final jsonData = jsonDecode(jsonString)["data"] as List<dynamic>;
      return jsonData.map((brandJson) => Brand.fromJson(brandJson)).toList();
    } catch (e) {
      throw Exception('Failed to load brands: $e');
    }
  }
}

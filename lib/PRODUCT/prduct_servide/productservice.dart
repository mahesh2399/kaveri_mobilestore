// import 'dart:convert';

// import 'package:flutter/services.dart';
// import 'package:kaveri/PRODUCT/product_model/product_model.dart';

// class ProductService {
//   Future<List<Product>> fetchProducts() async {
//     try {
//       final jsonString = await rootBundle.loadString('lib/json/products.json');

//       // log(jsonString);

//       final jsonData = jsonDecode(jsonString)["data"] as List<dynamic>;

//       final products =
//           jsonData.map((productJson) => Product.fromJson(productJson)).toList();

//       return products;
//     } catch (e) {
//       throw Exception('Failed to load products: $e');
//     }
//   }
// }

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:kaveri/PRODUCT/product_model/product_model.dart';
import 'package:kaveri/constants/api_url.dart';

class ProductService {
  // Future<List<Product>> fetchProducts() async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse('$kbaseUrl/admin/get_products'),
  //     );
  //     print(response.body);

  //     if (response.statusCode == 200) {
  //       final jsonData = jsonDecode(response.body)["data"] as List<dynamic>;
  //       log(jsonData as String);
  //       final products = jsonData
  //           .map((productJson) => Product.fromJson(productJson))
  //           .toList();

  //       return products;
  //     } else {
  //       throw Exception('Failed to load products: ${response.reasonPhrase}');
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to load products: $e');
  //   }
  // }
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse('$kbaseUrl/admin/get_products'),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body)["data"] as List<dynamic>;
        log(response.body); // Logging the response body as a string
        final products = jsonData
            .map((productJson) => Product.fromJson(productJson))
            .toList();

        return products;
      } else {
        throw Exception('Failed to load products: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}

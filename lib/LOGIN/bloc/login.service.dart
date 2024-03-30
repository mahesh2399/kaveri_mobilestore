import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kaveri/constants/api_url.dart';

class LoginService {
  static const String baseUrl = "http://192.168.0.165/admin/login";

  static Future<bool> authenticateUser(String username, String password) async {
    try {
      final Map<String, String> requestBody = {
        'username': username,
        'password': password,
      };

      final String requestBodyJson = jsonEncode(requestBody);

      final http.Response response = await http.post(
        Uri.parse(kbaseUrl + 'admin/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: requestBodyJson,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw true;
      }
    } catch (e) {
      throw true;
    }
  }
}

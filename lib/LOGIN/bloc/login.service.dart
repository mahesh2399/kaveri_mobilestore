import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  static const String baseUrl = "http://localhost:8080/api/";

  static Future<bool> authenticateUser(String username, String password) async {
    try {
      final Map<String, String> requestBody = {
        'username': username,
        'password': password,
      };

      final String requestBodyJson = jsonEncode(requestBody);

      final http.Response response = await http.post(
        Uri.parse(baseUrl + 'login'),
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

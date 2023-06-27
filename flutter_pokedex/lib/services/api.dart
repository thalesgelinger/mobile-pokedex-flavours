import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  static Future<dynamic> get(String endpoint) async {
    final url = Uri.parse(endpoint);
    final response = await http.get(url);
    final json = jsonDecode(response.body);
    return json;
  }
}

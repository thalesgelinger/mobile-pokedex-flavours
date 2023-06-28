import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  static Future<dynamic> get(String endpoint) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(endpoint)) {
      return jsonDecode(prefs.getString(endpoint)!);
    }
    final url = Uri.parse(endpoint);
    final response = await http.get(url);
    final json = jsonDecode(response.body);
    prefs.setString(endpoint, jsonEncode(json));
    return json;
  }
}

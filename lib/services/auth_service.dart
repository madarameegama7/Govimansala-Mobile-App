import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _baseUrl = 'http://localhost:8080/api/auth'; 
static Future<bool> login(String email, String password) async {
  final response = await http.post(
    Uri.parse('$_baseUrl/login'),
    headers: {
      'Content-Type': 'application/json',
      'X-Client-Source': 'mobile',
    },
    body: jsonEncode({'email': email, 'password': password}),
  );

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print('Parsed response data: $data');
    print('Token: ${data['token']}');

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['token']);
      await prefs.setString('role', data['role']);
      print('Token saved successfully');
    } catch (e) {
      print('Error saving token: $e');
    }
    return true;
  } else {
    print('Login failed');
    return false;
  }
}

}

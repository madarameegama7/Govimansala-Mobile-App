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

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['token']);
      await prefs.setString('role', data['role']);
      await prefs.setInt('userId', data['userId']);

      print('Token and userId saved successfully');
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

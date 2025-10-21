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
Future<Map<String, dynamic>> updateProfile(
      String token, Map<String, dynamic> updatedData) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/update-profile'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(updatedData),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print("Error updating profile: ${response.statusCode} -> ${response.body}");
      throw Exception('Failed to update profile');
    }
  }
  static Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String address,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/register'),
      headers: {
        'Content-Type': 'application/json',
        'X-Client-Source': 'mobile',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'address': address,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Registration successful');
      return true;
    } else {
      print('Registration failed: ${response.body}');
      return false;
    }
  }

}

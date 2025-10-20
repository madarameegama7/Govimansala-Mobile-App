import 'dart:convert';
import 'package:http/http.dart' as http;

class FarmerService {
  final String baseUrl = "http://localhost:8080/api/admin/farmers"; // adjust as needed

  Future<Map<String, dynamic>> getFarmerByUserId(int userId, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/$userId'),
      headers: {'Authorization': 'Bearer $token'},
    );

   if (response.statusCode == 200) {
  return json.decode(response.body);
} else {
  print("Error: ${response.statusCode} -> ${response.body}");
  throw Exception('Failed to load farmer profile');
}

  }
}

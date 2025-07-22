// services/add_to_cart_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OrderService {
  static Future<void> addToCart(int productId, int quantity) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final url = Uri.parse("http://localhost:8080/api/order/addtoCart");

    final body = jsonEncode({
      "items": [
        {
          "productId": productId,
          "quantity": quantity,
        }
      ]
    });

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: body,
    );

    print("Response Status: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode != 200) {
      throw Exception("Failed to add to cart: ${response.body}");
    }
  } catch (e, stackTrace) {
    print("Exception caught in addToCart: $e");
    print("StackTrace: $stackTrace");
    rethrow; // Rethrow to let the caller also handle it
  }
}

}

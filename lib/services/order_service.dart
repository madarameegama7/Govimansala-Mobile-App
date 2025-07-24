// services/add_to_cart_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:govimansala/models/order_model.dart';

class OrderService {
  static const String baseUrl = "http://localhost:8080/api/order";

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

// Checkout Cart by CartId
  static Future<Order?> checkoutCart(int cartId) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null || token.isEmpty) {
      print("No token found in SharedPreferences.");
      return null;
    }

    final url = Uri.parse('$baseUrl/checkout/$cartId');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Order.fromJson(data);
    } else {
      print('Failed to checkout cart: ${response.statusCode}');
      print('Response body: ${response.body}');
      return null;
    }
  } catch (e, stackTrace) {
    print('Exception during checkoutCart: $e');
    print('StackTrace: $stackTrace');
    return null;
  }
}

}

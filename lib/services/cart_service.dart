import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart.dart';

class CartService {
  static Future<CartModel?> getCartByUserId(int userId) async {
    final url = Uri.parse('http://localhost:8080/api/order/getCartByUserId/$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List decoded = jsonDecode(response.body);
      if (decoded.isNotEmpty) {
        return CartModel.fromJson(decoded.first);
      }
    }
    return null;
  }
}

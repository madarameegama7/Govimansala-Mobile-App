import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/item.dart';

class ProductService {
  static Future<List<Item>> fetchProducts({String? category}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception("User not authenticated. Token not found.");
    }

    final url = Uri.parse("http://localhost:8080/api/product/category/$category");

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Item.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load products: ${response.statusCode}");
    }
  }
  static Future<Item?> fetchProductById(int productId) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  if (token == null) {
    throw Exception("User not authenticated. Token not found.");
  }

  final url = Uri.parse("http://localhost:8080/api/product/id/$productId");

  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return Item.fromJson(data);
  } else {
    throw Exception("Failed to load product with id $productId: ${response.statusCode}");
  }
}

}

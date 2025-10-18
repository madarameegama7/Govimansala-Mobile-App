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

  // Farmer Product Methods
  static Future<bool> addFarmerProduct(Map<String, dynamic> productData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      print("=== ADD PRODUCT DEBUG ===");
      print("Token exists: ${token != null}");

      if (token == null) {
        throw Exception("User not authenticated. Token not found.");
      }

      // Prepare data to match Java FarmerProduct model exactly
      // Note: userId will be set by backend from JWT token
      final backendData = <String, dynamic>{
        'name': productData['name']?.toString(),
        'category': productData['category']?.toString(),
        'unitPrice': (productData['unit_price'] is String 
            ? double.parse(productData['unit_price']) 
            : productData['unit_price'])?.toDouble(),
        'quantity': (productData['quantity'] is String 
            ? int.parse(productData['quantity']) 
            : productData['quantity'])?.toInt(),
        'status': productData['status']?.toString() ?? 'AVAILABLE',
        'location': productData['location']?.toString(),
        'description': productData['description']?.toString(),
        'isOrganic': productData['is_organic'] == true,
      };

      // Handle dates safely - convert to YYYY-MM-DD format for LocalDate
      if (productData['harvest_date'] != null) {
        backendData['harvestDate'] = productData['harvest_date'].toString();
      }
      if (productData['expiry_date'] != null) {
        backendData['expiryDate'] = productData['expiry_date'].toString();
      }

      print("Backend data: ${json.encode(backendData)}");

      final url = Uri.parse("http://localhost:8080/api/product/farmer_product/add");
      print("Request URL: $url");

      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(backendData),
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      print("========================");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception("Failed to add farmer product: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error in addFarmerProduct: $e");
      rethrow;
    }
  }

  static Future<List<Map<String, dynamic>>> fetchFarmerProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception("User not authenticated. Token not found.");
    }

    final url = Uri.parse("http://localhost:8080/api/product/farmer_product");

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception("Failed to load farmer products: ${response.statusCode}");
    }
  }

  static Future<bool> updateFarmerProduct(int productId, Map<String, dynamic> productData) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception("User not authenticated. Token not found.");
    }

    final url = Uri.parse("http://localhost:8080/api/farmer_product/update/$productId");

    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(productData),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to update farmer product: ${response.statusCode} - ${response.body}");
    }
  }

  // Debug method to check token validity
  static Future<void> debugTokenInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    
    print("=== TOKEN DEBUG INFO ===");
    print("Token exists: ${token != null}");
    print("Token length: ${token?.length ?? 0}");
    if (token != null && token.length > 20) {
      print("Token preview: ${token.substring(0, 20)}...");
    }
    print("=====================");
  }

  static Future<bool> deleteFarmerProduct(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception("User not authenticated. Token not found.");
    }

    final url = Uri.parse("http://localhost:8080/api/farmer_product/delete/$productId");

    final response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to delete farmer product: ${response.statusCode} - ${response.body}");
    }
  }

}

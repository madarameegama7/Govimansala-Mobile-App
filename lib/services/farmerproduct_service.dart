// lib/services/farmer_products.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/farmer_product.dart';

class FarmerProductService {
  static const String baseUrl = 'http://localhost:8080/api/product';
  
  // Get auth headers
  static Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  // Add product to backend
  static Future<bool> addFarmerProduct(Product product) async {
    try {
      final headers = await _getHeaders();
      final url = Uri.parse('$baseUrl/farmer_product/add');
      
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(product.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception('Failed to add product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Get all farmer products
  static Future<List<Product>> fetchFarmerProducts() async {
    try {
      final headers = await _getHeaders();
      final url = Uri.parse('$baseUrl/farmer_product/all');
      
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => _parseProductFromJson(json)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Update product
  static Future<bool> updateFarmerProduct(Product product) async {
    try {
      final headers = await _getHeaders();
      final url = Uri.parse('$baseUrl/farmer_product/update/${product.id}');
      
      final response = await http.put(
        url,
        headers: headers,
        body: json.encode(product.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to update product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Delete product
  static Future<bool> deleteFarmerProduct(String productId) async {
    try {
      final headers = await _getHeaders();
      final url = Uri.parse('$baseUrl/farmer_product/delete/$productId');
      
      final response = await http.delete(url, headers: headers);

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to delete product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Parse product from JSON response
  static Product _parseProductFromJson(Map<String, dynamic> json) {
    return Product(
      id: json['productId']?.toString() ?? json['id']?.toString(),
      name: json['name']?.toString() ?? '',
      price: (json['unitPrice'] ?? json['price'] ?? 0).toDouble(),
      description: json['description']?.toString() ?? '',
      imageUrl: getProductImage(json['name']?.toString() ?? ''),
      category: json['category']?.toString() ?? '',
      stock: (json['quantity'] ?? json['stock'] ?? 0).toInt(),
      location: json['location']?.toString() ?? '',
      isOrganic: json['isOrganic'] ?? json['is_organic'] ?? false,
      status: json['status']?.toString() ?? 'AVAILABLE',
      harvestDate: json['harvestDate'] != null 
          ? DateTime.tryParse(json['harvestDate'].toString()) 
          : null,
      expiryDate: json['expiryDate'] != null 
          ? DateTime.tryParse(json['expiryDate'].toString()) 
          : null,
      createdAt: json['createdAt'] != null 
          ? DateTime.tryParse(json['createdAt'].toString()) 
          : null,
      updatedAt: json['updatedAt'] != null 
          ? DateTime.tryParse(json['updatedAt'].toString()) 
          : null,
    );
  }

  // Helper to get product image based on na
  static String getProductImage(String productName) {
  final images = {
    'Tomato': 'assets/tomato.jpg',
    'Carrot': 'assets/productImages/carrots.jpg',
    'Brinjal': 'assets/productImages/brinjal.jpg',
    'Potato': 'assets/productImages/potatoes.jpg',
    'Onion': 'assets/productImages/red_onions.jpg',
    'Avocado': 'assets/productImages/avocado.jpg',
    'Banana': 'assets/productImages/bananas.jpg',
    'Guava': 'assets/productImages/guava.jpg',
    'Mango': 'assets/productImages/mango.jpg',
    'Papaya': 'assets/productImages/papaya.jpg',
    'Watermelon': 'assets/productImages/watermelon.jpg',
    'Pineapple': 'assets/productImages/pineapple.jpg',
  };
  
  for (final key in images.keys) {
    if (productName.toLowerCase().contains(key.toLowerCase())) {
      return images[key]!;
    }
  }
  
  return 'assets/productImages/default_product.png';
}
}
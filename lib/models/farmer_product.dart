class FarmerProduct {
  final int? productId;
  final int? userId;  // Made optional since backend sets this from JWT
  final String name;
  final String category;
  final double unitPrice;
  final int quantity;
  final DateTime? harvestDate;
  final DateTime? expiryDate;
  final String status;
  final String location;
  final String description;
  final bool isOrganic;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  FarmerProduct({
    this.productId,
    this.userId,  // Made optional since backend sets this from JWT
    required this.name,
    required this.category,
    required this.unitPrice,
    required this.quantity,
    this.harvestDate,
    this.expiryDate,
    this.status = 'AVAILABLE',
    required this.location,
    required this.description,
    this.isOrganic = false,
    this.createdAt,
    this.updatedAt,
  });

  // Convert from JSON (API response) - matches Java field names
  factory FarmerProduct.fromJson(Map<String, dynamic> json) {
    return FarmerProduct(
      productId: json['productId'] as int?,
      userId: json['userId'] as int?,  // Made optional
      name: json['name'] as String,
      category: json['category'] as String,
      unitPrice: (json['unitPrice'] as num).toDouble(),
      quantity: json['quantity'] as int,
      harvestDate: json['harvestDate'] != null 
          ? DateTime.parse(json['harvestDate']) 
          : null,
      expiryDate: json['expiryDate'] != null 
          ? DateTime.parse(json['expiryDate']) 
          : null,
      status: json['status'] as String? ?? 'AVAILABLE',
      location: json['location'] as String,
      description: json['description'] as String,
      isOrganic: json['isOrganic'] as bool? ?? false,
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : null,
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt']) 
          : null,
    );
  }

  // Convert to JSON (API request) - matches Java field names
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'userId': userId,
      'name': name,
      'category': category,
      'unitPrice': unitPrice,
      'quantity': quantity,
      'status': status,
      'location': location,
      'description': description,
      'isOrganic': isOrganic,
    };

    if (productId != null) {
      data['productId'] = productId;
    }
    if (harvestDate != null) {
      data['harvestDate'] = harvestDate!.toIso8601String().split('T')[0];
    }
    if (expiryDate != null) {
      data['expiryDate'] = expiryDate!.toIso8601String().split('T')[0];
    }

    return data;
  }

  // Convert to Product for UI compatibility
  Product toProduct() {
    // Product images mapping
    final Map<String, String> productImages = {
      'Carrots': 'assets/products/carrots.jpg',
      'Brinjal': 'assets/products/brinjal.jpg',
      'Potatoes': 'assets/products/potatoes.jpg',
      'Red Onions': 'assets/products/red_onions.jpg',
      'Tomatoes': 'assets/tomato.jpg',
      'Avocado': 'assets/products/avocado.jpg',
      'Bananas': 'assets/products/bananas.jpg',
      'Guava': 'assets/products/guava.jpg',
      'Mango': 'assets/products/mango.jpg',
      'Papaya': 'assets/products/papaya.jpg',
      'Watermelon': 'assets/products/watermelon.jpg',
      'Pineapple': 'assets/products/pineapple.jpg',
    };

    return Product(
      id: productId?.toString() ?? '',
      name: name,
      price: unitPrice,
      description: description,
      imageUrl: productImages[name] ?? 'assets/productImages/default_product.png',
      category: category,
      stock: quantity,
      location: location,
      isOrganic: isOrganic,
      status: status,
      harvestDate: harvestDate,
      expiryDate: expiryDate,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

// Import the Product class (assuming it's in the same package or imported)
class Product {
  final String id;
  final String name;
  final double price;
  final String description;
  final String imageUrl;
  final String category;
  final int stock;
  final String? location;
  final bool isOrganic;
  final String status;
  final DateTime? harvestDate;
  final DateTime? expiryDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.stock,
    this.location,
    this.isOrganic = false,
    this.status = 'AVAILABLE',
    this.harvestDate,
    this.expiryDate,
    this.createdAt,
    this.updatedAt,
  });

  // Convert from JSON (API response)
  factory Product.fromJson(Map<String, dynamic> json) {
    final Map<String, String> productImages = {
      'Carrots': 'assets/products/carrots.jpg',
      'Brinjal': 'assets/products/brinjal.jpg',
      'Potatoes': 'assets/products/potatoes.jpg',
      'Red Onions': 'assets/products/red_onions.jpg',
      'Tomatoes': 'assets/tomato.jpg',
      'Avocado': 'assets/products/avocado.jpg',
      'Bananas': 'assets/products/bananas.jpg',
      'Guava': 'assets/products/guava.jpg',
      'Mango': 'assets/products/mango.jpg',
      'Papaya': 'assets/products/papaya.jpg',
      'Watermelon': 'assets/products/watermelon.jpg',
      'Pineapple': 'assets/products/pineapple.jpg',
    };

    final productName = json['name'] ?? '';
    
    return Product(
      id: json['productId']?.toString() ?? json['product_id']?.toString() ?? '',
      name: productName,
      price: (json['unitPrice'] ?? json['unit_price'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] ?? '',
      imageUrl: productImages[productName] ?? 'assets/productImages/default_product.png',
      category: json['category'] ?? '',
      stock: (json['quantity'] as num?)?.toInt() ?? 0,
      location: json['location'],
      isOrganic: json['isOrganic'] ?? json['is_organic'] ?? false,
      status: json['status'] ?? 'AVAILABLE',
      harvestDate: json['harvestDate'] != null || json['harvest_date'] != null
          ? DateTime.tryParse(json['harvestDate'] ?? json['harvest_date']) 
          : null,
      expiryDate: json['expiryDate'] != null || json['expiry_date'] != null
          ? DateTime.tryParse(json['expiryDate'] ?? json['expiry_date']) 
          : null,
      createdAt: json['createdAt'] != null || json['created_at'] != null
          ? DateTime.tryParse(json['createdAt'] ?? json['created_at']) 
          : null,
      updatedAt: json['updatedAt'] != null || json['updated_at'] != null
          ? DateTime.tryParse(json['updatedAt'] ?? json['updated_at']) 
          : null,
    );
  }

  // Convert to JSON (API request)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'unitPrice': price,
      'quantity': stock,
      'description': description,
      if (location != null) 'location': location,
      'isOrganic': isOrganic,
      'status': status,
      if (harvestDate != null) 'harvestDate': harvestDate!.toIso8601String().split('T')[0],
      if (expiryDate != null) 'expiryDate': expiryDate!.toIso8601String().split('T')[0],
    };
  }

  String get formattedPrice => 'Rs. ${price.toStringAsFixed(0)}';

  String get stockStatus {
    if (status != 'AVAILABLE') return status;
    if (stock <= 0) return 'Out of Stock';
    if (stock < 10) return 'Low Stock';
    return 'In Stock';
  }

  bool get isExpired {
    if (expiryDate == null) return false;
    return DateTime.now().isAfter(expiryDate!);
  }
}
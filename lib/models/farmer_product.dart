class Product {
  final String? id;
  final String name;
  final double price;
  final String description;
  final String imageUrl;
  final String category;
  final int stock;
  final String location;
  final bool isOrganic;
  final String status;
  final DateTime? harvestDate;
  final DateTime? expiryDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Product({
    this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.stock,
    required this.location,
    this.isOrganic = false,
    this.status = 'AVAILABLE',
    this.harvestDate,
    this.expiryDate,
    this.createdAt,
    this.updatedAt,
  });

  // Convert to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'unitPrice': price,
      'quantity': stock,
      'description': description,
      'location': location,
      'isOrganic': isOrganic,
      'status': status,
      if (harvestDate != null) 'harvestDate': _formatDate(harvestDate!),
      if (expiryDate != null) 'expiryDate': _formatDate(expiryDate!),
    };
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  // Copy with method for updates
  Product copyWith({
    String? name,
    double? price,
    String? description,
    String? imageUrl,
    String? category,
    int? stock,
    String? location,
    bool? isOrganic,
    String? status,
    DateTime? harvestDate,
    DateTime? expiryDate,
  }) {
    return Product(
      id: id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      stock: stock ?? this.stock,
      location: location ?? this.location,
      isOrganic: isOrganic ?? this.isOrganic,
      status: status ?? this.status,
      harvestDate: harvestDate ?? this.harvestDate,
      expiryDate: expiryDate ?? this.expiryDate,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
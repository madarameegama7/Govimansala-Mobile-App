import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../services/product_service.dart';

class MyProductsPage extends StatefulWidget {
  const MyProductsPage({super.key});

  @override
  State<MyProductsPage> createState() => _MyProductsPageState();
}

class _MyProductsPageState extends State<MyProductsPage> {
  List<Product> myProducts = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadMyProducts();
  }

  Future<void> _loadMyProducts() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      print("=== LOADING PRODUCTS DEBUG ===");
      final farmerProducts = await ProductService.fetchFarmerProducts();
      print("Raw farmer products data: $farmerProducts");
      
      setState(() {
        myProducts = farmerProducts.map((productData) {
          print("Converting product data: $productData");
          try {
            return Product.fromJson(productData);
          } catch (e) {
            print("Error converting product: $e");
            print("Problematic data: $productData");
            rethrow;
          }
        }).toList();
        isLoading = false;
      });
      
      print("Successfully loaded ${myProducts.length} products");
      print("=============================");
    } catch (e) {
      print("Error in _loadMyProducts: $e");
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
      print('Error loading products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Products'),
        actions: [
          IconButton(
            onPressed: _loadMyProducts,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? _buildErrorState()
              : myProducts.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: myProducts.length,
                      itemBuilder: (context, index) {
                        return _buildProductCard(myProducts[index]);
                      },
                    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddProductDialog();
        },
        child: const Icon(IconlyLight.plus),
        tooltip: 'Add Product',
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 80,
            color: Colors.red[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Error loading products',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.red[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            errorMessage ?? 'Unknown error occurred',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _loadMyProducts,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            IconlyLight.bag,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No products added yet',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the + button to add your first product',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[500],
                ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              _showAddProductDialog();
            },
            icon: const Icon(IconlyLight.plus),
            label: const Text('Add Product'),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                product.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[200],
                    child: const Icon(
                      IconlyLight.image,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'Rs. ${product.price.toStringAsFixed(0)}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const Spacer(),
                      Text(
                        'Stock: ${product.stock}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'edit':
                    _showEditProductDialog(product);
                    break;
                  case 'delete':
                    _showDeleteConfirmation(product);
                    break;
                }
              },
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem<String>(
                  value: 'edit',
                  child: ListTile(
                    leading: Icon(IconlyLight.edit),
                    title: Text('Edit'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'delete',
                  child: ListTile(
                    leading: Icon(IconlyLight.delete),
                    title: Text('Delete'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAddProductDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddProductDialog(
          onProductAdded: (Product product) {
            _loadMyProducts(); // Refresh the list from database
          },
        );
      },
    );
  }

  void _showEditProductDialog(Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddProductDialog(
          product: product,
          onProductAdded: (Product updatedProduct) {
            _loadMyProducts(); // Refresh the list from database
          },
        );
      },
    );
  }

  void _showDeleteConfirmation(Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Product'),
          content: Text('Are you sure you want to delete "${product.name}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  myProducts.removeWhere((p) => p.id == product.id);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.name} deleted successfully'),
                  ),
                );
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}

class AddProductDialog extends StatefulWidget {
  final Product? product;
  final Function(Product) onProductAdded;

  const AddProductDialog({
    super.key,
    this.product,
    required this.onProductAdded,
  });

  @override
  State<AddProductDialog> createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  late TextEditingController _stockController;
  late TextEditingController _locationController;
  String _selectedCategory = 'Vegetables';
  String _selectedStatus = 'AVAILABLE';
  bool _isOrganic = false;
  DateTime? _harvestDate;
  DateTime? _expiryDate;

  final List<String> _categories = [
    'Vegetables',
    'Fruits'
  ];

  final Map<String, List<String>> _categoryProducts = {
    'Vegetables': ['Carrots', 'Brinjal', 'Potatoes', 'Red Onions', 'Tomatoes'],
    'Fruits': ['Avocado', 'Bananas', 'Guava', 'Mango', 'Papaya', 'Watermelon', 'Pineapple'],
  };

  final Map<String, String> _productImages = {
    // Vegetables - Updated to match actual asset paths
    'Carrots': 'assets/carrot.jpg',
    'Brinjal': 'assets/Brinjal.jpg',
    'Potatoes': 'assets/Potatoes.jpg',
    'Red Onions': 'assets/RedOnion.jpg',
    'Tomatoes': 'assets/tomato.jpg',
    // Fruits - Updated to match actual asset paths
    'Avocado': 'assets/avacado.jpg',
    'Bananas': 'assets/banana.jpg',
    'Guava': 'assets/guava.jpg',
    'Mango': 'assets/mango.jpeg',
    'Papaya': 'assets/papaya.jpeg',
    'Watermelon': 'assets/watermelon.jpg',
    'Pineapple': 'assets/pineapple.jpeg',
  };

  String? _selectedProduct;

  final List<String> _statusOptions = [
    'AVAILABLE',
    'OUT_OF_STOCK',
    'DISCONTINUED'
  ];

  @override
  void initState() {
    super.initState();
    _priceController = TextEditingController(
        text: widget.product?.price.toString() ?? '');
    _descriptionController =
        TextEditingController(text: widget.product?.description ?? '');
    _stockController =
        TextEditingController(text: widget.product?.stock.toString() ?? '');
    _locationController = TextEditingController(text: widget.product?.location ?? '');
    _selectedCategory = widget.product?.category ?? 'Vegetables';
    _selectedStatus = widget.product?.status ?? 'AVAILABLE';
    _isOrganic = widget.product?.isOrganic ?? false;
    _harvestDate = widget.product?.harvestDate;
    _expiryDate = widget.product?.expiryDate;
    
    // Initialize selected product based on existing product name or first item
    if (widget.product != null && _categoryProducts[_selectedCategory]?.contains(widget.product!.name) == true) {
      _selectedProduct = widget.product!.name;
    } else {
      _selectedProduct = _categoryProducts[_selectedCategory]?.first;
    }
  }

  @override
  void dispose() {
    _priceController.dispose();
    _descriptionController.dispose();
    _stockController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.product == null ? 'Add Product' : 'Edit Product'),
      content: SizedBox(
        width: double.maxFinite,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
                  items: _categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue!;
                      // Reset product selection when category changes
                      _selectedProduct = _categoryProducts[_selectedCategory]?.first;
                    });
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedProduct,
                  decoration: const InputDecoration(
                    labelText: 'Product Name',
                    border: OutlineInputBorder(),
                  ),
                  items: _categoryProducts[_selectedCategory]?.map((String product) {
                    return DropdownMenuItem<String>(
                      value: product,
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.asset(
                              _productImages[product] ?? 'assets/productImages/default_product.png',
                              width: 24,
                              height: 24,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 24,
                                  height: 24,
                                  color: Colors.grey[200],
                                  child: const Icon(Icons.image, size: 16),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(product),
                        ],
                      ),
                    );
                  }).toList() ?? [],
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedProduct = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a product';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price (Rs.)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter valid price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _stockController,
                  decoration: const InputDecoration(
                    labelText: 'Stock Quantity',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter stock quantity';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter valid quantity';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    labelText: 'Farm Location',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter farm location';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedStatus,
                  decoration: const InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(),
                  ),
                  items: _statusOptions.map((String status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Text(status.replaceAll('_', ' ')),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedStatus = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Organic Product'),
                  value: _isOrganic,
                  onChanged: (bool value) {
                    setState(() {
                      _isOrganic = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: _harvestDate ?? DateTime.now(),
                            firstDate: DateTime.now().subtract(const Duration(days: 365)),
                            lastDate: DateTime.now(),
                          );
                          if (date != null) {
                            setState(() {
                              _harvestDate = date;
                            });
                          }
                        },
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Harvest Date',
                            border: OutlineInputBorder(),
                          ),
                          child: Text(
                            _harvestDate != null
                                ? '${_harvestDate!.day}/${_harvestDate!.month}/${_harvestDate!.year}'
                                : 'Select Date',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: _expiryDate ?? DateTime.now().add(const Duration(days: 30)),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(const Duration(days: 365)),
                          );
                          if (date != null) {
                            setState(() {
                              _expiryDate = date;
                            });
                          }
                        },
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Expiry Date',
                            border: OutlineInputBorder(),
                          ),
                          child: Text(
                            _expiryDate != null
                                ? '${_expiryDate!.day}/${_expiryDate!.month}/${_expiryDate!.year}'
                                : 'Select Date',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              try {
                print("=== FORM SUBMISSION DEBUG ===");
                print("Selected product: $_selectedProduct");
                print("Selected category: $_selectedCategory");
                print("Price: ${_priceController.text}");
                print("Stock: ${_stockController.text}");
                print("Harvest date: $_harvestDate");
                print("Expiry date: $_expiryDate");
                
                // Debug token info
                await ProductService.debugTokenInfo();
                
                // Prepare data for backend API - match Java backend field names
                final productData = {
                  'name': _selectedProduct!, // Use selected product name
                  'category': _selectedCategory,
                  'unitPrice': double.parse(_priceController.text), // camelCase to match Java
                  'quantity': int.parse(_stockController.text),
                  'harvestDate': _harvestDate?.toIso8601String().split('T')[0], // camelCase to match Java
                  'expiryDate': _expiryDate?.toIso8601String().split('T')[0], // camelCase to match Java
                  'status': _selectedStatus,
                  'location': _locationController.text.trim(),
                  'description': _descriptionController.text.trim(),
                  'isOrganic': _isOrganic, // camelCase to match Java
                };

                print("Product data to send: $productData");

                // Send to backend
                bool success = await ProductService.addFarmerProduct(productData);
                print("Add product success: $success");

                // Create product for local state update
                final product = Product(
                  id: widget.product?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
                  name: _selectedProduct!, // Use selected product name
                  price: double.parse(_priceController.text),
                  description: _descriptionController.text.trim(),
                  category: _selectedCategory,
                  stock: int.parse(_stockController.text),
                  imageUrl: _productImages[_selectedProduct!] ?? 'assets/productImages/default_product.png', // Automatic image
                  location: _locationController.text.trim(),
                  isOrganic: _isOrganic,
                  status: _selectedStatus,
                  harvestDate: _harvestDate,
                  expiryDate: _expiryDate,
                  createdAt: widget.product?.createdAt ?? DateTime.now(),
                  updatedAt: DateTime.now(),
                );
                
                widget.onProductAdded(product);
                Navigator.of(context).pop();
                
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(widget.product == null 
                        ? 'Product added successfully to database!' 
                        : 'Product updated successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
                print("===========================");
              } catch (e) {
                print("Error in form submission: $e");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error: ${e.toString()}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            } else {
              print("Form validation failed");
            }
          },
          child: Text(widget.product == null ? 'Add' : 'Update'),
        ),
      ],
    );
  }
}

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
    // Define the product images mapping here too for consistency
    final Map<String, String> productImages = {
      // Vegetables - Updated to match actual asset paths
      'Carrots': 'assets/carrot.jpg',
      'Brinjal': 'assets/Brinjal.jpg',
      'Potatoes': 'assets/Potatoes.jpg',
      'Red Onions': 'assets/RedOnion.jpg',
      'Tomatoes': 'assets/tomato.jpg',
      // Fruits - Updated to match actual asset paths
      'Avocado': 'assets/avacado.jpg',
      'Bananas': 'assets/banana.jpg',
      'Guava': 'assets/guava.jpg',
      'Mango': 'assets/mango.jpeg',
      'Papaya': 'assets/papaya.jpeg',
      'Watermelon': 'assets/watermelon.jpg',
      'Pineapple': 'assets/pineapple.jpeg',
    };

    final productName = json['name']?.toString() ?? '';
    
    // Safe conversion for productId - handle both int and string cases
    String productId = '';
    if (json['productId'] != null) {
      productId = json['productId'].toString();
    } else if (json['product_id'] != null) {
      productId = json['product_id'].toString();
    }

    // Handle product name variations for image mapping
    String imageKey = productName;
    if (productName.contains('Tomato')) {
      imageKey = 'Tomatoes';
    } else if (productName.contains('Carrot')) {
      imageKey = 'Carrots';
    } else if (productName.contains('Brinjal')) {
      imageKey = 'Brinjal';
    } else if (productName.contains('Potato')) {
      imageKey = 'Potatoes';
    } else if (productName.contains('Onion')) {
      imageKey = 'Red Onions';
    } else if (productName.contains('Avocado')) {
      imageKey = 'Avocado';
    } else if (productName.contains('Banana')) {
      imageKey = 'Bananas';
    } else if (productName.contains('Guava')) {
      imageKey = 'Guava';
    } else if (productName.contains('Mango')) {
      imageKey = 'Mango';
    } else if (productName.contains('Papaya')) {
      imageKey = 'Papaya';
    } else if (productName.contains('Watermelon')) {
      imageKey = 'Watermelon';
    } else if (productName.contains('Pineapple')) {
      imageKey = 'Pineapple';
    }
    
    return Product(
      id: productId,
      name: productName,
      price: (json['unitPrice'] ?? json['unit_price'] ?? 0).toDouble(),
      description: json['description']?.toString() ?? '',
      imageUrl: productImages[imageKey] ?? 'assets/productImages/default_product.png', // Auto-assign image using imageKey
      category: json['category']?.toString() ?? '',
      stock: (json['quantity'] ?? 0).toInt(),
      location: json['location']?.toString(),
      isOrganic: json['isOrganic'] ?? json['is_organic'] ?? false,
      status: json['status']?.toString() ?? 'AVAILABLE',
      harvestDate: json['harvestDate'] != null || json['harvest_date'] != null
          ? DateTime.tryParse((json['harvestDate'] ?? json['harvest_date']).toString()) 
          : null,
      expiryDate: json['expiryDate'] != null || json['expiry_date'] != null
          ? DateTime.tryParse((json['expiryDate'] ?? json['expiry_date']).toString()) 
          : null,
      createdAt: json['createdAt'] != null || json['created_at'] != null
          ? DateTime.tryParse((json['createdAt'] ?? json['created_at']).toString()) 
          : null,
      updatedAt: json['updatedAt'] != null || json['updated_at'] != null
          ? DateTime.tryParse((json['updatedAt'] ?? json['updated_at']).toString()) 
          : null,
    );
  }

  // Convert to JSON (API request)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'unit_price': price,
      'quantity': stock,
      'description': description,
      if (location != null) 'location': location,
      'is_organic': isOrganic,
      'status': status,
      if (harvestDate != null) 'harvest_date': harvestDate!.toIso8601String().split('T')[0],
      if (expiryDate != null) 'expiry_date': expiryDate!.toIso8601String().split('T')[0],
    };
  }

  // Helper method to get formatted price
  String get formattedPrice => 'Rs. ${price.toStringAsFixed(0)}';

  // Helper method to check stock status
  String get stockStatus {
    if (status != 'AVAILABLE') return status;
    if (stock <= 0) return 'Out of Stock';
    if (stock < 10) return 'Low Stock';
    return 'In Stock';
  }

  // Helper method to check if expired
  bool get isExpired {
    if (expiryDate == null) return false;
    return DateTime.now().isAfter(expiryDate!);
  }
}

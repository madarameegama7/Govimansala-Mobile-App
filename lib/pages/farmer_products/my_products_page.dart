// lib/pages/my_products/my_products_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../../services/farmerproduct_service.dart';
import '../../models/farmer_product.dart';
import 'add_product_dialog.dart';

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

      final products = await FarmerProductService.fetchFarmerProducts();

      setState(() {
        myProducts = products;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> _addProduct(Product product) async {
    try {
      final success = await FarmerProductService.addFarmerProduct(product);
      if (success) {
        await _loadMyProducts();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Product added successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add product: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _updateProduct(Product product) async {
    try {
      final success = await FarmerProductService.updateFarmerProduct(product);
      if (success) {
        await _loadMyProducts();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Product updated successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update product: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _deleteProduct(String productId) async {
    try {
      final success = await FarmerProductService.deleteFarmerProduct(productId);
      if (success) {
        setState(() {
          myProducts.removeWhere((p) => p.id == productId);
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Product deleted successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete product: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget productImage(Product product, {double size = 80}) {
    final name = product.name.toLowerCase().replaceAll(" ", "_");
    final exts = ['jpg', 'jpeg', 'png'];

    Widget tryNext(int index) {
      if (index >= exts.length) {
        return Image.asset(
          'assets/productImages/default_product.png',
          width: size,
          height: size,
          fit: BoxFit.cover,
        );
      }

      final path = 'assets/productImages/$name.${exts[index]}';
      return Image.asset(
        path,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => tryNext(index + 1),
      );
    }

    return tryNext(0);
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
                  : _buildProductList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddProductDialog(),
        child: const Icon(IconlyLight.plus),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
          const SizedBox(height: 16),
          Text('Failed to load products', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(errorMessage!, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _loadMyProducts, child: const Text('Try Again')),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(IconlyLight.bag, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text('No Products Yet', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text('Add your first product to start selling'),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: () => _showAddProductDialog(), child: const Text('Add Product')),
        ],
      ),
    );
  }

  Widget _buildProductList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: myProducts.length,
      itemBuilder: (context, index) => _buildProductCard(myProducts[index]),
    );
  }

  Widget _buildProductCard(Product product) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(8), child: productImage(product)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(product.name,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 6),
                      if (product.isOrganic)
                        const Icon(Icons.eco, color: Colors.green, size: 18),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(product.description, maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text('Rs. ${product.price.toStringAsFixed(0)}',
                          style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getStatusColor(product.status),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(product.status, style: const TextStyle(color: Colors.white, fontSize: 12)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('Stock: ${product.stock} • ${product.location}', style: const TextStyle(color: Colors.grey)),
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
                    _showDeleteDialog(product);
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'edit', child: ListTile(leading: Icon(IconlyLight.edit), title: Text('Edit'))),
                const PopupMenuItem(
                    value: 'delete',
                    child: ListTile(
                      leading: Icon(IconlyLight.delete, color: Colors.red),
                      title: Text('Delete', style: TextStyle(color: Colors.red)),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'AVAILABLE':
        return Colors.green;
      case 'OUT_OF_STOCK':
        return Colors.orange;
      case 'DISCONTINUED':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showAddProductDialog() {
    showDialog(context: context, builder: (context) => AddProductDialog(onSave: _addProduct));
  }

  void _showEditProductDialog(Product product) {
    showDialog(context: context, builder: (context) => AddProductDialog(product: product, onSave: _updateProduct));
  }

  void _showDeleteDialog(Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: Text('Are you sure you want to delete "${product.name}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _deleteProduct(product.id!);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

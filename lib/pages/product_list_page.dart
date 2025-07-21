// pages/product_list_page.dart
import 'package:flutter/material.dart';
import '../models/item.dart';
import '../services/product_service.dart';

class ProductListPage extends StatelessWidget {
  final String serviceName;

  const ProductListPage({super.key, required this.serviceName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(serviceName)),
      body: FutureBuilder<List<Item>>(
        future: ProductService.fetchProducts(category: serviceName.toLowerCase()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No products found"));
          }

          final items = snapshot.data!;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                title: Text(item.name),
                subtitle: Text(item.description),
                trailing: Text("Rs. ${item.price.toStringAsFixed(2)}"),
              );
            },
          );
        },
      ),
    );
  }
}

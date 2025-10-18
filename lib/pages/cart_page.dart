import 'package:govimansala/models/cart.dart';
import 'package:govimansala/models/item.dart';
import 'package:govimansala/services/cart_service.dart';
import 'package:govimansala/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:govimansala/services/order_service.dart';

class CartDisplayItem {
  final Item product;
  final int quantity;
  final int itemId;

  CartDisplayItem({
    required this.product,
    required this.quantity,
    required this.itemId,
  });
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartModel? cart;
  List<CartDisplayItem> displayItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCartAndProducts();
  }

  Future<void> _loadCartAndProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');
    if (userId == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      final fetchedCart = await CartService.getCartByUserId(userId);
      if (fetchedCart == null || fetchedCart.items.isEmpty) {
        setState(() {
          cart = fetchedCart;
          isLoading = false;
        });
        return;
      }

      List<CartDisplayItem> tempDisplayItems = [];

      for (var item in fetchedCart.items) {
        try {
          final product = await ProductService.fetchProductById(item.productId);
          if (product != null) {
            tempDisplayItems.add(CartDisplayItem(
              product: product,
              quantity: item.quantity,
              itemId: item.itemId,
            ));
          }
        } catch (e) {
          print('Failed to load product ${item.productId}: $e');
        }
      }

      setState(() {
        cart = fetchedCart;
        displayItems = tempDisplayItems;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading cart: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (cart == null || displayItems.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("Your cart is empty")),
      );
    }

    final totalItems =
        displayItems.fold<int>(0, (sum, item) => sum + item.quantity);
    final totalPrice = displayItems.fold<double>(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );

    return Scaffold(
      appBar: AppBar(title: const Text("My Cart")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ...displayItems.map((displayItem) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: const Icon(Icons.shopping_bag),
                  title: Text(displayItem.product.name),
                  subtitle: Text(displayItem.product.description),
                  trailing: Text(
                    "Rs. ${(displayItem.product.price * displayItem.quantity).toStringAsFixed(2)}\nQty: ${displayItem.quantity}",
                    textAlign: TextAlign.right,
                  ),
                ),
              );
            }).toList(),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total ($totalItems items)"),
                Text(
                  "Rs. ${totalPrice.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
               onPressed: () async {
  try {
    final responseOrderId = await OrderService.checkoutCart(cart!.cartId);
    if (responseOrderId != null) {
      Navigator.pushNamed(context, '/orderDetails', arguments: responseOrderId);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Checkout failed. Please try again.')),
      );
    }
  } catch (e) {
    print("Checkout error: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('An error occurred during checkout')),
    );
  }
},

                label: const Text("Proceed to Checkout"),
                icon: const Icon(IconlyBold.arrowRight),
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white, 
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:govimansala/models/cart_item.dart';

class CartModel {
  final int cartId;
  final int userId;
  final List<CartItemModel> items;

  CartModel({
    required this.cartId,
    required this.userId,
    required this.items,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      cartId: json['cartId'],
      userId: json['userId'],
      items: (json['items'] as List)
          .map((item) => CartItemModel.fromJson(item))
          .toList(),
    );
  }
}

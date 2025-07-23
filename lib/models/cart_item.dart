class CartItemModel {
  final int itemId;
  final int productId;
  final int quantity;

  CartItemModel({
    required this.itemId,
    required this.productId,
    required this.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      itemId: json['itemId'],
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }
}

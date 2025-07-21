class Item {
  final int  id;
  final String name;
  final String category;
  final double price;
  final int quantity;
  final String description;

  Item({
      required this.id,
      required this.name,
      required this.category,
      required this.price,
      required this.quantity,
      required this.description,
      });

   factory Item.fromJson(Map<String, dynamic> json) {
  return Item(
    id: json['productId'] ?? 0,
    name: json['productName'] ?? '',
    category: json['productCategory'] ?? '',
    price: (json['productPrice'] != null) ? json['productPrice'].toDouble() : 0.0,
    quantity: json['productQuantity'] ?? 0,
    description: json['productDescription'] ?? '',
  );
}  

}

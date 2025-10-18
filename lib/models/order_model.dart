class Order {
  final int orderId;
  final int userId;
  final double totalAmount;
  final DateTime createdAt;
  final List<OrderItem> items;
  final String? orderStatus;
  final String? paymentStatus;
  final String? deliveryStatus;
  final String? assignedDriver;

  Order({
    required this.orderId,
    required this.userId,
    required this.totalAmount,
    required this.createdAt,
    required this.items,
    this.orderStatus,
    this.paymentStatus,
    this.deliveryStatus,
    this.assignedDriver,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['orderId'],
      userId: json['userId'],
      totalAmount: json['totalAmount'],
      createdAt: DateTime.parse(json['createdAt']),
      items: (json['items'] as List<dynamic>)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      orderStatus: json['orderStatus'],
      paymentStatus: json['paymentStatus'],
      deliveryStatus: json['deliveryStatus'],
      assignedDriver: json['assignedDriver'],
    );
  }
}

class OrderItem {
  final int itemId;
  final int productId;
  final int quantity;
  final double unitPrice;
  final String orderStatus;

  OrderItem({
    required this.itemId,
    required this.productId,
    required this.quantity,
    required this.unitPrice,
    required this.orderStatus,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      itemId: json['itemId'],
      productId: json['productId'],
      quantity: json['quantity'],
      unitPrice: (json['unitPrice'] as num).toDouble(),
      orderStatus: json['orderStatus'],
    );
  }
}

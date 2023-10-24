class Order {
  int? id;
  String? shopName;
  String? ownerName;
  String? phoneNumber;
  String? brand;
  List<OrderItem> orderItems;

  Order({
    this.id,
    this.shopName,
    this.ownerName,
    this.phoneNumber,
    this.brand,
    this.orderItems = const [], // Provide an empty list as the default value
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shopName': shopName,
      'ownerName': ownerName,
      'phoneNumber': phoneNumber,
      'brand': brand,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      shopName: map['shopName'],
      ownerName: map['ownerName'],
      phoneNumber: map['phoneNumber'],
      brand: map['brand'],
    );
  }
}

class OrderItem {
  int? id;
  int? orderId;
  String? itemName;
  double? quantity;
  double? rate;
  double? amount;

  OrderItem({
    this.id,
    this.orderId,
    this.itemName,
    this.quantity,
    this.rate,
    this.amount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderId': orderId,
      'itemName': itemName,
      'quantity': quantity,
      'rate': rate,
      'amount': amount,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      id: map['id'],
      orderId: map['orderId'],
      itemName: map['itemName'],
      quantity: map['quantity'],
      rate: map['rate'],
      amount: map['amount'],
    );
  }
}

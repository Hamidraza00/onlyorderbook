import 'dart:async';

import 'OrderModel.dart';

class OrderRepository {
  // Simulated database or data storage.
  List<Order> _orders = [];

  // Add an order to the repository.
  Future<void> addOrder(Order order) async {
    _orders.add(order);
  }

  // Get a list of all orders from the repository.
  Future<List<Order>> getOrders() async {
    return _orders;
  }

  // Update an existing order in the repository.
  Future<void> updateOrder(Order updatedOrder) async {
    final index = _orders.indexWhere((order) =>
    order.shopName == updatedOrder.shopName);

    if (index != -1) {
      _orders[index] = updatedOrder;
    }
  }

  // Delete an order from the repository.
  Future<void> deleteOrder(int id) async {
    var _database;
    final db = await _database;
    await db.delete('orders', where: 'id = ?', whereArgs: [id]);
    await db.delete('orderItems', where: 'orderId = ?', whereArgs: [id]);
  }

}

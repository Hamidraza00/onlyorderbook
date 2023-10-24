

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

import 'OrderModel.dart';


class OrderDatabase {
  Database? _database;

  Future<void> initializeDatabase() async {
    final dbPath = await getDatabasesPath();
    final pathToDatabase = path.join(dbPath, 'orders.db');

    _database = await openDatabase(
      pathToDatabase,
      version: 1,
      onCreate: (db, version) {
        // Create your database tables here
        db.execute('''
          CREATE TABLE orders(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            shopName TEXT,
            ownerName TEXT,
            phoneNumber TEXT,
            brand TEXT
          )
        ''');
        db.execute('''
          CREATE TABLE orderItems(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            orderId INTEGER,
            itemName TEXT,
            quantity REAL,
            rate REAL,
            amount REAL
          )
        ''');
      },
    );
  }

  Future<void> insertOrder(Order order) async {
    await _database!.insert(
      'orders',
      order.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    for (OrderItem item in order.orderItems) {
      await _database!.insert(
        'orderItems',
        item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Order>> getOrders() async {
    final List<Map<String, dynamic>> orders = await _database!.query('orders');
    final List<Order> orderList = [];

    for (Map<String, dynamic> orderMap in orders) {
      final order = Order.fromMap(orderMap);
      final List<Map<String, dynamic>> items = await _database!.query(
        'orderItems',
        where: 'orderId = ?',
        whereArgs: [order.id],
      );

      order.orderItems = items.map((itemMap) => OrderItem.fromMap(itemMap)).toList();
      orderList.add(order);
    }

    return orderList;
  }
}

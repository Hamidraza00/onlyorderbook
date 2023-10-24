// main.dart
import 'package:flutter/material.dart';
import 'OrderBookingPage.dart';
import 'OrderListPage.dart';
import 'OrderModel.dart';
//import 'order.dart';  // Import the order-related classes

List<Order> orders = [];

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => OrderBookingPage(),
      '/orderList': (context) => OrderListPage(),
    },
  ));
}

// ... Rest of your Flutter code

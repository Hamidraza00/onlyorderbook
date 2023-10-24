import 'package:flutter/material.dart';
import 'OrderListItems.dart';
import 'OrderModel.dart';
import 'main.dart'; // Import your list of orders

class OrderListPage extends StatefulWidget {
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order List'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return OrderListItem(order: order);
        },
      ),


    );
  }
}

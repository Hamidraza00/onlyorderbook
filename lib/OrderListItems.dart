import 'package:flutter/material.dart';

import 'OrderModel.dart';

class OrderListItem extends StatelessWidget {
  final Order order;

  OrderListItem({required this.order});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Shop Name: ${order.shopName}'),
      subtitle: Text('Owner Name: ${order.ownerName}'),
      onTap: () {
        // Navigate to the order details page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailsPage(order: order),
          ),
        );
      },
    );
  }
}
class OrderDetailsPage extends StatelessWidget {
  final Order order;

  OrderDetailsPage({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Shop Name: ${order.shopName}'),
            Text('Owner Name: ${order.ownerName}'),
            Text('Phone Number: ${order.phoneNumber}'),
            Text('Brand: ${order.brand}'),
            SizedBox(height: 16),
            Text('Order Items:'),
            ListView.builder(
              shrinkWrap: true,
              itemCount: order.orderItems.length,
              itemBuilder: (context, index) {
                final item = order.orderItems[index];
                return ListTile(
                  title: Text('Item Name: ${item.itemName}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Quantity: ${item.quantity}'),
                      Text('Rate: ${item.rate}'),
                      Text('Amount: ${item.amount}'),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

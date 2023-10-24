import 'package:flutter/material.dart';
import 'package:onlyorderbook/OrderDatabase.dart';
//import 'OrderConfirmationPage.dart';
import 'OrderListPage.dart';
import 'OrderModel.dart';
import 'main.dart';


class OrderBookingPage extends StatefulWidget {
  OrderBookingPage();

  @override
  _OrderBookingPageState createState() => _OrderBookingPageState();
}

class _OrderBookingPageState extends State<OrderBookingPage> {
  final OrderDatabase _orderDatabase = OrderDatabase();
  TextEditingController _textField1Controller = TextEditingController();
  TextEditingController _textField2Controller = TextEditingController();
  TextEditingController _textField3Controller = TextEditingController();
  TextEditingController _textField4Controller = TextEditingController();

  String? selectedDropdownValue1;
  String? selectedDropdownValue2;
  String? selectedDropdownValue3;
  String? selectedDropdownValue4;

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }
  void _initializeDatabase() async {
    await _orderDatabase.initializeDatabase();
  }

  TextEditingController _rate1Controller = TextEditingController();
  TextEditingController _qty1Controller = TextEditingController();
  TextEditingController _amount1Controller = TextEditingController();
  TextEditingController _rate2Controller = TextEditingController();
  TextEditingController _qty2Controller = TextEditingController();
  TextEditingController _amount2Controller = TextEditingController();
  TextEditingController _rate3Controller = TextEditingController();
  TextEditingController _qty3Controller = TextEditingController();
  TextEditingController _amount3Controller = TextEditingController();
  TextEditingController _rate4Controller = TextEditingController();
  TextEditingController _qty4Controller = TextEditingController();
  TextEditingController _amount4Controller = TextEditingController();

  void updateAmount(
      TextEditingController qtyController,
      TextEditingController rateController,
      TextEditingController amountController,
      ) {
    final qty = double.tryParse(qtyController.text) ?? 0;
    final rate = double.tryParse(rateController.text) ?? 0;
    final amount = qty * rate;
    amountController.text = amount.toStringAsFixed(2);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Booking'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       Text(
            //         'DATE',
            //         style: TextStyle(fontSize: 16, color: Colors.black),
            //       ),
            //       SizedBox(width: 10),
            //       Container(
            //         width: 150,
            //         child: TextFormField(
            //           decoration: InputDecoration(
            //             labelText: 'Field 1',
            //             border: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(5.0),
            //             ),
            //           ),
            //           textAlign: TextAlign.right,
            //           validator: (value) {
            //             if (value!.isEmpty) {
            //               return 'Please enter some text';
            //             }
            //             return null;
            //           },
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            SizedBox(height: 20),
            buildTextFormField('Shop Name', 'Field 1', _textField1Controller),
            SizedBox(height: 20),
            buildTextFormField('Owner Name', 'Field 2', _textField2Controller),
            SizedBox(height: 20),
            buildTextFormField('Phone#', 'Field 3', _textField3Controller),
            SizedBox(height: 20),
            buildTextFormField('Brand', 'Field 4', _textField4Controller),
            SizedBox(height: 20),

            // First row
            buildItemRow(1, _rate1Controller, _qty1Controller, _amount1Controller),

            // Second row
            buildItemRow(2, _rate2Controller, _qty2Controller, _amount2Controller),

            // Third row
            buildItemRow(3, _rate3Controller, _qty3Controller, _amount3Controller),

            // Fourth row
            buildItemRow(4, _rate4Controller, _qty4Controller, _amount4Controller),

            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () async {
                    // Create an Order object with the entered data
                    Order order = Order(
                      shopName: _textField1Controller.text,
                      ownerName: _textField2Controller.text,
                      phoneNumber: _textField3Controller.text,
                      brand: _textField4Controller.text,
                      orderItems: [
                        OrderItem(
                          itemName: selectedDropdownValue1 ?? "",
                          quantity: double.tryParse(_qty1Controller.text) ?? 0,
                          rate: double.tryParse(_rate1Controller.text) ?? 0,
                          amount: double.tryParse(_amount1Controller.text) ?? 0,
                        ),
                        // Repeat this for other order items
                      ],
                    );

                    // Add the order to your database
                    orders.add(order);
                    await _orderDatabase.insertOrder(order);

                    // Clear the form
                    _textField1Controller.clear();
                    _textField2Controller.clear();
                    _textField3Controller.clear();
                    _textField4Controller.clear();
                    _qty1Controller.clear();
                    _rate1Controller.clear();
                    _amount1Controller.clear();
                    // Clear other fields as well

                   Navigator.push(context, MaterialPageRoute(builder: (context) => OrderListPage()));
                         },


                child: Text('Confirm'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextFormField(
      String labelText,
      String hintText,
      TextEditingController controller,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildItemRow(
      int rowNumber,
      TextEditingController rateController,
      TextEditingController qtyController,
      TextEditingController amountController,
      ) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Item $rowNumber',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: rowNumber == 1
                      ? selectedDropdownValue1
                      : rowNumber == 2
                      ? selectedDropdownValue2
                      : rowNumber == 3
                      ? selectedDropdownValue3
                      : selectedDropdownValue4,
                  onChanged: (String? newValue) {
                    setState(() {
                      if (rowNumber == 1) {
                        selectedDropdownValue1 = newValue;
                      } else if (rowNumber == 2) {
                        selectedDropdownValue2 = newValue;
                      } else if (rowNumber == 3) {
                        selectedDropdownValue3 = newValue;
                      } else {
                        selectedDropdownValue4 = newValue;
                      }
                    });
                  },
                  items: ['Option 1', 'Option 2', 'Option 3', 'Option 4']
                      .map<DropdownMenuItem<String>>(
                        (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Qty',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              SizedBox(height: 10),
              TextFormField(
                onChanged: (value) {
                  updateAmount(qtyController, rateController, amountController);
                },
                controller: qtyController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rate',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              SizedBox(height: 10),
              TextFormField(
                onChanged: (value) {
                  updateAmount(qtyController, rateController, amountController);
                },
                controller: rateController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Amount',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: amountController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


import 'package:get/get.dart';
import 'package:onlyorderbook/OrderModel.dart';

import 'OrderRepository.dart';

//import '../Repositories/OrderRepository.dart';

class OrderViewModel extends GetxController{

  var allOrder = <Order>[].obs;
  OrderRepository orderRepository = OrderRepository();



  @override
  void onInit() {
    super.onInit();
    fetchAllShop();
  }

  fetchAllShop() async {
    var order = await orderRepository.getOrders();
    allOrder.value= order;

  }

  addOrder(Order order){
    orderRepository.addOrder(order);
    fetchAllShop();
    //var dummy=fetchAllShop();
    // print (dummy);

  }

  updateOrder(Order order){
    orderRepository.updateOrder(order);
    // fetchAllShop();

  }

  deleteOrder(int id){
    orderRepository.deleteOrder(id);
    fetchAllShop();

  }
}







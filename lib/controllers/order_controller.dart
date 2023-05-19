import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multi_languges/controllers/auth/auth_controller.dart';
import 'package:multi_languges/controllers/cart_controller.dart';
import 'package:multi_languges/controllers/restaurant_controller.dart';
import 'package:multi_languges/models/menu_item.dart';
import 'package:multi_languges/models/status.dart';
import 'package:multi_languges/repositories/order_repository.dart';

import '../models/order.dart';

class OrderController extends GetxController {
  final OrderRepository orderRepository = OrderRepository();
  final RxList<Order> _orders = <Order>[].obs;

  List<Order> get orders => _orders;

  var isLoading = false.obs;
  var isExpanded = false.obs;

  final cartController = Get.find<CartController>();
  final restaurantsController = Get.put(RestaurantController());

  @override
  void onInit() {
    super.onInit();
    cartController.getCart();
    fetchOrders();
  }

  @override
  void onReady() {
    super.onReady();
    cartController.getCart();
    fetchOrders();
  }

  Future<void> addOrder(
      Map<String, Map<MenuItem, int>> itemQunatity,
      Map<String, double> itemSubtotal,
      String paymentMathode,
      String address) async {
    // debugPrint('quantity : ${itemQunatity}');
    try {
      isLoading.value = true;

      List<Order> orders = [];
      for (var e in itemQunatity.entries) {
        double deliveryFees = restaurantsController.restaurants
            .firstWhere((element) => element.id == e.key)
            .deliveryFee;
        // print('test ${e.value}');
        orders.add(
          Order(
            consumerId: AuthController.instance.auth.currentUser!.uid,
            restaurantId: e.key,
            paymentMathode: paymentMathode,
            address: address,
            menuItems: e.value,
            total: (itemSubtotal[e.key] as double) + deliveryFees,
            status: Status.pending,
            addedAt: DateTime.now().toString(),
          ),
        );
      }
      for (var order in orders) {
        await orderRepository.addOrder(order.toMap());
      }
      isLoading.value = false;
      showSnackBar('Success', 'Your order has been placed successfully.',
          Colors.green.shade400);
    } catch (error) {
      isLoading.value = false;
      showSnackBar('Error', 'An error occurred, please try again later.',
          Colors.red.shade400);

      rethrow;
    }
  }

  Future<void> fetchOrders() async {
    final snapshot = await orderRepository.getOrders();
    _orders.value = snapshot.docs.map((doc) {
      return Order.fromFirestore(doc);
    }).toList();
  }

  Future<void> cancelOrder(String id) async {
    try {
      await orderRepository.cancelOrder(id);
      fetchOrders();
      isLoading.value = false;
      showSnackBar('Success', 'Your order has been cancelled successfully.',
          Colors.green.shade400);
    } catch (error) {
      isLoading.value = false;

      showSnackBar('Error', 'An error occurred, please try again later.',
          Colors.red.shade400);
    }
  }

  void showSnackBar(String titleText, String messageText, Color color) {
    Get.snackbar(titleText, messageText,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: color,
        colorText: Colors.white,
        duration: const Duration(milliseconds: 2000));
  }
}

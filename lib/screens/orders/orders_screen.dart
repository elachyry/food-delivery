import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_languges/controllers/order_controller.dart';
import 'package:multi_languges/controllers/restaurant_controller.dart';
import 'package:multi_languges/models/status.dart';

import '../../widgets/order/order_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrderController());
    final restaurantController = Get.put(RestaurantController());

    final appBar = AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: CircleAvatar(
          radius: 22,
          backgroundColor: Colors.white60,
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
              size: 25,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
      ),
      centerTitle: true,
      title: Text(
        'Orders',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
    final orders = orderController.orders;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              appBar.preferredSize.height,
          color: Colors.white,
          child: Obx(() {
            if (orderController.orders.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: orderController.orders.length,
              itemBuilder: (context, index) {
                final String status = getStatusValue(orders[index].status);
                final Color color;

                switch (status) {
                  case 'Pending':
                    color = Colors.blue.shade400;
                    break;
                  case 'Accepted':
                    color = Colors.green.shade400;
                    break;
                  case 'Cancelled':
                    color = Colors.orange.shade400;
                    break;
                  case 'Delivered':
                    color = Colors.indigo.shade400;
                    break;
                  case 'Denied':
                    color = Colors.red.shade400;
                    break;
                  default:
                    color = Colors.blue.shade400;
                    break;
                }
                return OrderItem(
                  restaurantController: restaurantController,
                  orders: orders,
                  color: color,
                  status: status,
                  orderController: orderController,
                  index: index,
                );
              },
            );
          }),
        ),
      ),
    );
  }
}

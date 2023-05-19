import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_languges/controllers/order_controller.dart';
import 'package:multi_languges/controllers/restaurant_controller.dart';
import 'package:multi_languges/models/status.dart';
import 'package:multi_languges/widgets/order/cancel_order_confirmation_dialog.dart';
import 'package:multi_languges/widgets/order/order_item.dart';

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
          child: Obx(
            () => ListView.builder(
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
                    color = Colors.grey.shade400;
                    break;
                  case 'Denied':
                    color = Colors.red.shade400;
                    break;
                  default:
                    color = Colors.blue.shade400;
                    break;
                }
                return Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  restaurantController.restaurants
                                      .firstWhere((element) =>
                                          element.id ==
                                          orders[index].restaurantId)
                                      .logoUrl,
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                restaurantController.restaurants
                                    .firstWhere((element) =>
                                        element.id ==
                                        orders[index].restaurantId)
                                    .name,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontSize: 25),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: color,
                                ),
                                child: Text(
                                  status,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          fontSize: 15, color: Colors.white),
                                ),
                              ),
                              if (status == 'Pending')
                                Container(
                                  margin: const EdgeInsets.all(3),
                                  child: GestureDetector(
                                    onTap: () async {
                                      final bool shoudCancel =
                                          await CancelOrderConfirmationDialog
                                              .show(context) as bool;
                                      if (shoudCancel) {
                                        showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) => Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ));
                                        await orderController
                                            .cancelOrder(orders[index].id);
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    child: const Icon(
                                      Icons.cancel,
                                      color: Colors.red,
                                    ),
                                  ),
                                )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Order id: ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            fontSize: 15,
                                            color: Colors.grey.shade400),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    orders[index].id,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            fontSize: 15,
                                            color: Colors.grey.shade400),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Order Date: ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            fontSize: 15,
                                            color: Colors.grey.shade400),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    orders[index].addedAt,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            fontSize: 15,
                                            color: Colors.grey.shade400),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Obx(
                            () => IconButton(
                              onPressed: () {
                                orderController.isExpanded.value =
                                    !orderController.isExpanded.value;
                              },
                              icon: Icon(
                                orderController.isExpanded.value
                                    ? Icons.arrow_drop_up_rounded
                                    : Icons.arrow_drop_down_rounded,
                                size: 45,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                          )
                        ],
                      ),
                      Obx(
                        () => !orderController.isExpanded.value
                            ? Container()
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount: orders[index].menuItems.keys.length,
                                itemBuilder: (context, index2) {
                                  return OrderItem(
                                    menuItem: orders[index]
                                        .menuItems
                                        .keys
                                        .elementAt(index2),
                                    quantity: orders[index]
                                        .menuItems
                                        .values
                                        .elementAt(index2),
                                  );
                                }),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => !orderController.isExpanded.value
                            ? Container()
                            : Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                margin: const EdgeInsets.only(bottom: 5),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Payment Method',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(fontSize: 15),
                                        ),
                                        Text(
                                          orders[index].paymentMathode,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Address',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(fontSize: 15),
                                        ),
                                        Text(
                                          orders[index].address,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(fontSize: 15),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              orders[index]
                                                  .total
                                                  .toStringAsFixed(2),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                            ),
                                            Text(
                                              'Dh',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10,
                                                    color: Theme.of(context)
                                                        .primaryColorDark,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

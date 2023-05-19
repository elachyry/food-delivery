import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:multi_languges/controllers/dashboard_controller.dart';
import 'package:multi_languges/models/menu_item.dart';
import 'package:multi_languges/models/restaurant.dart';
import 'package:multi_languges/utils/constants/image_constants.dart';

import '../../blocs/cart/cart_bloc.dart';
import '../../widgets/cart/cart_bottom_nav_bar.dart';
import '../../widgets/cart/cart_item.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  final contoller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    double total = 0;

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
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Obx(
            () => IconButton(
                onPressed: contoller.isCartEmpty.value
                    ? null
                    : () {
                        contoller.isEdit.value = !contoller.isEdit.value;
                      },
                icon: const Icon(
                  Bootstrap.pencil,
                  color: Colors.black,
                )),
          ),
        )
      ],
      centerTitle: true,
      title: Text(
        'Cart',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is CartLoaded) {
          total = state.cart.grandTotal(state.cart.menuItems);
          if (state.cart.menuItems.isEmpty) {
            contoller.isCartEmpty.value = true;
          } else {
            contoller.isCartEmpty.value = false;
          }
          return state.cart.menuItems.isEmpty
              ? Scaffold(
                  appBar: appBar,
                  body: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.9,
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImageConstants.emptyCart,
                          width: 120,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Nothing to show!',
                          textAlign: TextAlign.left,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                        ),
                      ],
                    ),
                  ),
                )
              : Scaffold(
                  appBar: appBar,
                  backgroundColor: Colors.grey.shade200,
                  bottomNavigationBar: CartBottomNavBar(total: total),
                  body: SizedBox(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.698,
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: state.cart
                                    .itemQuantity(state.cart.menuItems)
                                    .keys
                                    .length,
                                itemBuilder: (context, index) {
                                  final int restaurantId = state.cart
                                      .itemQuantity(state.cart.menuItems)
                                      .keys
                                      .elementAt(index);

                                  final items = state.cart.itemQuantity(
                                      state.cart.menuItems)[restaurantId];

                                  double deliveryFees = Restaurant.restaurants
                                      .firstWhere((element) =>
                                          element.id == restaurantId)
                                      .deliveryFee;
                                  double subtotal = state.cart.subtotal(
                                          state.cart.menuItems)[restaurantId]
                                      as double;

                                  if (subtotal == 0) {
                                    deliveryFees = 0;
                                  }
                                  double restaurantTotal =
                                      deliveryFees + subtotal;
                                  // total += restaurantTotal;

                                  return Container(
                                    key: ValueKey(restaurantId),
                                    padding: const EdgeInsets.all(5),
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: Image.network(
                                                Restaurant.restaurants
                                                    .firstWhere((element) =>
                                                        element.id ==
                                                        restaurantId)
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
                                              Restaurant.restaurants
                                                  .firstWhere((element) =>
                                                      element.id ==
                                                      restaurantId)
                                                  .name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(fontSize: 25),
                                            ),
                                          ],
                                        ),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const ClampingScrollPhysics(),
                                            itemCount: items!.keys.length,
                                            itemBuilder: (context, index) {
                                              String elements = '';

                                              MenuItem item =
                                                  items.keys.elementAt(index);

                                              int size = item.elements.length;

                                              int i = 0;
                                              for (var e in item.elements) {
                                                if (i == size - 1) {
                                                  elements +=
                                                      '${e['quantity']}x${e['name']}';
                                                } else {
                                                  elements +=
                                                      '${e['quantity']}x${e['name']}, ';
                                                }
                                                i++;
                                              }

                                              return CartItem(
                                                key: ValueKey(item.id),
                                                menuItem: item,
                                                elements: elements,
                                                state: state,
                                                index: index,
                                                restauratId: restaurantId,
                                              );
                                            }),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          margin:
                                              const EdgeInsets.only(bottom: 5),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Subtotal',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium!
                                                        .copyWith(fontSize: 15),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        subtotal
                                                            .toStringAsFixed(2),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium!
                                                            .copyWith(
                                                              fontSize: 15,
                                                            ),
                                                      ),
                                                      Text(
                                                        'Dh',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium!
                                                            .copyWith(
                                                              fontSize: 10,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const Divider(),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Delivery Fees',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium!
                                                        .copyWith(fontSize: 15),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        deliveryFees
                                                            .toStringAsFixed(2),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium!
                                                            .copyWith(
                                                              fontSize: 15,
                                                            ),
                                                      ),
                                                      Text(
                                                        'Dh',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium!
                                                            .copyWith(
                                                              fontSize: 10,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const Divider(),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
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
                                                        restaurantTotal
                                                            .toStringAsFixed(2),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium!
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                            ),
                                                      ),
                                                      Text(
                                                        'Dh',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium!
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 10,
                                                              color: Theme.of(
                                                                      context)
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
                                      ],
                                    ),
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
                  ),
                );
        } else {
          return Center(
            child: Text('an_error_occurred_please_try_again_later'.tr),
          );
        }
      },
    );
  }
}

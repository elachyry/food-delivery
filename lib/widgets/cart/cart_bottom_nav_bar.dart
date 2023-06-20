import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:food_delivery_express/screens/checkout/checkout_screen.dart';

import '../../blocs/cart/cart_bloc.dart';
import '../../controllers/auth/user_controller.dart';
import '../../models/menu_item.dart';
import 'add_coupon_bottom_nav_bar.dart';

class CartBottomNavBar extends StatelessWidget {
  final double total;
  final Map<String, Map<MenuItem, int>> itemQuantity;
  final Map<String, double> itemSubtotal;
  CartBottomNavBar({
    super.key,
    required this.total,
    required this.itemQuantity,
    required this.itemSubtotal,
  });
  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.19,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is CartLoaded) {
            return BottomAppBar(
              color: Colors.transparent,
              elevation: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  state.cart.coupon != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'coupon'.tr,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Row(
                              children: [
                                Text(
                                  '-${state.cart.coupon!.discount.toStringAsFixed(0)}Dh',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Bootstrap.x,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    context
                                        .read<CartBloc>()
                                        .add(const RemoveCoupon());
                                    Get.snackbar(
                                      'succes'.tr,
                                      'the_coupon_deleted_successfully'.tr,
                                      snackPosition: SnackPosition.TOP,
                                      backgroundColor: Colors.green.shade500,
                                      colorText: Colors.white,
                                      duration:
                                          const Duration(milliseconds: 1500),
                                    );
                                  },
                                )
                              ],
                            ),
                          ],
                        )
                      : TextButton(
                          onPressed:
                              state.cart.grandTotal(state.cart.menuItems) == 0
                                  ? null
                                  : () {
                                      showModalBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (context) =>
                                            const AddCouponBottomNavBar(),
                                      );
                                    },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(10.0),
                          ),
                          child: Text(
                            'do_you_have_a_oupon'.tr,
                          ),
                        ),
                  const Divider(),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'total'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 18),
                          ),
                          Row(
                            children: [
                              Text(
                                total.toStringAsFixed(2),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Theme.of(context).primaryColor,
                                    ),
                              ),
                              Text(
                                'Dh',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          onPressed:
                              state.cart.grandTotal(state.cart.menuItems) == 0
                                  ? null
                                  : () {
                                      userController.getUserData();
                                      final val = total;
                                      Get.to(() => CheckoutScreen(
                                            total: val,
                                            itemQuantity: itemQuantity,
                                            itemSubtotal: itemSubtotal,
                                          ));
                                    },
                          child: Text(
                            'continue'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text('an_error_occurred_please_try_again_later'.tr),
            );
          }
        },
      ),
    );
  }
}

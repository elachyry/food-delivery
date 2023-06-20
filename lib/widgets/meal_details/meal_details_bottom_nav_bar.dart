import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:badges/badges.dart' as badges;
import 'package:food_delivery_express/utils/app_routes.dart';

import '../../models/menu_item.dart';
import '../../controllers/dashboard_controller.dart';
import '../../models/restaurant.dart';
import '../../blocs/cart/cart_bloc.dart';

class MealDetailsBottomNavBar extends StatelessWidget {
  MealDetailsBottomNavBar({
    super.key,
    required this.restaurant,
    required this.menuItem,
  });

  final Restaurant? restaurant;
  final MenuItem? menuItem;
  final controller = Get.put(DashboardController());

  void showSnackBar(String titleText, String messageText, Color color) {
    Get.snackbar(titleText, messageText,
        snackPosition: SnackPosition.TOP,
        backgroundColor: color,
        colorText: Colors.white,
        duration: const Duration(milliseconds: 1200));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.14,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            blurRadius: 5,
            spreadRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: BottomAppBar(
        color: Colors.transparent,
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CartLoaded) {
              int itemCount = 0;
              if (state.cart
                      .itemQuantity(state.cart.menuItems)[restaurant!.id] !=
                  null) {
                state.cart
                    .itemQuantity(state.cart.menuItems)[restaurant!.id]!
                    .entries
                    .forEach((element) {
                  itemCount += element.value;
                });
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.cartScreenRoute);
                        },
                        child: badges.Badge(
                          position:
                              badges.BadgePosition.topEnd(top: 0, end: -5),
                          badgeContent: Text(
                            '$itemCount',
                          ),
                          child: const Icon(
                            Bootstrap.basket,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Delivery_order'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              restaurant!.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: Colors.grey,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        for (int i = 0; i < controller.mealQty.value; i++) {
                          context.read<CartBloc>().add(
                                AddItem(menuItem: menuItem as MenuItem),
                              );
                          showSnackBar(
                              'succes'.tr,
                              'the_item_added_to_cart_successfully'.tr,
                              Colors.green.shade500);
                          controller.mealQty.value = 1;
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).primaryColorDark,
                          ),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          )),
                      child: FittedBox(
                        child: Text(
                          'add_to_cart'.tr,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text('an_error_occurred_please_try_again_later'.tr),
              );
            }
          },
        ),
      ),
    );
  }
}

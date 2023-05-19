import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:multi_languges/controllers/dashboard_controller.dart';

import '../../blocs/cart/cart_bloc.dart';
import '../../models/menu_item.dart';

class CartItem extends StatelessWidget {
  final CartLoaded state;
  final int restauratId;
  final int index;
  final MenuItem menuItem;
  const CartItem({
    super.key,
    required this.elements,
    required this.state,
    required this.restauratId,
    required this.index,
    required this.menuItem,
  });

  final String elements;
  void showSnackBar(String titleText, String messageText, Color color) {
    Get.snackbar(titleText, messageText,
        snackPosition: SnackPosition.TOP,
        backgroundColor: color,
        colorText: Colors.white,
        duration: const Duration(milliseconds: 1200));
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 3,
      ),
      child: Dismissible(
        key: ValueKey(menuItem.id),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) {
          return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Are you sure?'),
              content: const Text('Do you want to remove this item?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                  child: const Text('Yes'),
                ),
              ],
            ),
          );
        },
        background: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.red,
          ),
          padding: const EdgeInsets.only(
            right: 25,
          ),
          margin: const EdgeInsets.all(5),
          alignment: Alignment.centerRight,
          child: const Icon(
            Bootstrap.trash,
            color: Colors.white,
            size: 35,
          ),
        ),
        onDismissed: (direction) {
          context.read<CartBloc>().add(
                RemoveItemTotal(
                    menuItem: state.cart
                        .itemQuantity(state.cart.menuItems)[restauratId]!
                        .keys
                        .elementAt(index)),
              );
          showSnackBar('succes'.tr, 'The item removed from cart successfully.',
              Colors.green.shade500);
        },
        child: Obx(
          () => Card(
            key: ValueKey(menuItem.id),
            elevation: 1,
            child: Container(
              padding: const EdgeInsets.only(top: 15, bottom: 15, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (controller.isEdit.value)
                    Checkbox(
                      value: state.cart.checkStates[menuItem.id],
                      onChanged: (value) {
                        context.read<CartBloc>().add(
                              SelectToggle(
                                  menuItem: menuItem, value: value as bool),
                            );
                      },
                    ),
                  if (!controller.isEdit.value)
                    const SizedBox(
                      width: 5,
                    ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: 90,
                      height: 90,
                      child: Image.network(
                        menuItem.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 90,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          menuItem.name,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          child: Text(
                            elements,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.grey, fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              menuItem.price.toStringAsFixed(2),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Theme.of(context).primaryColorDark,
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
                  ),
                  BlocBuilder<CartBloc, CartState>(
                    builder: (context, state2) {
                      return SizedBox(
                        height: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                context.read<CartBloc>().add(
                                      AddItem(
                                          menuItem: state.cart
                                              .itemQuantity(state
                                                  .cart.menuItems)[restauratId]!
                                              .keys
                                              .elementAt(index)),
                                    );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  color: Theme.of(context).primaryColorDark,
                                  child: const Icon(
                                    Bootstrap.plus,
                                    size: 28,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              // height: 25,
                              // width: 20,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.05)),
                              child: Text(
                                '${(state.cart.itemQuantity(state.cart.menuItems)[restauratId]!.entries.elementAt(index)).value}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                context.read<CartBloc>().add(
                                      RemoveItem(
                                          menuItem: state.cart
                                              .itemQuantity(state
                                                  .cart.menuItems)[restauratId]!
                                              .keys
                                              .elementAt(index)),
                                    );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  color: Colors.grey.shade200,
                                  child: const Icon(
                                    Bootstrap.dash,
                                    size: 28,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

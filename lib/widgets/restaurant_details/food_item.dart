import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:multi_languges/models/menu_item.dart';
import 'package:multi_languges/utils/constants/image_constants.dart';

import '../../blocs/cart/cart_bloc.dart';
import '../../controllers/cart_controller.dart';

class FoodItem extends StatelessWidget {
  final MenuItem menuItem;
  FoodItem({
    super.key,
    required this.menuItem,
  });
  void showSnackBar(String titleText, String messageText, Color color) {
    Get.snackbar(titleText, messageText,
        snackPosition: SnackPosition.TOP,
        backgroundColor: color,
        colorText: Colors.white,
        duration: const Duration(milliseconds: 1500));
  }

  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            width: 110,
            height: 110,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: FadeInImage(
                  imageErrorBuilder: (context, error, stackTrace) =>
                      Image.asset(ImageConstants.menuItemPlaceholder),
                  placeholder:
                      const AssetImage(ImageConstants.menuItemPlaceholder),
                  image: NetworkImage(
                    menuItem.imageUrl,
                  ),
                  fit: BoxFit.cover,
                )),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          menuItem.name,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Theme.of(context).primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: BlocBuilder<CartBloc, CartState>(
                          builder: (context, state) {
                            return InkWell(
                              onTap: () {
                                context
                                    .read<CartBloc>()
                                    .add(AddItem(menuItem: menuItem));
                                // cartController.addToCart(menuItem);
                                showSnackBar(
                                    'succes'.tr,
                                    'The item added to cart successfully.',
                                    Colors.green.shade500);
                              },
                              child: const Icon(
                                Icons.add,
                                size: 25,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: Text(
                      menuItem.description,
                      overflow: TextOverflow.clip,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${menuItem.price}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            'Dh',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 10),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

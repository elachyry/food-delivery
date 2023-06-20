import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_delivery_express/utils/constants/image_constants.dart';

import '../../models/menu_item.dart';

class OrderMenuItem extends StatelessWidget {
  final MenuItem menuItem;
  final int quantity;
  const OrderMenuItem({
    super.key,
    required this.menuItem,
    required this.quantity,
  });

  void showSnackBar(String titleText, String messageText, Color color) {
    Get.snackbar(titleText, messageText,
        snackPosition: SnackPosition.TOP,
        backgroundColor: color,
        colorText: Colors.white,
        duration: const Duration(milliseconds: 1200));
  }

  @override
  Widget build(BuildContext context) {
    String elements = '';

    int size = menuItem.elements.length;

    int i = 0;
    menuItem.elements.forEach((key, value) {
      if (i == size - 1) {
        elements += '$key x $value';
      } else {
        elements += '$key x $value, ';
      }
      i++;
    });
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 3,
      ),
      child: Card(
        key: ValueKey(menuItem.id),
        elevation: 1,
        child: Container(
          padding: const EdgeInsets.only(top: 15, bottom: 15, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 5,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                    width: 90,
                    height: 90,
                    child: FadeInImage(
                      image: NetworkImage(
                        menuItem.imageUrl,
                      ),
                      placeholder:
                          const AssetImage(ImageConstants.menuItemPlaceholder),
                      imageErrorBuilder: (context, error, stackTrace) =>
                          Image.asset(ImageConstants.menuItemPlaceholder),
                      fit: BoxFit.cover,
                    )),
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
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
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
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                        ),
                        Text(
                          'Dh',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
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
              Container(
                // height: 25,
                // width: 20,
                alignment: Alignment.center,
                child: Text(
                  'x $quantity',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

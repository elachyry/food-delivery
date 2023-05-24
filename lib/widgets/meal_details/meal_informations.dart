import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:multi_languges/controllers/dashboard_controller.dart';

import '../../controllers/ingredient_controller.dart';
import '../../controllers/menu_items_controller.dart';
import '../../controllers/rating_controller.dart';
import '../../models/menu_item.dart';
import '../../models/rating.dart';

class Mealinformations extends StatelessWidget {
  Mealinformations({
    super.key,
    required this.menuItem,
  });

  final menuItemsController = Get.put(MenuItemsController());
  final ratingController = Get.put(RatingController());
  final ingrediantController = Get.put(IngredientController());

  final MenuItem? menuItem;
  final controller = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    String elements = '';

    int size = menuItem!.elements.length;

    int i = 0;
    menuItem!.elements.forEach((key, value) {
      if (i == size - 1) {
        elements += '$key x $value';
      } else {
        elements += '$key x $value, ';
      }
      i++;
    });

    var rating = 0.0;
    ratingController.fetchRatings();
    List<Rating> ratings = [];

    if (ratingController.ratings.isNotEmpty) {
      for (var element in ratingController.ratings) {
        if (element.menuItemId == menuItem!.id) {
          ratings.add(element);
          rating += element.rate;
        }
      }
    }

    rating = rating / ratings.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: Text(
                  menuItem!.name,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FittedBox(
                child: Text(
                  elements,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 15, color: Colors.grey),
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        rating.isNaN || ratings.isEmpty
                            ? 'No ratings'
                            : '$rating (${ratings.length})',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            if (controller.mealQty.value == 1) {
                              return;
                            }
                            controller.mealQty.value -= 1;
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              color: Colors.grey.shade300,
                              child: const Icon(
                                Bootstrap.dash,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                        Obx(
                          () => Container(
                            // height: 25,
                            // width: 20,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.05)),
                            child: Text(
                              controller.mealQty.value.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.mealQty.value += 1;
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
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 18,
        ),
        Text(
          '${menuItem!.description} ',
          overflow: TextOverflow.clip,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.black54,
              ),
        ),
        const SizedBox(
          height: 50,
        ),
        FittedBox(
          child: Text(
            'Ingredients',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
            softWrap: true,
            overflow: TextOverflow.fade,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: double.infinity,
          height: 100,
          child: Obx(() {
            if (ingrediantController.ingrediants.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    width: 80,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.network(
                          ingrediantController.ingrediants
                              .firstWhere((element) =>
                                  menuItem!.ingredientsId[index] ==
                                  element.name)
                              .imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        Text(
                          ingrediantController.ingrediants
                              .firstWhere((element) =>
                                  menuItem!.ingredientsId[index] ==
                                  element.name)
                              .name,
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                      width: 10,
                    ),
                itemCount: menuItem!.ingredientsId.length);
          }),
        )
      ],
    );
  }
}

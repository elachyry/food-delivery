import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_languges/controllers/menu_items_controller.dart';
import 'package:multi_languges/models/restaurant.dart';
import 'package:multi_languges/screens/meal_details/meal_details_screen.dart';
import 'package:multi_languges/widgets/restaurant_details/food_item.dart';

import '../../controllers/category_controller.dart';

class FoodListView extends StatelessWidget {
  final int selectedIndex;
  final Function callBack;
  final PageController pageController;
  final Restaurant? restaurant;
  FoodListView({
    super.key,
    required this.selectedIndex,
    required this.callBack,
    required this.pageController,
    required this.restaurant,
  });
  final menuItemController = Get.put(MenuItemsController());
  final categoryController = Get.put(CategoryController());
  @override
  Widget build(BuildContext context) {
    final categories = restaurant!.tags.toList();

    // final restauranItems = allMenuItems
    //     .where((item) => restaurant!.menuItemsId.contains(item.id))
    //     .toList();

    // final menuItems = restaurant!.menuItemsId
    //     .where(
    //       (element) => allMenuItems.firstWhere((item) => item.categoryId == element)  element.category.name == categories[selectedIndex],
    //     )
    //     .toList();
    // final menuItems = restauranItems
    //     .where((item) =>
    //         categoryController.categories
    //             .firstWhere((element) => element.id == item.categoryId)
    //             .name ==
    //         categories[selectedIndex])
    //     .toList();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      height: MediaQuery.of(context).size.height * 0.5,
      child: PageView(
        controller: pageController,
        onPageChanged: (value) => callBack(value),
        children: categories
            .map(
              (e) => Obx(() {
                if (menuItemController.menuItems.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final allMenuItems = menuItemController.menuItems;
                debugPrint('rest id ${restaurant!.menuItemsId}');
                final restauranItems = allMenuItems.where((item) {
                  return restaurant!.menuItemsId.contains(item.id);
                }).toList();
                // print('all  $restauranItems');

                final menuItems = restauranItems
                    .where((item) =>
                        categoryController.categories
                            .firstWhere(
                                (element) => element.id == item.categoryId)
                            .name ==
                        categories[selectedIndex])
                    .toList();

                // print('all rest $restauranItems');

                // print('rest $restauranItems');

                return ListView.separated(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final item = restauranItems.firstWhere((item) =>
                          categoryController.categories
                              .firstWhere(
                                  (element) => element.id == item.categoryId)
                              .name ==
                          categories[selectedIndex]);
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => MealDetailsScreen(
                              menuItem: item, restaurant: restaurant));
                        },
                        child: FoodItem(
                          key: ValueKey(item.id),
                          menuItem: item,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 5,
                        ),
                    itemCount: menuItems.length);
              }),
            )
            .toList(),
      ),
    );
  }
}

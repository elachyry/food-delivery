import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:food_delivery_express/blocs/favoriteMenuItems/favorite_menu_items_bloc.dart';
import 'package:food_delivery_express/controllers/menu_items_controller.dart';
import 'package:food_delivery_express/models/restaurant.dart';
import 'package:food_delivery_express/screens/meal_details/meal_details_screen.dart';
import 'package:food_delivery_express/widgets/restaurant_details/food_item.dart';

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
                final restauranItems = allMenuItems.where((item) {
                  return restaurant!.menuItemsId.contains(item.id);
                }).toList();

                final menuItems = restauranItems
                    .where((item) =>
                        categoryController.categories
                            .firstWhere(
                                (element) => element.id == item.categoryId)
                            .name ==
                        categories[selectedIndex])
                    .toList();

                return BlocBuilder<FavoriteMenuItemsBloc,
                    FavoriteMenuItemsState>(builder: (context, state) {
                  if (state is FavoriteMenuItemsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is FavoriteMenuItemsLoaded) {
                    return ListView.separated(
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          final item = restauranItems.firstWhere((item) =>
                              categoryController.categories
                                  .firstWhere((element) =>
                                      element.id == item.categoryId)
                                  .name ==
                              categories[selectedIndex]);
                          final isFavorite = state.favorites.contains(item.id);
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => MealDetailsScreen(
                                  menuItem: item, restaurant: restaurant));
                            },
                            child: FoodItem(
                              key: ValueKey(item.id),
                              menuItem: item,
                              isFavorite: isFavorite,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 5,
                            ),
                        itemCount: menuItems.length);
                  } else {
                    return Text('an_error_occurred_please_try_again_later'.tr);
                  }
                });
              }),
            )
            .toList(),
      ),
    );
  }
}

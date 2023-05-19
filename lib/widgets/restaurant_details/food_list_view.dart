import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_languges/models/restaurant.dart';
import 'package:multi_languges/screens/meal_details/meal_details_screen.dart';
import 'package:multi_languges/widgets/restaurant_details/food_item.dart';

class FoodListView extends StatelessWidget {
  final int selectedIndex;
  final Function callBack;
  final PageController pageController;
  final Restaurant? restaurant;
  const FoodListView({
    super.key,
    required this.selectedIndex,
    required this.callBack,
    required this.pageController,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    final categories = restaurant!.tags.toList();
    final menuItems = restaurant!.menuItems
        .where(
          (element) => element.category.name == categories[selectedIndex],
        )
        .toList();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      height: MediaQuery.of(context).size.height * 0.5,
      child: PageView(
        controller: pageController,
        onPageChanged: (value) => callBack(value),
        children: categories
            .map(
              (e) => ListView.separated(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final item = menuItems.firstWhere((element) =>
                        element.category.name == categories[selectedIndex]);
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => MealDetailsScreen(
                            menuItem: item, restaurant: restaurant));
                      },
                      child: FoodItem(menuItem: item),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 5,
                      ),
                  itemCount: menuItems.length),
            )
            .toList(),
      ),
    );
  }
}

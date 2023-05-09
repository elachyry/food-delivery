import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_languges/models/category.dart';
import 'package:multi_languges/models/restaurant.dart';
import 'package:multi_languges/screens/restaurant_listing/restaurant_listing_screen.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  const CategoryItem({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final List<Restaurant> restaurants = Restaurant.restaurants
        .where(
          (element) => element.tags.contains(category.name),
        )
        .toList();
    return InkWell(
      onTap: () {
        Get.to(
          RestaurantListingScreen(
            restaurants: restaurants,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 7),
        height: 100,
        width: 75,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
              width: 40,
              child: category.image,
            ),
            const SizedBox(
              height: 8,
            ),
            FittedBox(
              child: Text(
                category.name,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

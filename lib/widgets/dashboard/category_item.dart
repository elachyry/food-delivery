import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_delivery_express/models/category.dart';
import 'package:food_delivery_express/models/restaurant.dart';
import 'package:food_delivery_express/screens/restaurant_listing/restaurant_listing_screen.dart';
import 'package:food_delivery_express/utils/constants/image_constants.dart';

import '../../controllers/category_controller.dart';
import '../../controllers/restaurant_controller.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  CategoryItem({
    super.key,
    required this.category,
  });
  final restaurantController = Get.put(RestaurantController());
  final categoryController = Get.put(CategoryController());
  @override
  Widget build(BuildContext context) {
    final List<Restaurant> restaurants = restaurantController.restaurants
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
              child: FadeInImage(
                imageErrorBuilder: (context, error, stackTrace) =>
                    Image.asset(ImageConstants.categoryPlaceholder),
                placeholder:
                    const AssetImage(ImageConstants.categoryPlaceholder),
                image: NetworkImage(
                  category.imageUrl,
                ),
                fit: BoxFit.cover,
              ),
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

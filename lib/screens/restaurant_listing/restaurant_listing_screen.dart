import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:multi_languges/models/restaurant.dart';
import 'package:multi_languges/widgets/dashboard/restaurant_item.dart';
import 'package:multi_languges/widgets/filter/show_category_modal_bottom_sheet.dart';
import 'package:multi_languges/widgets/filter/show_filter_modal_bottom_sheet.dart';

import '../../controllers/restaurant_controller.dart';

class RestaurantListingScreen extends StatelessWidget {
  final List<Restaurant> restaurants;
  RestaurantListingScreen({
    super.key,
    required this.restaurants,
  });
  final restaurantController = Get.put(RestaurantController());

  @override
  Widget build(BuildContext context) {
    print(restaurantController.restaurants);

    final appbar = AppBar(
      backgroundColor: Colors.white,
      title: Text(
        'Restaurants',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      centerTitle: true,
      elevation: 0,
    );
    return Scaffold(
      appBar: appbar,
      body: SizedBox(
        child: Column(
          children: [
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showFilterModalBotomSheet(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                      ),
                      icon: const Icon(
                        Bootstrap.sliders2,
                        color: Colors.black,
                      ),
                      label: Text(
                        'Filters',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showCategoryModalBotomSheet(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      icon: const Icon(
                        Bootstrap.columns_gap,
                        color: Colors.black,
                      ),
                      label: Text(
                        'Categories',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 5, left: 5),
              height: MediaQuery.of(context).size.height -
                  appbar.preferredSize.height -
                  MediaQuery.of(context).padding.top -
                  48,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: restaurants.length,
                itemBuilder: (context, index) => RestaurantItem(
                  restaurant: restaurants[index],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

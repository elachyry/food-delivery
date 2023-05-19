import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/category.dart';
import '../../models/coupon.dart';
import '../../models/restaurant.dart';
import '../../screens/restaurant_listing/restaurant_listing_screen.dart';
import '../../utils/constants/image_constants.dart';
import '../../widgets/dashboard/category_item.dart';
import '../../widgets/dashboard/coupon_slide.dart';
import '../../widgets/dashboard/dashboard_head.dart';
import '../../widgets/dashboard/restaurant_item.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const DashboardHead(),
            Container(
              padding: const EdgeInsets.only(
                left: 20,
                top: 5,
                bottom: 10,
              ),
              color: Colors.grey.shade200,
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: Category.categories.length,
                  itemBuilder: (context, index) => CategoryItem(
                    category: Category.categories[index],
                  ),
                ),
              ),
            ),
            Coupon.coupons.isEmpty ? Container() : const CouponSlide(),
            Container(
              padding: const EdgeInsets.only(right: 15, left: 15, top: 20),
              color: Colors.grey.shade200,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Restaurants',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 5, bottom: 10),
                            child: Image.asset(
                              ImageConstants.fire,
                              width: 30,
                              height: 30,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        onPressed: () {
                          Get.to(
                            () => RestaurantListingScreen(
                              restaurants: Restaurant.restaurants,
                            ),
                          );
                        },
                        child: Text(
                          'View All',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: Restaurant.restaurants.length,
                      itemBuilder: (context, index) => RestaurantItem(
                        restaurant: Restaurant.restaurants[index],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

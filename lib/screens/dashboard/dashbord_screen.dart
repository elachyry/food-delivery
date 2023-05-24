import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../blocs/favorites/favorites_bloc.dart';
import '../../controllers/category_controller.dart';
import '../../controllers/restaurant_controller.dart';
import '../../models/coupon.dart';
import '../../screens/restaurant_listing/restaurant_listing_screen.dart';
import '../../utils/constants/image_constants.dart';
import '../../widgets/dashboard/category_item.dart';
import '../../widgets/dashboard/coupon_slide.dart';
import '../../widgets/dashboard/dashboard_head.dart';
import '../../widgets/dashboard/restaurant_item.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final restaurantController = Get.put(RestaurantController());
  final categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    restaurantController.loadRedtaurants();

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
                child: Obx(
                  () => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: categoryController.categories.length,
                    itemBuilder: (context, index) => CategoryItem(
                      category: categoryController.categories[index],
                    ),
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
                              restaurants: restaurantController.restaurants,
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
                    child: BlocBuilder<FavoritesBloc, FavoritesState>(
                      builder: (context, state) {
                        if (state is FavoritesLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is FavoritesLoaded) {
                          return Obx(
                            () {
                              if (restaurantController.restaurants.isEmpty) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount:
                                      restaurantController.restaurants.length,
                                  itemBuilder: (context, index) {
                                    final isFavorite = state.favorites.contains(
                                        restaurantController
                                            .restaurants[index].id);
                                    return RestaurantItem(
                                      key: ValueKey(restaurantController
                                          .restaurants[index].id),
                                      restaurant: restaurantController
                                          .restaurants[index],
                                      isFavorite: isFavorite,
                                    );
                                  });
                            },
                          );
                        } else {
                          return Text(
                              'an_error_occurred_please_try_again_later'.tr);
                        }
                      },
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:multi_languges/blocs/filters/filters_bloc.dart';
import 'package:multi_languges/models/restaurant.dart';
import 'package:multi_languges/screens/restaurant_listing/restaurant_listing_screen.dart';
import 'package:multi_languges/widgets/filter/custom_popular_filters.dart';

import '../../controllers/rating_controller.dart';
import '../../controllers/restaurant_controller.dart';
import '../../widgets/filter/custom_catygory_filter.dart';
import '../../widgets/filter/custom_price_filter.dart';

Future<dynamic> showFilterModalBotomSheet(BuildContext context) {
  final restaurnatController = Get.put(RestaurantController());
  final ratingController = Get.put(RatingController());

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
    ),
    builder: (context) => SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 70, bottom: 60),
              // color: Colors.grey.shade200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Popular filters',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CustomPopularFilters(),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Filter by price',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const CustomPriceFilter(),
                ],
              ),
            ),
          ),
          Positioned(
            left: 5,
            top: 5,
            right: 5,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.grey.shade200),
                        child: const Icon(
                          Icons.close,
                        ),
                      ),
                    ),
                    Text(
                      'Filtter',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    BlocBuilder<FiltersBloc, FiltersState>(
                      builder: (context, state) {
                        if (state is FiltersLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is FiltersLoaded) {
                          return TextButton(
                            onPressed: () {
                              for (var e in state.filter.priceFilters) {
                                context.read<FiltersBloc>().add(
                                      PriceFilterUpdate(
                                        priceFilter: e.copyWith(
                                          value: false,
                                        ),
                                      ),
                                    );
                              }

                              for (var e in state.filter.popularFilters) {
                                context.read<FiltersBloc>().add(
                                      PopularFiltersUpdate(
                                        popularFilters: e.copyWith(
                                          value: false,
                                        ),
                                      ),
                                    );
                              }
                            },
                            child: const Text(
                              'Clear All',
                            ),
                          );
                        } else {
                          return Center(
                            child: Text(
                                'an_error_occurred_please_try_again_later'.tr),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            height: 50,
            left: 5,
            bottom: 5,
            right: 5,
            child: SizedBox(
              child: BlocBuilder<FiltersBloc, FiltersState>(
                builder: (context, state) {
                  if (state is FiltersLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is FiltersLoaded) {
                    return ElevatedButton(
                      onPressed: () {
                        var categories = state.filter.categoryFilters
                            .where((element) => element.value)
                            .map((e) => e.category.name)
                            .toList();
                        var prices = state.filter.priceFilters
                            .where((element) => element.value)
                            .map((e) => e.price.price)
                            .toList();

                        var populars = state.filter.popularFilters
                            .where((element) => element.value)
                            .map((e) => e.popular.popular)
                            .toList();

                        List<Restaurant> filtre1 =
                            restaurnatController.restaurants
                                .where(
                                  (restaurant) => categories.any(
                                    (category) =>
                                        restaurant.tags.contains(category),
                                  ),
                                )
                                .toList();
                        List<Restaurant> filtre2 = restaurnatController
                            .restaurants
                            .where(
                              (restaurant) => prices.any(
                                (price) =>
                                    restaurant.priceCategory.contains(price),
                              ),
                            )
                            .toList();
                        List<Restaurant> filtre3 = [];
                        List<Restaurant> filtre4 = [];

                        if (populars.contains('Fast delivery')) {
                          filtre3 = restaurnatController.restaurants
                              .where(
                                  (restaurant) => restaurant.deliveryTime <= 30)
                              .toList();
                        }

                        Set<Restaurant> unionFilters = Set.from([
                          ...filtre1,
                          ...filtre2,
                          ...filtre3,
                        ]);

                        List<Restaurant> filtredRestaurants =
                            unionFilters.toList();
                        // print('befor sort $filtredRestaurants');

                        if (populars.contains('Top rated')) {
                          if (filtredRestaurants.isEmpty) {
                            filtredRestaurants =
                                restaurnatController.restaurants;
                          }
                          filtredRestaurants.sort(
                            (a, b) {
                              var ratingA = 0.0;
                              for (var e in ratingController.ratings
                                  .where((element) =>
                                      a.ratingsId.contains(element.id))
                                  .toList()) {
                                ratingA += e.rate;
                              }
                              ratingA = ratingA /
                                  ratingController.ratings
                                      .where((element) =>
                                          a.ratingsId.contains(element.id))
                                      .toList()
                                      .length;

                              var ratingB = 0.0;
                              for (var e in ratingController.ratings
                                  .where((element) =>
                                      a.ratingsId.contains(element.id))
                                  .toList()) {
                                ratingB += e.rate;
                              }
                              ratingB = ratingB /
                                  ratingController.ratings
                                      .where((element) =>
                                          a.ratingsId.contains(element.id))
                                      .toList()
                                      .length;

                              return ratingB.compareTo(ratingA);
                            },
                          );
                        }
                        // print('after sort $filtredRestaurants');

                        // if (populars.contains('New added')) {
                        //   if (filtredRestaurants.isEmpty) {
                        //     filtredRestaurants =
                        //         restaurnatController.restaurants;
                        //   }
                        //   filtredRestaurants.sort(
                        //     (a, b) => DateTime.parse(b.addedAt)
                        //         .compareTo(DateTime.parse(a.addedAt)),
                        //   );
                        // }

                        if (populars.contains('Free delivery')) {
                          filtre4 = restaurnatController.restaurants
                              .where(
                                  (restaurant) => restaurant.deliveryFee == 0)
                              .toList();
                          if (filtredRestaurants.isEmpty) {
                            filtredRestaurants = filtre4;
                          }
                          Set<Restaurant> intersection = filtredRestaurants
                              .toSet()
                              .intersection(filtre4.toSet());

                          filtredRestaurants = intersection.toList();
                        }

                        if (populars.isEmpty &&
                            prices.isEmpty &&
                            categories.isEmpty) {
                          filtredRestaurants = restaurnatController.restaurants;
                        }
                        Get.back();
                        Get.back();
                        // print('test $filtredRestaurants');
                        Get.to(
                          () => RestaurantListingScreen(
                              restaurants: filtredRestaurants),
                        );
                      },
                      child: Text(
                        'save'.tr,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    );
                  } else {
                    return Center(
                      child:
                          Text('an_error_occurred_please_try_again_later'.tr),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Row filterBuilder(String title, bool value, Function callBack) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title),
      Checkbox(
        value: value,
        onChanged: (value) {
          callBack(value);
        },
      )
    ],
  );
}

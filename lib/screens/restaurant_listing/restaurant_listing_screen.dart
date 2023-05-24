import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:multi_languges/blocs/favorites/favorites_bloc.dart';
import 'package:multi_languges/blocs/filters/filters_bloc.dart';
import 'package:multi_languges/controllers/auth/user_controller.dart';
import 'package:multi_languges/controllers/category_controller.dart';
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
  final userController = Get.put((UserController()));
  final categoryContoller = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    // print(restaurantController.restaurants);

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
        child: SingleChildScrollView(
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
                          context.read<FiltersBloc>().add(FilterLoad());
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
              BlocBuilder<FavoritesBloc, FavoritesState>(
                builder: (context, state) {
                  if (state is FavoritesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is FavoritesLoaded) {
                    return Container(
                      padding: const EdgeInsets.only(right: 5, left: 5),
                      height: MediaQuery.of(context).size.height -
                          appbar.preferredSize.height -
                          MediaQuery.of(context).padding.top -
                          90,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: restaurants.length,
                        itemBuilder: (context, index) {
                          final isFavorite = state.favorites.contains(
                              restaurantController.restaurants[index].id);
                          return RestaurantItem(
                            restaurant: restaurants[index],
                            isFavorite: isFavorite,
                          );
                        },
                      ),
                    );
                  } else {
                    return Text('an_error_occurred_please_try_again_later'.tr);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

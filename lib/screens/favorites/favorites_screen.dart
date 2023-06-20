import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:food_delivery_express/blocs/favoriteMenuItems/favorite_menu_items_bloc.dart';
import 'package:food_delivery_express/blocs/favorites/favorites_bloc.dart';
import 'package:food_delivery_express/controllers/menu_items_controller.dart';
import 'package:food_delivery_express/controllers/restaurant_controller.dart';
import 'package:food_delivery_express/models/menu_item.dart';
import 'package:food_delivery_express/models/restaurant.dart';
import 'package:food_delivery_express/utils/constants/image_constants.dart';
import 'package:food_delivery_express/widgets/dashboard/restaurant_item.dart';
import 'package:food_delivery_express/widgets/restaurant_details/food_item.dart';

enum SegmentType {
  restaurants,
  menuItesm,
}

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  int currentPage = 0;
  final pageController = PageController();
  final RestaurantController restaurantController =
      Get.put(RestaurantController());
  final MenuItemsController menuItemsController =
      Get.put(MenuItemsController());

  void callBack(index) {
    setState(() {
      currentPage = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'favorites'.tr,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomSlidingSegmentedControl<SegmentType>(
                  initialValue: SegmentType.restaurants,
                  isStretch: true,
                  height: 50,
                  children: {
                    SegmentType.restaurants: Text(
                      'restaurants'.tr,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: currentPage == SegmentType.restaurants.index
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    SegmentType.menuItesm: Text(
                      'menu_items'.tr,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: currentPage == SegmentType.menuItesm.index
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  },
                  innerPadding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(14),
                  ),
                  thumbDecoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onValueChanged: (v) {
                    setState(() {
                      currentPage = v.index;
                    });
                  },
                ),
              ),
              if (currentPage == SegmentType.restaurants.index)
                BlocBuilder<FavoritesBloc, FavoritesState>(
                  builder: (context, state) {
                    if (state is FavoritesLoading) {
                      return const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (state is FavoritesLoaded) {
                      List<String> restaurantsFav = state.favorites;
                      List<Restaurant> restaurants = [];
                      restaurants = restaurantController.restaurants
                          .where((e) => restaurantsFav.contains(e.id))
                          .toList();
                      return Expanded(
                        child: restaurantsFav.isEmpty
                            ? Center(
                                child: Image.asset(
                                  ImageConstants.favoritesPlaceholder,
                                  width: 80,
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                // height: MediaQuery.of(context).size.height -
                                //     MediaQuery.of(context).padding.bottom,
                                child: ListView.builder(
                                  itemCount: restaurants.length,
                                  itemBuilder: (context, index) =>
                                      RestaurantItem(
                                          restaurant: restaurants[index],
                                          isFavorite: true),
                                )),
                      );
                    } else {
                      return Text(
                          'an_error_occurred_please_try_again_later'.tr);
                    }
                  },
                )
              else if (currentPage == SegmentType.menuItesm.index)
                BlocBuilder<FavoriteMenuItemsBloc, FavoriteMenuItemsState>(
                  builder: (context, state) {
                    if (state is FavoriteMenuItemsLoading) {
                      return const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (state is FavoriteMenuItemsLoaded) {
                      List<String> MenuItemsFav = state.favorites;
                      List<MenuItem> menuItems = [];
                      menuItems = menuItemsController.menuItems
                          .where((e) => MenuItemsFav.contains(e.id))
                          .toList();
                      return Expanded(
                        child: MenuItemsFav.isEmpty
                            ? Center(
                                child: Image.asset(
                                  ImageConstants.favoritesPlaceholder,
                                  width: 80,
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                // height: MediaQuery.of(context).size.height -
                                //     MediaQuery.of(context).padding.bottom,
                                child: ListView.builder(
                                  itemCount: menuItems.length,
                                  itemBuilder: (context, index) => FoodItem(
                                      menuItem: menuItems[index],
                                      isFavorite: true),
                                )),
                      );
                    } else {
                      return Text(
                          'an_error_occurred_please_try_again_later'.tr);
                    }
                  },
                )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:food_delivery_express/blocs/favoriteMenuItems/favorite_menu_items_bloc.dart';
import 'package:food_delivery_express/models/menu_item.dart';

import 'package:food_delivery_express/models/restaurant.dart';

import '../../widgets/meal_details/meal_details_bottom_nav_bar.dart';
import '../../widgets/meal_details/meal_details_head.dart';
import '../../widgets/meal_details/meal_informations.dart';

class MealDetailsScreen extends StatefulWidget {
  final MenuItem? menuItem;
  final Restaurant? restaurant;

  const MealDetailsScreen({
    super.key,
    required this.menuItem,
    required this.restaurant,
  });

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  int selectedIndex = 0;
  final pageController = PageController();
  void callBack(index) {
    setState(() {
      selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MealDetailsBottomNavBar(
        restaurant: widget.restaurant,
        menuItem: widget.menuItem,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: BlocBuilder<FavoriteMenuItemsBloc, FavoriteMenuItemsState>(
          builder: (context, state) {
            if (state is FavoriteMenuItemsLoading) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is FavoriteMenuItemsLoaded) {
              final isFavorite = state.favorites.contains(widget.menuItem!.id);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MealDetailsHead(
                    menuItem: widget.menuItem,
                    isFavorite: isFavorite,
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 20, top: 20, bottom: 10),
                        child: Mealinformations(
                          menuItem: widget.menuItem,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return Text('an_error_occurred_please_try_again_later'.tr);
            }
          },
        ),
      ),
    );
  }
}

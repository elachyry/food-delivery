import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:food_delivery_express/models/restaurant.dart';
import 'package:food_delivery_express/widgets/restaurant_details/category_list.dart';
import 'package:food_delivery_express/widgets/restaurant_details/food_list_view.dart';
import 'package:food_delivery_express/widgets/restaurant_details/restaurant_details_bottom_nav_bar.dart';
import 'package:food_delivery_express/widgets/restaurant_details/restaurant_details_head.dart';
import 'package:food_delivery_express/widgets/restaurant_details/restaurant_informatins.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../blocs/favorites/favorites_bloc.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  final Restaurant? restaurant;
  const RestaurantDetailsScreen({
    super.key,
    required this.restaurant,
  });

  @override
  State<RestaurantDetailsScreen> createState() =>
      _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
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
      bottomNavigationBar:
          RestaurantDetailsBottomNavBar(restaurant: widget.restaurant),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            if (state is FavoritesLoading) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is FavoritesLoaded) {
              final isFavorite =
                  state.favorites.contains(widget.restaurant!.id);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RestaurantDetailsHead(
                    restaurant: widget.restaurant,
                    isFavorite: isFavorite,
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 10),
                        child: Restaurantinformations(
                            restaurant: widget.restaurant),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 20, right: 0, top: 15, bottom: 10),
                        child: CategoryList(
                          selectedIndex: selectedIndex,
                          callBack: callBack,
                          restaurant: widget.restaurant,
                        ),
                      ),
                      SizedBox(
                        child: FoodListView(
                          // key: UniqueKey(),
                          selectedIndex: selectedIndex,
                          callBack: callBack,
                          pageController: pageController,
                          restaurant: widget.restaurant,
                        ),
                      ),
                      (widget.restaurant!.tags.toList().isEmpty)
                          ? Container()
                          : Container(
                              height: 60,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: SmoothPageIndicator(
                                controller: pageController,
                                count: (widget.restaurant!.tags.toList().length)
                                        .isNaN
                                    ? 0
                                    : widget.restaurant!.tags.toList().length,
                                effect: CustomizableEffect(
                                  dotDecoration: DotDecoration(
                                    width: 8,
                                    height: 8,
                                    color: Theme.of(context).primaryColorLight,
                                    borderRadius: BorderRadius.circular(
                                      8,
                                    ),
                                  ),
                                  activeDotDecoration: DotDecoration(
                                    width: 10,
                                    height: 10,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                ),
                                onDotClicked: (index) =>
                                    pageController.jumpToPage(index),
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

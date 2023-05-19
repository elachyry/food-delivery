import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:multi_languges/models/menu_item.dart';

import 'package:multi_languges/models/restaurant.dart';
import 'package:multi_languges/widgets/restaurant_details/category_list.dart';
import 'package:multi_languges/widgets/restaurant_details/food_list_view.dart';
import 'package:multi_languges/widgets/restaurant_details/restaurant_details_bottom_nav_bar.dart';
import 'package:multi_languges/widgets/restaurant_details/restaurant_details_head.dart';
import 'package:multi_languges/widgets/restaurant_details/restaurant_informatins.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MealDetailsHead(menuItem: widget.menuItem),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20, top: 20, bottom: 10),
                  child: Mealinformations(menuItem: widget.menuItem),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

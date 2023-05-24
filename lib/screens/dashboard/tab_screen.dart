import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_languges/screens/favorites/favorites_screen.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

import 'package:multi_languges/controllers/dashboard_controller.dart';
import 'package:multi_languges/screens/dashboard/dashbord_screen.dart';
import 'package:multi_languges/screens/profile/profile_screen.dart';

import '../../controllers/auth/user_controller.dart';

class TabScreen extends StatelessWidget {
  TabScreen({super.key});
  final controller = Get.put(DashboardController());
  final userController = Get.put(UserController());

  PageController pageController = PageController(initialPage: 0);
  // final _pages = [
  //   {
  //     'page': DashboardScreen(),
  //     'title': 'home',
  //   },
  //   {
  //     'page': const FavoritesScreen(),
  //     'title': 'favorates',
  //   },
  //   {
  //     'page': const ProfileScreen(),
  //     'title': 'profile',
  //   },
  // ];
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: <Widget>[
            DashboardScreen(),
            const FavoritesScreen(),
            const ProfileScreen(),
          ],
        ),
        bottomNavigationBar: WaterDropNavBar(
          selectedIndex: controller.currentIndex.value,
          iconSize: 30,
          bottomPadding: 10,
          inactiveIconColor: Colors.grey,
          waterDropColor: Theme.of(context).primaryColorDark,
          // selectedItemColor: Theme.of(context).primaryColor,
          onItemSelected: (i) {
            userController.getUserData();

            controller.currentIndex.value = i;
            pageController.animateToPage(
              controller.currentIndex.value,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutQuad,
            );
          },

          barItems: [
            /// Home
            BarItem(
              filledIcon: Icons.home,
              outlinedIcon: Icons.home_outlined,
            ),

            /// Likes
            BarItem(
              filledIcon: Icons.favorite_sharp,
              outlinedIcon: Icons.favorite_border_rounded,
            ),

            /// Profile
            BarItem(
              filledIcon: Icons.person,
              outlinedIcon: Icons.person_outlined,
            ),
          ],
        ),
      ),
    );
  }
}

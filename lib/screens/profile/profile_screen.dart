import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:multi_languges/controllers/auth/auth_controller.dart';
import 'package:multi_languges/controllers/auth/user_controller.dart';
import 'package:multi_languges/controllers/order_controller.dart';
import 'package:multi_languges/models/status.dart';
import 'package:multi_languges/screens/language_selection_screen.dart';
import 'package:multi_languges/screens/location/navigation_screen.dart';
import 'package:multi_languges/screens/notifications/notifications_screen.dart';
import 'package:multi_languges/screens/profile/edit_profile_screen.dart';
import 'package:multi_languges/screens/settings/settings_screen.dart';
import 'package:multi_languges/utils/app_routes.dart';
import 'package:multi_languges/utils/constants/image_constants.dart';
import 'package:multi_languges/widgets/profile/profile_list_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final userController = Get.put((UserController()));
    final ordersController = Get.put(OrderController());

    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () {
        //     Get.back();
        //   },
        //   icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
        // ),
        centerTitle: true,
        title: Text(
          'profile'.tr,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(isDark ? Icons.dark_mode_rounded : Icons.light_mode,
        //         color: Colors.black),
        //   )
        // ],
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          if (userController.myData.isEmpty) {
            return SizedBox(
              height: MediaQuery.of(context).size.height - 50,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          final data = userController.myData;
          double totalSpend = 0;
          for (var element in ordersController.orders) {
            if (getStatusValue(element.status) == 'Delivered') {
              totalSpend = element.total;
            }
          }
          return Container(
            padding:
                const EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 15),
            child: Column(
              children: [
                Stack(
                  children: [
                    Obx(
                      () => SizedBox(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: data['userImage'] == ''
                              ? Image.asset(
                                  ImageConstants.user,
                                  fit: BoxFit.fill,
                                )
                              : FadeInImage(
                                  placeholder:
                                      const AssetImage(ImageConstants.user),
                                  image: NetworkImage(
                                    data['userImage'],
                                  ),
                                ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Theme.of(context).primaryColorDark),
                        child: IconButton(
                          onPressed: () {
                            userController.getUserData();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (context) => EditProfileScreen(),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  data['fullName'],
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  data['email'],
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.grey.shade700),
                ),
                const SizedBox(
                  height: 20,
                ),
                // SizedBox(
                //   width: 200,
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       padding: const EdgeInsets.symmetric(vertical: 15),
                //       textStyle: Theme.of(context)
                //           .textTheme
                //           .titleMedium!
                //           .copyWith(fontWeight: FontWeight.bold),
                //       shape: const StadiumBorder(),
                //     ),
                //     onPressed: () {
                //       userController.getUserData();

                //       Navigator.of(context).push(
                //         MaterialPageRoute(
                //           fullscreenDialog: true,
                //           builder: (context) => EditProfileScreen(),
                //         ),
                //       );
                //     },
                //     child: Text('edit_profile'.tr),
                //   ),
                // ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Total Orders',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            ordersController.orders.length.toString(),
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).primaryColorDark,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Total Spend',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${totalSpend.toStringAsFixed(2)} Dh',
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).primaryColorDark,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                ProfileListItem(
                  leadingIcon: LineAwesomeIcons.cog,
                  title: 'settings'.tr,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => const SettingsScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ProfileListItem(
                  leadingIcon: Bootstrap.bag_check,
                  title: 'my_orders'.tr,
                  onTap: () {
                    Get.toNamed(AppRoutes.ordersScreenRoute);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ProfileListItem(
                  leadingIcon: Bootstrap.geo_alt,
                  title: 'address'.tr,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => const NavigationScreen(),
                      ),
                    );
                    // Get.toNamed(AppRoutes.locationScreenRoute);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ProfileListItem(
                  leadingIcon: Bootstrap.bell,
                  title: 'Notifications'.tr,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => const NotificationsScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                ProfileListItem(
                  leadingIcon: Bootstrap.chat_dots,
                  title: 'FAQ'.tr,
                  onTap: () {
                    Get.toNamed(AppRoutes.dashboardScreenRoute);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ProfileListItem(
                  leadingIcon: LineAwesomeIcons.question,
                  title: 'about_us'.tr,
                  onTap: () {},
                ),
                const SizedBox(
                  height: 10,
                ),
                ProfileListItem(
                  leadingIcon: Icons.logout,
                  title: 'logout'.tr,
                  onTap: () {
                    AuthController.instance.logout();
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:multi_languges/controllers/auth/auth_controller.dart';
import 'package:multi_languges/controllers/auth/user_controller.dart';
import 'package:multi_languges/screens/language_selection_screen.dart';
import 'package:multi_languges/screens/profile/edit_profile_screen.dart';
import 'package:multi_languges/utils/app_routes.dart';
import 'package:multi_languges/utils/constants/image_constants.dart';
import 'package:multi_languges/widgets/profile/profile_list_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final userController = Get.put((UserController()));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
        ),
        centerTitle: true,
        title: Text(
          'profile'.tr,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(isDark ? Icons.dark_mode_rounded : Icons.light_mode,
                color: Colors.black),
          )
        ],
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
          return Container(
            padding: const EdgeInsets.all(30),
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
                  height: 10,
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      textStyle: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () {
                      userController.getUserData();

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => EditProfileScreen(),
                        ),
                      );
                    },
                    child: Text('edit_profile'.tr),
                  ),
                ),
                const SizedBox(
                  height: 30,
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
                        builder: (context) =>
                            LanguageSelectionScreen(firstTime: false),
                      ),
                    );
                  },
                ),
                ProfileListItem(
                  leadingIcon: LineAwesomeIcons.store,
                  title: 'my_orders'.tr,
                  onTap: () {},
                ),
                ProfileListItem(
                  leadingIcon: Icons.favorite,
                  title: 'your_favorites'.tr,
                  onTap: () {
                    Get.toNamed(AppRoutes.dashboardScreenRoute);
                  },
                ),
                ProfileListItem(
                  leadingIcon: Icons.book_outlined,
                  title: 'address'.tr,
                  onTap: () {
                    Get.toNamed(AppRoutes.locationScreenRoute);
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                ProfileListItem(
                  leadingIcon: LineAwesomeIcons.question,
                  title: 'about_us'.tr,
                  onTap: () {},
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

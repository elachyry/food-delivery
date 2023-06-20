import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_delivery_express/controllers/auth/user_controller.dart';
import 'package:food_delivery_express/controllers/restaurant_controller.dart';
import 'package:food_delivery_express/utils/constants/image_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/cart_controller.dart';
import '../utils/app_routes.dart';
import 'location/navigation_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController _controller;
  final GlobalKey<ScaffoldState> _gloablKey = GlobalKey();
  int? initScreen;
  String? deliveryTo;
  final userController = Get.put(UserController());
  final restaurantController = Get.put(RestaurantController());
  final cartController = Get.put(CartController());

  Future<void> initScreenPrefrences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    initScreen = sharedPreferences.getInt('initScreen');
    await sharedPreferences.setInt('initScreen', 1);
  }

  Future<void> chooseDeliveryTo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    deliveryTo = sharedPreferences.getString('deliveryTo');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    initScreenPrefrences();
    chooseDeliveryTo();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
    Timer(const Duration(seconds: 3), () {
      //  AuthRepository.instance.firebaseUser.value != null
      //       ? Get.offAllNamed(AppRoutes.dashboardScreenRoute)
      //       : Get.offAllNamed(AppRoutes.dashboardScreenRoute);

      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null) {
          if (deliveryTo == null || deliveryTo == '') {
            Get.offAll(() => const NavigationScreen(
                  fromDplash: true,
                ));
          } else {
            userController.getUserData();
            userController.getFavorites();
            restaurantController.loadRedtaurants();
            cartController.getCart();
            Get.offAllNamed(AppRoutes.tabsScreenRoute);
          }
          // User is already logged in, navigate to dashboard screen

          // print('user not null');
        } else {
          // print('user null');

          if (initScreen == 0 || initScreen == null) {
            // print('user null and initScreen = 0');

            Get.offAllNamed(AppRoutes.selectLanguageScreenRoute);
          } else {
            // print('user null and initScreen = 1');

            Get.offAllNamed(AppRoutes.welecomeScreenRoute);
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _gloablKey,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(right: 15, bottom: 10),
                child: Image.asset(
                  ImageConstants.deliveryOutline,
                  width: 200,
                ),
              ),
            ),
          ),
          Center(
            child: Image.asset(
              ImageConstants.logo,
              width: 200,
            ),
          ),
        ],
      ),
    );
  }
}

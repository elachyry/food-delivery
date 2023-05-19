import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_languges/controllers/auth/user_controller.dart';
import 'package:multi_languges/utils/constants/image_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/cart_controller.dart';
import '../utils/app_routes.dart';

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
  final userController = Get.put(UserController());

  Future<void> initScreenPrefrences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    initScreen = await sharedPreferences.getInt('initScreen');
    await sharedPreferences.setInt('initScreen', 1);
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
          // User is already logged in, navigate to dashboard screen
          userController.getUserData();
          Get.offAllNamed(AppRoutes.tabsScreenRoute);
          // print('user not null');
        } else {
          // print('user null');

          if (initScreen == 0 || initScreen == null) {
            // print('user null and initScreen = 0');

            Get.offAllNamed(AppRoutes.selectLanguageScreenRoute);
          } else {
            // print('user null and initScreen = 1');
            final cartController = Get.find<CartController>();
            cartController.getCart();
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

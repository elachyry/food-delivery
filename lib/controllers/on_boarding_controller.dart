import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:food_delivery_express/utils/app_routes.dart';

import '../utils/constants/image_constants.dart';
import '../widgets/on_boarding_item.dart';
import '../models/on_boarding.dart';

class OnBoardingController extends GetxController {
  final liquidController = LiquidController();
  RxInt currentPage = 0.obs;

  final pages = [
    OnBoardingItem(
      onBoarding: OnBoarding(
        image: ImageConstants.onBoardingPage0,
        title: 'on_boarding_page_0_title'.tr.toUpperCase(),
        subTitle: 'on_boarding_page_0_subtitle'.tr,
        bgColor: Colors.white,
      ),
    ),
    OnBoardingItem(
      onBoarding: OnBoarding(
        image: ImageConstants.onBoardingPage1,
        title: 'on_boarding_page_1_title'.tr.toUpperCase(),
        subTitle: 'on_boarding_page_1_subtitle'.tr,
        bgColor: const Color(0xFFFDDCDF),
      ),
    ),
    OnBoardingItem(
      onBoarding: OnBoarding(
        image: ImageConstants.onBoardingPage2,
        title: 'on_boarding_page_2_title'.tr.toUpperCase(),
        subTitle: 'on_boarding_page_2_subtitle'.tr,
        bgColor: const Color.fromARGB(255, 189, 212, 246),
      ),
    ),
    OnBoardingItem(
      onBoarding: OnBoarding(
        image: ImageConstants.onBoardingPage3,
        title: 'on_boarding_page_3_title'.tr.toUpperCase(),
        subTitle: 'on_boarding_page_3_subtitle'.tr,
        bgColor: const Color.fromARGB(255, 241, 198, 155),
      ),
    ),
  ];

  void onPageChangeCallback(activePageIndex) {
    if (currentPage >= 3) {
      Get.offNamed(AppRoutes.welecomeScreenRoute);
    }
    currentPage.value = activePageIndex;
  }

  void nextPage() {
    if (currentPage >= 3) {
      Get.offNamed(AppRoutes.welecomeScreenRoute);
    }
    int nextPage = liquidController.currentPage + 1;
    liquidController.animateToPage(page: nextPage);
  }

  void skip() {
    currentPage.value = 3;
    liquidController.jumpToPage(page: 3);
  }
}

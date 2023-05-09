import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../controllers/language_controller.dart';
import '../controllers/on_boarding_controller.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final onBoardingController = OnBoardingController();

    return Scaffold(
      body: GetBuilder<LocalizationController>(builder: (controller) {
        return Obx(
          () => Stack(
            alignment: Alignment.center,
            children: [
              LiquidSwipe(
                pages: onBoardingController.pages,
                slideIconWidget: const Icon(Icons.arrow_back_ios_rounded),
                enableSideReveal: true,
                liquidController: onBoardingController.liquidController,
                onPageChangeCallback: (activePageIndex) =>
                    onBoardingController.onPageChangeCallback(activePageIndex),
              ),
              Positioned(
                bottom: 60,
                child: OutlinedButton(
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                      color: Colors.black26,
                    ),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                  ),
                  onPressed: onBoardingController.nextPage,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      controller.selectedIndex == 3
                          ? Icons.check
                          : Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 175,
                child: Text(
                  '${onBoardingController.currentPage.value + 1}/4',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Positioned(
                right: controller.selectedIndex == 2 ? null : 20,
                top: 50,
                left: controller.selectedIndex == 2 ? 0 : null,
                child: TextButton(
                  onPressed: onBoardingController.skip,
                  child: Text(
                    'skip'.tr,
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 15),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                child: AnimatedSmoothIndicator(
                  activeIndex: onBoardingController.currentPage.value,
                  count: 4,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Theme.of(context).primaryColorDark,
                  ),
                  textDirection: controller.selectedIndex == 2
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

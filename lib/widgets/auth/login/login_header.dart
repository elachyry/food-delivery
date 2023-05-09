import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/image_constants.dart';
import '../../../controllers/language_controller.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(builder: (controller) {
      return Hero(
        tag: 'welcome-to-login',
        child: Container(
          height: 350,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(controller.selectedIndex == 1
                  ? ImageConstants.loginBackgroundFr
                  : controller.selectedIndex == 2
                      ? ImageConstants.loginBackgroundAr
                      : controller.selectedIndex == 3
                          ? ImageConstants.loginBackgroundEs
                          : ImageConstants.loginBackgroundEn),
              fit: BoxFit.cover,
            ),
          ),
          child: null,
        ),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/image_constants.dart';
import '../../../controllers/language_controller.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(builder: (controller) {
      return Hero(
        tag: 'welcome-to-login',
        child: Container(
          height: 270,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: controller.selectedIndex == 1
                  ? const AssetImage(
                      ImageConstants.signupBackgroundFr,
                    )
                  : controller.selectedIndex == 2
                      ? const AssetImage(ImageConstants.signupBackgroundAr)
                      : controller.selectedIndex == 3
                          ? const AssetImage(
                              ImageConstants.signupBackgroundEs,
                            )
                          : const AssetImage(
                              ImageConstants.signupBackgroundEn,
                            ),
              fit: BoxFit.cover,
            ),
          ),
          child: null,
        ),
      );
    });
  }
}

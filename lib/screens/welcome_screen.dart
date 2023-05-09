import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_languges/screens/profile/profile_screen.dart';
import 'package:multi_languges/utils/app_routes.dart';

import '../utils/constants/image_constants.dart';

class WelcomScreen extends StatelessWidget {
  const WelcomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Hero(
              tag: 'welcome-to-login',
              child: FadeInImage(
                placeholder: AssetImage(ImageConstants.gallery),
                image: AssetImage(ImageConstants.background),
              ),
            ),
            // Image.asset(
            //   ImageConstants.background,
            //   // height: MediaQuery.of(context).size.height * 0.5,
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "welcome_page_title".tr.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "welcome_page_subtitle".tr,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.grey.shade700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "welcome_page_subtitle_2".tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        textStyle: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Get.toNamed(AppRoutes.signinScreenRoute);
                      },
                      child: Text('login'.tr.toUpperCase()),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        textStyle: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Get.toNamed(AppRoutes.signupScreenRoute);
                      },
                      child: Text('signup'.tr.toUpperCase()),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

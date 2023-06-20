import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_delivery_express/controllers/auth/auth_controller.dart';
import 'package:food_delivery_express/utils/app_routes.dart';

import '../../square_tile.dart';
import '../../../utils/constants/image_constants.dart';

class LoginWith extends StatelessWidget {
  const LoginWith({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'or_continue_with'.tr,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        AuthController.instance.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        AuthController.instance.signUpWithGoogle();
                      },
                      child: const SquareTile(
                        imagePath: ImageConstants.google,
                      ),
                    ),
                    // const SizedBox(width: 25),
                    // GestureDetector(
                    //   onTap: () {
                    //     AuthController.instance.signUpWithFacebbok();
                    //   },
                    //   child: const SquareTile(
                    //     imagePath: ImageConstants.facebook,
                    //   ),
                    // ),
                  ],
                ),
              ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'already_a_member'.tr,
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(width: 4),
            InkWell(
              onTap: () {
                Get.offNamed(AppRoutes.signinScreenRoute);
              },
              child: Text(
                'login'.tr,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

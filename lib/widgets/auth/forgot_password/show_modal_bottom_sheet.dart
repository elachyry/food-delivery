import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_delivery_express/utils/app_routes.dart';
import './forget_password_button.dart';

Future<dynamic> showModalBottomSheetForgotPassword(BuildContext context) {
  return showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
    ),
    context: context,
    builder: (context) => Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: <Widget>[
          Text(
            'forgot_password_title'.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 33,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'forgot_password_subtitle'.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 30,
          ),
          ForgetPasswordButton(
            icon: Icons.email_outlined,
            title: 'email'.tr,
            subtitle: 'reset_vai_email'.tr,
            onTap: () {
              Navigator.of(context).pop();
              Get.toNamed(AppRoutes.restPasswordEmailScreenRoute);
            },
          ),
          const SizedBox(
            height: 15,
          ),
          // ForgetPasswordButton(
          //   icon: Icons.phone_android_rounded,
          //   title: 'phone_number'.tr,
          //   subtitle: 'reset_vai_phone'.tr,
          //   onTap: () {
          //     Navigator.of(context).pop();
          //     Get.toNamed(AppRoutes.restPasswordPhoneNumberScreenRoute);
          //   },
          // ),
        ],
      ),
    ),
  );
}

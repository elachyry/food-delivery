import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_delivery_express/controllers/auth/auth_controller.dart';
import 'package:food_delivery_express/models/user.dart';

import '../../utils/constants/image_constants.dart';
import '../../widgets/auth/forgot_password/otp_item.dart';

class OtpPhoneNumberScreen extends StatelessWidget {
  const OtpPhoneNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User user = Get.arguments;
    var otp;
    return Scaffold(
      body: SingleChildScrollView(
        child: OtpItem(
          image: ImageConstants.otpPhone,
          subTitle: 'Enter_the_verification_code_sent_at'.tr,
          title: 'verification_code'.tr,
          user: user,
          onPressed: () {
            AuthController.instance.verifyOTP(otp, user);
          },
          onSubmit: (verificationCode) {
            otp = verificationCode;
            AuthController.instance.verifyOTP(otp, user);
          },
        ),
      ),
    );
  }
}

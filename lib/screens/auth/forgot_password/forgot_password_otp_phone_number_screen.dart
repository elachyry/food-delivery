// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:multi_languges/controllers/auth/auth_controller.dart';

// import '../../../widgets/auth/forgot_password/otp_item.dart';
// import '../../../utils/constants/image_constants.dart';

// class ForgotPasswordOtpPhoneScreen extends StatelessWidget {
//   ForgotPasswordOtpPhoneScreen({super.key});
//   var otp;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: OtpItem(
//           image: ImageConstants.otpPhone,
//           subTitle: 'Enter_the_verification_code_sent_at'.tr,
//           title: 'verification_code'.tr,
//           onPressed: () {
//             AuthController.instance.resetPasswordWithPhoneNumberVerifyOTP(otp);
//           },
//           onSubmit: (verificationCode) {
//             otp = verificationCode;
//             AuthController.instance.resetPasswordWithPhoneNumberVerifyOTP(otp);
//           },
//         ),
//       ),
//     );
//   }
// }

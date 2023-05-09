// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:multi_languges/controllers/auth/auth_controller.dart';

// import '../../../utils/app_routes.dart';
// import '../../../widgets/auth/forgot_password/forgot_passwor_item.dart';

// class ForgotPasswordPhoneNumberScreen extends StatelessWidget {
//   ForgotPasswordPhoneNumberScreen({super.key});
//   final fieldController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: ForgotPasswordItem(
//             subTitle: 'forgot_password_phone_subtitle'.tr,
//             inputTitle: 'phone_number'.tr,
//             fieldController: fieldController,
//             icon: Icons.phone_android,
//             onPressed: () async {
//               final isPhoneAlreadyExist = await AuthController.instance
//                   .isPhoneAlreadyExist(fieldController.text.trim());
//               if (isPhoneAlreadyExist) {
//                 Get.toNamed(AppRoutes.forgotPasswordOtpPhoneScreenRoute);
//                 AuthController.instance.resetPasswordWithPhoneNumber(
//                     '+212${fieldController.text.trim()}');
//               } else {
//                 showSnackBarError(
//                     'error'.tr, 'no_account_exists_for_that_phone'.tr);
//               }
//             }),
//       ),
//     );
//   }
// }

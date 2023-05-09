// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../utils/constants/image_constants.dart';

// class ForgotPasswordItem extends StatelessWidget {
//   final String subTitle;
//   final String inputTitle;
//   final fieldController;
//   final icon;
//   final VoidCallback onPressed;

//   const ForgotPasswordItem({
//     super.key,
//     required this.subTitle,
//     required this.inputTitle,
//     required this.fieldController,
//     required this.icon,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height,
//       padding: const EdgeInsets.all(30),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const SizedBox(
//             height: 5,
//           ),
//           Container(
//             alignment: Alignment.center,
//             child: Image.asset(
//               ImageConstants.forgotPassword,
//               width: 150,
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Text(
//             'forgot_password'.tr,
//             style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 35,
//                 ),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(
//             height: 8,
//           ),
//           Text(
//             subTitle,
//             style: Theme.of(context).textTheme.titleMedium!.copyWith(),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Form(
//             child: Column(
//               children: <Widget>[
//                 Container(
//                   // padding: const EdgeInsets.all(5),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Theme.of(context)
//                             .primaryColorLight
//                             .withOpacity(0.1),
//                         blurRadius: 20.0,
//                         offset: const Offset(0, 10),
//                       )
//                     ],
//                   ),
//                   child: Container(
//                     padding: const EdgeInsets.all(8.0),
//                     decoration: BoxDecoration(
//                       border: Border(
//                         bottom: BorderSide(color: Colors.grey.shade100),
//                       ),
//                     ),
//                     child: TextFormField(
//                       controller: fieldController,
//                       decoration: InputDecoration(
//                         border: InputBorder.none,
//                         labelText: inputTitle,
//                         prefixIcon: Icon(icon),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 SizedBox(
//                   height: 50,
//                   width: MediaQuery.of(context).size.width,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor:
//                           Theme.of(context).primaryColor.withOpacity(0.8),
//                       textStyle: Theme.of(context)
//                           .textTheme
//                           .titleMedium!
//                           .copyWith(fontWeight: FontWeight.bold),
//                     ),
//                     onPressed: onPressed,
//                     child: Text(
//                       "next".tr,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

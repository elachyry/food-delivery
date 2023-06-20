import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_delivery_express/controllers/auth/auth_controller.dart';
import 'package:food_delivery_express/controllers/checkout_controller.dart';
import 'package:food_delivery_express/models/Address.dart';
import 'package:food_delivery_express/models/user.dart';

import '../../controllers/auth/user_controller.dart';

void showInputDialog(BuildContext context) {
  final checkoutController = Get.put(CheckoutController());
  final userController = Get.put(UserController());
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  showDialog(
    useSafeArea: true,
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 10), // Adjust the content padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Adjust the border radius
        ),
        title: Text(
          'add_new_address'.tr,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        content: Container(
          margin: const EdgeInsets.only(top: 20),
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Obx(
                      () => TextFormField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        controller: addressController,
                        decoration: InputDecoration(
                          suffixIcon: !checkoutController.isAddressClear.value
                              ? IconButton(
                                  onPressed: () {
                                    addressController.clear();
                                    checkoutController.isAddressClear.value =
                                        true;
                                  },
                                  icon: const Icon(
                                    Icons.clear,
                                  ),
                                )
                              : null,
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'address'.tr,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.black, width: 0.2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Address field can\'t be empty'.tr;
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (value.isEmpty) {
                            checkoutController.isAddressClear.value = true;
                          } else {
                            checkoutController.isAddressClear.value = false;
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Obx(
                      () => TextFormField(
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        controller: phoneController,
                        decoration: InputDecoration(
                          suffixIcon: !checkoutController.isPhoneClear.value
                              ? IconButton(
                                  onPressed: () {
                                    phoneController.clear();
                                    checkoutController.isPhoneClear.value =
                                        true;
                                  },
                                  icon: const Icon(
                                    Icons.clear,
                                  ),
                                )
                              : null,
                          filled: true,
                          prefix: const Text(
                            '+212',
                            style: TextStyle(color: Colors.black),
                          ),
                          fillColor: Colors.white,
                          hintText: 'phone_number'.tr,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.black, width: 0.2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                        ),
                        maxLength: 10,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'phone_field_cant_be_empty'.tr;
                          }
                          if (value.length < 9) {
                            return 'phone_is_to_short'.tr;
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (value.isEmpty) {
                            checkoutController.isPhoneClear.value = true;
                          } else {
                            checkoutController.isPhoneClear.value = false;
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => checkoutController.isLoading.value
                        ? const Center(
                            child: CircleAvatar(),
                          )
                        : Row(
                            children: [
                              Expanded(
                                flex: 7,
                                child: SizedBox(
                                  height: 50,
                                  child: TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(
                                      'cancel'.tr,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(
                                flex: 1,
                              ),
                              Expanded(
                                flex: 7,
                                child: SizedBox(
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        try {
                                          final List<Address> addresses = [];
                                          final addressData = userController
                                              .myData['addresses'];
                                          if (addressData != null) {
                                            for (var element in addressData) {
                                              addresses.add(
                                                  Address.fromMap(element));
                                            }
                                          }
                                          addresses.add(
                                            Address(
                                              id: DateTime.now().toString(),
                                              address: addressController.text,
                                              phoneNumber: phoneController.text,
                                            ),
                                          );
                                          final data = userController.myData;
                                          checkoutController.isLoading.value =
                                              true;
                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(AuthController.instance.auth
                                                  .currentUser!.uid)
                                              .update(User(
                                                      fullName:
                                                          data['fullName'],
                                                      email: data['email'],
                                                      phoneNumber:
                                                          data['phoneNumber'],
                                                      password:
                                                          data['password'],
                                                      addresses: addresses)
                                                  .toMap());
                                          Get.back();

                                          userController.getUserData();
                                          checkoutController.isLoading.value =
                                              false;
                                          // getUserData();
                                          userController.showSnackBarSuccess(
                                              'your_profile_has_been_updated'
                                                  .tr);
                                        } catch (e) {
                                          checkoutController.isLoading.value =
                                              false;
                                          // print('error $e');
                                          userController.showSnackBarError();
                                          rethrow;
                                        }
                                      }
                                    },
                                    child: Text(
                                      'save'.tr,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

// Future<dynamic> showModalBottomSheetAddAddress(BuildContext context) {
//   final checkoutController = Get.put(CheckoutController());
//   final addressController = TextEditingController();
//   final formKey = GlobalKey<FormState>();
//   return showModalBottomSheet(
//     context: context,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(25),
//         topRight: Radius.circular(25),
//       ),
//     ),
//     isScrollControlled: true,
//     builder: (context) => Container(
//       padding: EdgeInsets.only(
//         bottom: MediaQuery.of(context).viewInsets.bottom + 10,
//       ),
//       height: MediaQuery.of(context).size.height * 0.4,
//       child: Padding(
//         padding: const EdgeInsets.all(30),
//         child: Form(
//           key: formKey,
//           child: Column(
//             children: [
//               const Text(
//                 'Add new Address',
//                 style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               Container(
//                 padding: const EdgeInsets.only(
//                   right: 12,
//                 ),
//                 alignment: Alignment.center,
//                 child: Obx(
//                   () => TextFormField(
//                     keyboardType: TextInputType.text,
//                     textInputAction: TextInputAction.next,
//                     controller: addressController,
//                     decoration: InputDecoration(
//                       suffixIcon: !checkoutController.isAddressClear.value
//                           ? IconButton(
//                               onPressed: () {
//                                 addressController.clear();
//                                 checkoutController.isAddressClear.value = true;
//                               },
//                               icon: const Icon(
//                                 Icons.clear,
//                               ),
//                             )
//                           : null,
//                       filled: true,
//                       fillColor: Colors.white,
//                       hintText: 'Address'.tr,
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide:
//                             const BorderSide(color: Colors.black, width: 0.2),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: const BorderSide(color: Colors.white),
//                       ),
//                     ),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Address field can\'t be empty'.tr;
//                       }
//                       return null;
//                     },
//                     onChanged: (value) {
//                       if (value.isEmpty) {
//                         checkoutController.isAddressClear.value = true;
//                       } else {
//                         checkoutController.isAddressClear.value = false;
//                       }
//                     },
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 padding: const EdgeInsets.only(
//                   right: 12,
//                 ),
//                 alignment: Alignment.center,
//                 child: Obx(
//                   () => TextFormField(
//                     keyboardType: TextInputType.number,
//                     textInputAction: TextInputAction.done,
//                     controller: addressController,
//                     decoration: InputDecoration(
//                       suffixIcon: !checkoutController.isAddressClear.value
//                           ? IconButton(
//                               onPressed: () {
//                                 addressController.clear();
//                                 checkoutController.isAddressClear.value = true;
//                               },
//                               icon: const Icon(
//                                 Icons.clear,
//                               ),
//                             )
//                           : null,
//                       filled: true,
//                       prefix: const Text(
//                         '+212',
//                         style: TextStyle(color: Colors.black),
//                       ),
//                       fillColor: Colors.white,
//                       hintText: 'Phone number'.tr,
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide:
//                             const BorderSide(color: Colors.black, width: 0.2),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: const BorderSide(color: Colors.white),
//                       ),
//                     ),
//                     maxLength: 10,
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Phone number field can\'t be empty'.tr;
//                       }
//                       return null;
//                     },
//                     onChanged: (value) {
//                       if (value.isEmpty) {
//                         checkoutController.isAddressClear.value = true;
//                       } else {
//                         checkoutController.isAddressClear.value = false;
//                       }
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }

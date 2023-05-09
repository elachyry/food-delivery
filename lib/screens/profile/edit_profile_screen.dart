import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../widgets/profile/edit_profile_form.dart';
import '../../widgets/profile/edit_profile_header.dart';
import '../../controllers/auth/form_controller.dart';
import '../../controllers/auth/user_controller.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  var emailConroller = TextEditingController();
  var fullNameConroller = TextEditingController();
  var phoneNumberConroller = TextEditingController();
  var oldPasswordConroller = TextEditingController();
  var newPasswordConroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(FormController());
  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            userController.getUserData();
            Get.back();
          },
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          'edit_profile'.tr,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          if (userController.myData.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final data = userController.myData;
          fullNameConroller.text = data['fullName'];
          emailConroller.text = data['email'];
          phoneNumberConroller.text = data['phoneNumber'];
          Timestamp timestamp = data['createdAt'];
          DateTime cretedAt = timestamp.toDate();
          // print('full nmae ${data['fullName']}');
          return Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                EditProfileHeader(data: data),
                const SizedBox(
                  height: 15,
                ),
                const Divider(),
                const SizedBox(
                  height: 15,
                ),
                EditProfileForm(
                    formKey: _formKey,
                    fullNameConroller: fullNameConroller,
                    emailConroller: emailConroller,
                    phoneNumberConroller: phoneNumberConroller,
                    controller: controller,
                    oldPasswordConroller: oldPasswordConroller,
                    newPasswordConroller: newPasswordConroller,
                    data: data),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: 'joined'.tr,
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text:
                                '  ${DateFormat('MMM dd, yyyy').format(cretedAt)}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}

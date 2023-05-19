import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth/user_controller.dart';

import '../../controllers/auth/form_controller.dart';

class EditProfileForm extends StatelessWidget {
  EditProfileForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.fullNameConroller,
    required this.emailConroller,
    required this.phoneNumberConroller,
    required this.controller,
    required this.oldPasswordConroller,
    required this.newPasswordConroller,
    required this.data,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController fullNameConroller;
  final TextEditingController emailConroller;
  final TextEditingController phoneNumberConroller;
  final FormController controller;
  final TextEditingController oldPasswordConroller;
  final TextEditingController newPasswordConroller;
  final data;
  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Obx(
            () => Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColorLight.withOpacity(0.1),
                    blurRadius: 20.0,
                    offset: const Offset(0, 10),
                  )
                ],
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade100),
                      ),
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      controller: fullNameConroller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "full_name".tr,
                        prefixIcon: Icon(
                          Icons.person,
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'fullname_field_cant_be_empty'.tr;
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey.shade100))),
                    child: TextFormField(
                      enabled: false,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      controller: emailConroller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "email".tr,
                        prefixIcon: Icon(
                          Icons.email,
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'email_field_cant_be_empty'.tr;
                        }
                        if (!value.contains('@')) {
                          return 'email_is_not_valid_or_badly_formatted'.tr;
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade100),
                      ),
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      controller: phoneNumberConroller,
                      enabled: false,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "phone_number".tr,
                        prefixText: '+212',
                        prefixIcon: Icon(
                          Icons.phone_android_rounded,
                          color: Theme.of(context).primaryColorDark,
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
                    ),
                  ),
                  data['password'] == ''
                      ? Container()
                      : Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Obx(
                            () => TextFormField(
                              keyboardType: TextInputType.text,
                              obscureText: controller.isHidden.value,
                              textInputAction: TextInputAction.done,
                              controller: oldPasswordConroller,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.password,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                border: InputBorder.none,
                                labelText: "old_password".tr,
                                suffixIcon: InkWell(
                                  onTap: () {
                                    controller.isHidden.value =
                                        !controller.isHidden.value;
                                  },
                                  child: Icon(
                                    controller.isHidden.value
                                        ? Icons.visibility_rounded
                                        : Icons.visibility_off_rounded,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'old_password_field_cant_be_empty'.tr;
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                  data['password'] == ''
                      ? Container()
                      : Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('update_password'.tr),
                              Switch.adaptive(
                                value: userController.updatePassword.value,
                                activeColor: Theme.of(context).primaryColor,
                                onChanged: (value) {
                                  userController.updatePassword.value =
                                      !userController.updatePassword.value;
                                },
                              ),
                            ],
                          ),
                        ),
                  if (userController.updatePassword.value)
                    data['password'] == ''
                        ? Container()
                        : Container(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              obscureText: controller.isHidden2.value,
                              textInputAction: TextInputAction.done,
                              controller: newPasswordConroller,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.password,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                border: InputBorder.none,
                                labelText: "new_password".tr,
                                suffixIcon: InkWell(
                                  onTap: () {
                                    controller.isHidden2.value =
                                        !controller.isHidden2.value;
                                  },
                                  child: Icon(
                                    controller.isHidden2.value
                                        ? Icons.visibility_rounded
                                        : Icons.visibility_off_rounded,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (!userController.updatePassword.value) {
                                  return null;
                                }
                                if (value!.isEmpty) {
                                  return 'new_password_field_cant_be_empty'.tr;
                                }
                                if (value.length < 6) {
                                  return 'please_enter_a_strong_password'.tr;
                                }
                                return null;
                              },
                            ),
                          ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(
            () => SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: userController.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        textStyle: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (data['password'] != oldPasswordConroller.text) {
                            Get.snackbar(
                              'Error',
                              'old_password_is_incorrect'.tr,
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red.shade200,
                              colorText: Colors.red,
                              duration: const Duration(milliseconds: 1500),
                            );
                            return;
                          }
                          userController.updateUser({
                            "fullName": fullNameConroller.text,
                            "password": userController.updatePassword.value
                                ? newPasswordConroller.text
                                : data['password'],
                          });
                          Get.back();
                        }
                      },
                      child: Text(
                        "update".tr,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

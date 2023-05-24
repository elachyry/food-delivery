import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_languges/controllers/auth/auth_controller.dart';
import 'package:multi_languges/controllers/auth/form_controller.dart';
import 'package:multi_languges/models/user.dart';
import 'package:multi_languges/utils/app_routes.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var emailConroller = TextEditingController();
    var fullNameConroller = TextEditingController();
    var phoneNumberConroller = TextEditingController();
    var passwordConroller = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final controller = Get.put(FormController());

    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          Container(
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
            child: Obx(
              () => Column(
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
                      onChanged: (value) {
                        if (fullNameConroller.text.isNotEmpty) {
                          controller.isCleanFullName.value = false;
                        } else {
                          controller.isCleanFullName.value = true;
                        }
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "full_name".tr,
                        suffixIcon: controller.isCleanFullName.value
                            ? null
                            : IconButton(
                                onPressed: () {
                                  fullNameConroller.clear();
                                  controller.isCleanFullName.value = true;
                                },
                                icon: Icon(
                                  Icons.clear_rounded,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
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
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      controller: emailConroller,
                      onChanged: (value) {
                        if (emailConroller.text.isNotEmpty) {
                          controller.isCleanEmail.value = false;
                        } else {
                          controller.isCleanEmail.value = true;
                        }
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "email".tr,
                        suffixIcon: controller.isCleanEmail.value
                            ? null
                            : IconButton(
                                onPressed: () {
                                  emailConroller.clear();
                                  controller.isCleanEmail.value = true;
                                },
                                icon: Icon(
                                  Icons.clear_rounded,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
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
                      onChanged: (value) {
                        if (phoneNumberConroller.text.isNotEmpty) {
                          controller.isCleanPhone.value = false;
                        } else {
                          controller.isCleanPhone.value = true;
                        }
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "phone_number".tr,
                        suffixIcon: controller.isCleanPhone.value
                            ? null
                            : IconButton(
                                onPressed: () {
                                  phoneNumberConroller.clear();
                                  controller.isCleanPhone.value = true;
                                },
                                icon: Icon(
                                  Icons.clear_rounded,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
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
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      obscureText: controller.isHidden.value,
                      textInputAction: TextInputAction.done,
                      controller: passwordConroller,
                      onChanged: (value) {
                        if (passwordConroller.text.isNotEmpty) {
                          controller.isCleanPassword.value = false;
                        } else {
                          controller.isCleanPassword.value = true;
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.password,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        border: InputBorder.none,
                        labelText: "password".tr,
                        suffixIcon: controller.isCleanPassword.value
                            ? null
                            : InkWell(
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
                          return 'password_field_cant_be_empty'.tr;
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
              child: AuthController.instance.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).primaryColor.withOpacity(0.8),
                        textStyle: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          // AuthController.instance.createUserWithEmailAndPassword(
                          //   emailConroller.text.trim().toLowerCase(),
                          //   passwordConroller.text.trim(),
                          // );
                          final isEmailAlreadyExist =
                              await AuthController.instance.isEmailAlreadyExist(
                                  emailConroller.text.toLowerCase().trim());

                          final isPhoneAlreadyExist =
                              await AuthController.instance.isPhoneAlreadyExist(
                                  phoneNumberConroller.text.trim());

                          if (isEmailAlreadyExist) {
                            showSnackBarError('signup_failed'.tr,
                                'an_account_already_exists_for_that_email'.tr);
                            return;
                          }

                          if (isPhoneAlreadyExist) {
                            showSnackBarError('signup_failed'.tr,
                                'an_account_already_exists_for_that_phone'.tr);
                            return;
                          }
                          final user = User(
                            fullName: fullNameConroller.text.trim(),
                            email: emailConroller.text.toLowerCase().trim(),
                            phoneNumber: phoneNumberConroller.text.trim(),
                            password: passwordConroller.text,
                          );
                          Get.toNamed(AppRoutes.otpPhoneNumberScreenRoute,
                              arguments: user);
                          AuthController.instance.phoneAuth(
                            '+212${phoneNumberConroller.text.trim()}',
                            user,
                          );
                        }
                      },
                      child: Text(
                        "signup".tr,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

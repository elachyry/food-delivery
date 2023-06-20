import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_delivery_express/controllers/auth/auth_controller.dart';
import 'package:food_delivery_express/controllers/auth/form_controller.dart';

import '../forgot_password/show_modal_bottom_sheet.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var emailConroller = TextEditingController();
    var passwordConroller = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final controller = Get.put(FormController());
    return Obx(
      () => Form(
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
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  showModalBottomSheetForgotPassword(context);
                },
                child: Text(
                  "forgot_password".tr,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor.withOpacity(0.9),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            AuthController.instance.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).primaryColor.withOpacity(0.8),
                        textStyle: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          // SignUpController.instance.registerUser(
                          //   controller.email.text.trim().toLowerCase(),
                          //   controller.password.text.trim(),
                          // );

                          AuthController.instance.loginWithEmailAndPassword(
                            emailConroller.text.trim(),
                            passwordConroller.text,
                          );
                        }
                      },
                      child: Text(
                        "login".tr,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

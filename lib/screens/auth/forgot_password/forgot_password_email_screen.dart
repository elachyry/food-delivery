import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_languges/controllers/auth/auth_controller.dart';
import 'package:multi_languges/utils/constants/image_constants.dart';

class ForgotPasswordEmailScreen extends StatelessWidget {
  ForgotPasswordEmailScreen({super.key});
  final fieldController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 5,
              ),
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  ImageConstants.forgotPassword,
                  width: 150,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'forgot_password'.tr,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'forgot_password_email_subtitle'.tr,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      // padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context)
                                .primaryColorLight
                                .withOpacity(0.1),
                            blurRadius: 20.0,
                            offset: const Offset(0, 10),
                          )
                        ],
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.shade100),
                          ),
                        ),
                        child: TextFormField(
                          controller: fieldController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'email_field_cant_be_empty'.tr;
                            }
                            if (!value.contains('@')) {
                              return 'email_is_not_valid_or_badly_formatted'.tr;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'email'.tr,
                            prefixIcon: const Icon(Icons.email),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
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
                                  backgroundColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.8),
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    AuthController.instance.resetPassword(
                                        fieldController.text
                                            .toLowerCase()
                                            .trim());
                                    Get.back();
                                  }
                                },
                                child: Text(
                                  "next".tr,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_delivery_express/controllers/auth/auth_controller.dart';
import 'package:food_delivery_express/controllers/auth/user_controller.dart';
import 'package:food_delivery_express/utils/app_routes.dart';

class PhoneNumberScreen extends StatelessWidget {
  PhoneNumberScreen({super.key});
  final fieldController = TextEditingController();
  final usercontroller = Get.put(UserController());

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
                child: const Icon(
                  Icons.phone_android_rounded,
                  size: 150,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'enter_your_phone_number'.tr,
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
                'provide_your_phone_number_to_link_it_with_you_account'.tr,
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
                              return 'phone_field_cant_be_empty'.tr;
                            }
                            if (value.length < 10) {
                              return 'phone_is_not_valid_or_badly_formatted'.tr;
                            }
                            return null;
                          },
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'phone_number'.tr,
                            prefixIcon: const Icon(Icons.phone_android),
                            prefixText: '+212',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Obx(
                      () => usercontroller.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : SizedBox(
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
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          final isPhoneAlreadyExist =
                                              await AuthController.instance
                                                  .isPhoneAlreadyExist(
                                                      fieldController.text);
                                          print(
                                              'phone ${fieldController.text}');
                                          print(
                                              'isPhoneAlreadyExist ${isPhoneAlreadyExist}');
                                          if (isPhoneAlreadyExist) {
                                            showSnackBarError(
                                                'error'.tr,
                                                'an_account_already_exists_for_that_phone'
                                                    .tr);
                                            return;
                                          }
                                          usercontroller.addPhoneNumber(
                                              fieldController.text);
                                          Get.offAllNamed(
                                              AppRoutes.tabsScreenRoute);
                                        }
                                      },
                                      child: Text(
                                        "save".tr,
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

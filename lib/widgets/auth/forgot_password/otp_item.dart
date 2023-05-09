import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:multi_languges/controllers/auth/auth_controller.dart';
import 'package:multi_languges/models/user.dart';

class OtpItem extends StatelessWidget {
  final String image;
  final String subTitle;
  final String title;
  final User? user;
  final VoidCallback onPressed;
  final Function onSubmit;

  const OtpItem({
    super.key,
    required this.image,
    required this.subTitle,
    required this.title,
    required this.onSubmit,
    required this.onPressed,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
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
                image,
                width: 150,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              subTitle,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              'mohammedelachyry@gmail.com',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 40,
            ),
            Column(
              children: <Widget>[
                OtpTextField(
                  filled: true,
                  numberOfFields: 6,
                  borderWidth: 1.0,
                  borderRadius: BorderRadius.circular(10),
                  fieldWidth: 45,
                  showFieldAsBox: true,
                  focusedBorderColor: Theme.of(context).primaryColorLight,
                  // onCodeChanged: (String code) {
                  //   otp = code;
                  // },
                  onSubmit: (String verificationCode) {
                    onSubmit(verificationCode);
                  }, // end onSubmit
                ),
                const SizedBox(
                  height: 40,
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
                          onPressed: onPressed,
                          child: Text(
                            "next".tr,
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_routes.dart';
import '../utils/constants/image_constants.dart';
import '../widgets/language_item.dart';
import '../controllers/language_controller.dart';

class LanguageSelectionScreen extends StatelessWidget {
  var firstTime = true;
  LanguageSelectionScreen({
    super.key,
    required this.firstTime,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<LocalizationController>(
          builder: (controller) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(5),
                        child: Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                  child: Image.asset(
                                    ImageConstants.deliveryOutline,
                                    width: 190,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Center(
                                  child: Image.asset(ImageConstants.logo,
                                      width: 190),
                                ),
                                const SizedBox(
                                  height: 35,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    'select_a_language'.tr,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                GridView.builder(
                                  itemCount: controller.languages.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1.2,
                                  ),
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => LanguageItem(
                                      language: controller.languages[index],
                                      localizationController: controller,
                                      index: index),
                                ),
                                !firstTime
                                    ? Container()
                                    : Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 15),
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              elevation: 5,
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium),
                                          onPressed: () {
                                            Get.offNamed(AppRoutes
                                                .onBoardingScreenRoute);
                                            // Navigator.of(context)
                                            //     .push(MaterialPageRoute(
                                            //   builder: (context) =>
                                            //       OnBoardingScreen(),
                                            // ));
                                          },
                                          child: Text('continue'.tr),
                                        ),
                                      ),
                                const SizedBox(
                                  height: 5,
                                ),
                                !firstTime
                                    ? Container()
                                    : Text('you_can_cahnge_your_language'.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

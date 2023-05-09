import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

import '../../controllers/auth/user_controller.dart';
import '../../widgets/profile/image_modal_sheet_item.dart';

Future<dynamic> selectImageModalBottomSheet(BuildContext context) {
  final userController = Get.put(UserController());

  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
    ),
    builder: (context) => Container(
      height: 350,
      padding: const EdgeInsets.all(30),
      child: Column(
        children: <Widget>[
          Text(
            'upload_image'.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 33,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              InkWell(
                onTap: () {
                  userController.selectImage(ImageSource.camera).then((value) {
                    // userController.isImageSelected.value = true;
                    Get.back();

                    userController.updateField();
                  });
                },
                child: ImageModalSheetItem(
                  title: 'take_picture'.tr,
                  icon: Icons.camera_alt_outlined,
                ),
              ),
              InkWell(
                onTap: () {
                  userController.selectImage(ImageSource.gallery).then((value) {
                    // userController.isImageSelected.value = true;
                    Get.back();

                    userController.updateField();
                  });
                },
                child: ImageModalSheetItem(
                  title: 'select_from_gallery'.tr,
                  icon: Icons.photo_library_sharp,
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

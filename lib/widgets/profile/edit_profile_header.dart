import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_languges/controllers/auth/user_controller.dart';

import '../../widgets/profile/select_image_modal_bottom_sheet.dart';
import '../../utils/constants/image_constants.dart';

class EditProfileHeader extends StatelessWidget {
  final userController = Get.put(UserController());
  final data;
  EditProfileHeader({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          userController.isImageUpdating.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: userController.isImageSelected.value
                        ? Image.file(userController.image.value!)
                        : data['userImage'] == ''
                            ? Image.asset(
                                ImageConstants.user,
                                fit: BoxFit.fill,
                              )
                            : FadeInImage(
                                placeholder:
                                    const AssetImage(ImageConstants.user),
                                image: NetworkImage(
                                  data['userImage'],
                                ),
                              ),
                  ),
                ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Theme.of(context).primaryColorDark),
              child: IconButton(
                onPressed: () {
                  selectImageModalBottomSheet(context);
                },
                icon: const Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

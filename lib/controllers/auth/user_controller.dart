import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_languges/utils/app_routes.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../models/user.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final firestore = FirebaseFirestore.instance;
  final firestorage = FirebaseStorage.instance;

  var myData = {}.obs;
  Rxn<File> _image = Rxn<File>();

  var isImageSelected = false.obs;
  var isImageUpdating = false.obs;
  var updatePassword = false.obs;
  var isLoading = false.obs;

  Rxn<File> get image => _image;

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  Future<void> createUser(User user) async {
    await firestore
        .collection('users')
        .doc(AuthController.instance.auth.currentUser!.uid)
        .set(
          user.toJson(),
        )
        .whenComplete(
            () => showSnackBarSuccess('your_account_has_been_created'.tr))
        .catchError((error, stackTrace) {
      showSnackBarError();
    });
  }

  Future<void> selectImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
      imageQuality: 60,
      maxWidth: 200,
    );
    if (pickedFile != null) {
      isImageSelected.value = true;

      _image.value = File(pickedFile.path);
      update();
    }
  }

  void getUserData() async {
    final DocumentSnapshot snapshot = await firestore
        .collection('users')
        .doc(AuthController.instance.auth.currentUser!.uid)
        .get();
    if (snapshot.exists) {
      myData.value = snapshot.data() as Map<dynamic, dynamic>;
      if (myData['phoneNumber'] == '') {
        Get.offAllNamed(AppRoutes.phoneNumberScreenRoute);
      }
    }
  }

  Future<void> updateField() async {
    try {
      if (image.value == null) {
        return;
      }
      isImageUpdating.value = true;
      final ref = firestorage
          .ref()
          .child('user_images')
          .child('${AuthController.instance.auth.currentUser!.uid}.jpg');

      await ref.putFile(image.value as File);

      final url = await ref.getDownloadURL();

      await firestore
          .collection('users')
          .doc(AuthController.instance.auth.currentUser!.uid)
          .update({
        'userImage': url,
      });
      isImageUpdating.value = false;

      showSnackBarSuccess('your_image_has_been_updated'.tr);
    } catch (e) {
      isImageUpdating.value = false;

      showSnackBarError();
    }
  }

  Future<void> addPhoneNumber(String phone) async {
    try {
      isLoading.value = true;
      await firestore
          .collection('users')
          .doc(AuthController.instance.auth.currentUser!.uid)
          .update({
        'phoneNumber': phone,
      });
      getUserData();
      isLoading.value = false;

      showSnackBarSuccess('your_phone_number_has_been_added'.tr);
    } catch (e) {
      isLoading.value = false;

      showSnackBarError();
    }
  }

  SnackbarController showSnackBarSuccess(String message) {
    return Get.snackbar(
      'success'.tr,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade500,
      colorText: Colors.white,
      duration: const Duration(milliseconds: 1500),
    );
  }

  SnackbarController showSnackBarError() {
    return Get.snackbar(
      'error'.tr,
      'an_error_occurred_please_try_again_later'.tr,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade500,
      colorText: Colors.white,
      duration: const Duration(milliseconds: 1500),
    );
  }

  Future<void> updateUser(Map<String, dynamic> data) async {
    isLoading.value = true;
    try {
      await firestore
          .collection('users')
          .doc(AuthController.instance.auth.currentUser!.uid)
          .update(data);
      isLoading.value = false;
      getUserData();
      showSnackBarSuccess('your_profile_has_been_updated'.tr);
    } catch (e) {
      isLoading.value = false;
      showSnackBarError();
    }
  }
}

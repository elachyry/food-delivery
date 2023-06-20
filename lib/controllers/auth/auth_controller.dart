import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../controllers/auth/user_controller.dart';
import '../../exceptions/signup_with_email_and_password_exception.dart';
import '../../exceptions/signin_with_email_and_password_exception.dart';
import '../../models/user.dart' as modals;

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  final userController = Get.put(UserController());
  final auth = FirebaseAuth.instance;
  late final Rx<User?> _firebaseUser;
  final firestore = FirebaseFirestore.instance;

  var verficationId = ''.obs;
  var isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();

    _firebaseUser = Rx<User?>(auth.currentUser);
    _firebaseUser.bindStream(auth.userChanges());
    // ever(_firebaseUser, _initialScreen);
  }

  // void _initialScreen(User? user) {
  //   if (user == null) {
  //     Get.offAllNamed(AppRoutes.welecomeScreenRoute);
  //   } else {
  //     Get.offAllNamed(AppRoutes.tabsScreenRoute);
  //   }
  // }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      isLoading.value = true;
      await auth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => Get.back());
      isLoading.value = false;
    } on FirebaseAuthException catch (error) {
      User user = auth.currentUser as User;
      await user.delete();
      isLoading.value = false;
      final exception = SignUpWithEmailAndPasswordException.code(error.code);
      showSnackBarError('signup_failed'.tr, exception.toString());

      throw exception;
    } catch (error) {
      User user = auth.currentUser as User;
      await user.delete();
      isLoading.value = false;
      final exception = SignUpWithEmailAndPasswordException();
      showSnackBarError('signup_failed'.tr, exception.toString());
      throw exception;
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      isLoading.value = true;
      await auth
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => Get.back());
      userController.getUserData();
      isLoading.value = false;
    } on FirebaseAuthException catch (error) {
      isLoading.value = false;
      final exception = SignInWithEmailAndPasswordException.code(error.code);
      showSnackBarError('login_failed'.tr, exception.toString());
      throw exception;
    } catch (error) {
      isLoading.value = false;
      final exception = SignInWithEmailAndPasswordException();
      showSnackBarError('login_failed'.tr, exception.toString());

      throw exception;
    }
  }

  void phoneAuth(String phoneNumber, modals.User user) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(minutes: 1),
      verificationCompleted: (phoneAuthCredential) async {
        await auth.signInWithCredential(phoneAuthCredential).then(
          (value) async {
            createUserWithEmailAndPassword(
              user.email.toString(),
              user.password.toString(),
            ).then((value) {
              userController.createUser(user);
              userController.getUserData();
            });
          },
        );
      },
      verificationFailed: (error) {
        if (error.code == 'invalid-phone-number') {
          Get.snackbar(
            'Error',
            'the_provided_phone_number_is_not_valid'.tr,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.shade200,
            colorText: Colors.red,
            duration: const Duration(milliseconds: 1500),
          );
        } else {
          Get.snackbar(
            'Error',
            'an_error_occurred_please_try_again_later'.tr,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.shade200,
            colorText: Colors.red,
            duration: const Duration(milliseconds: 1500),
          );
        }
      },
      codeSent: (verificationId, forceResendingToken) {
        verficationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        verficationId.value = verificationId;
      },
    );
  }

  Future<void> verifyOTP(String otp, modals.User user) async {
    try {
      isLoading.value = true;
      await auth
          .signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verficationId.value, smsCode: otp),
      )
          .then((value) async {
        createUserWithEmailAndPassword(
          user.email.toString(),
          user.password.toString(),
        ).then((value) {
          userController.createUser(user);
          userController.getUserData();
        });
      });
      isLoading.value = false;
    } on FirebaseAuthException catch (_) {
      isLoading.value = false;
    } catch (error) {
      isLoading.value = false;
    }
  }

  Future<bool> isEmailAlreadyExist(String email) async {
    try {
      isLoading.value = true;
      final result = await auth.fetchSignInMethodsForEmail(email);
      isLoading.value = false;

      return result.isNotEmpty;
    } catch (error) {
      isLoading.value = false;

      // print('Error checking email: $error');
      return false;
    }
  }

  Future<bool> isEmailAlreadyExist2(String email) async {
    try {
      // print('email2 $email');
      final result = await firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      isLoading.value = false;
      // print('email3 ${result.docs.first['email']}');
      return result.docs.isNotEmpty;
    } catch (error) {
      isLoading.value = false;

      // print('Error checking field: $error');
      return false;
    }
  }

  Future<bool> isPhoneAlreadyExist(String phone) async {
    isLoading.value = true;

    try {
      final result = await firestore
          .collection('users')
          .where('phoneNumber', isGreaterThanOrEqualTo: phone)
          .get();
      isLoading.value = false;
      print('result ${result.docs.first['phoneNumber']}');
      if (result.docs.isNotEmpty) {
        if (result.docs.first['phoneNumber'] == phone) {
          return true;
        } else {
          return false;
        }
      }
      return false;
    } catch (error) {
      isLoading.value = false;

      // print('Error checking field: $error');
      return false;
    }
  }

  Future<void> logout() async {
    await auth.signOut();
  }

  void resetPasswordWithPhoneNumber(String phoneNumber) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(minutes: 1),
      verificationCompleted: (phoneAuthCredential) async {
        await auth.signInWithCredential(phoneAuthCredential).then(
          (value) async {
            userController.getUserData();
          },
        );
      },
      verificationFailed: (error) {
        if (error.code == 'invalid-phone-number') {
          Get.snackbar(
            'Error',
            'the_provided_phone_number_is_not_valid'.tr,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.shade200,
            colorText: Colors.red,
            duration: const Duration(milliseconds: 1500),
          );
        } else {
          Get.snackbar(
            'Error',
            'an_error_occurred_please_try_again_later'.tr,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.shade200,
            colorText: Colors.red,
            duration: const Duration(milliseconds: 1500),
          );
        }
      },
      codeSent: (verificationId, forceResendingToken) {
        verficationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        verficationId.value = verificationId;
      },
    );
  }

  Future<void> resetPasswordWithPhoneNumberVerifyOTP(String otp) async {
    try {
      isLoading.value = true;
      await auth
          .signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verficationId.value, smsCode: otp),
      )
          .then((value) async {
        userController.getUserData();
      });
      isLoading.value = false;
    } on FirebaseAuthException catch (_) {
      isLoading.value = false;
    } catch (error) {
      isLoading.value = false;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      isLoading.value = true;
      await auth.sendPasswordResetEmail(email: email);
      isLoading.value = false;

      Get.snackbar(
        'Password reset email sent',
        'Please check your email to reset your password',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(milliseconds: 1500),
      );
    } catch (error) {
      isLoading.value = false;

      if (error is FirebaseAuthException) {
        Get.snackbar(
          'Error sending password reset email',
          error.message ?? 'An unknown error occurred',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(milliseconds: 1500),
        );
      }
      // print('Error sending password reset email: $error');
    }
  }

  // signUpWithFacebbok() async {
  //   try {
  //     isLoading.value = true;
  //     final LoginResult facebookUser = await FacebookAuth.instance.login();

  //     final userData = await FacebookAuth.instance.getUserData(
  //       fields: 'email,name',
  //     );
  //     final OAuthCredential facebookAuthCredential =
  //         FacebookAuthProvider.credential(facebookUser.accessToken!.token);

  //     final name = userData['name'];
  //     final email = userData['email'];
  //     // Once signed in, return the UserCredential
  //     FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  //     final isEmailAlreadyExist =
  //         await AuthController.instance.isEmailAlreadyExist(email);
  //     if (!isEmailAlreadyExist) {
  //       userController.createUser(Modals.User(
  //           fullName: name, email: email, phoneNumber: '', password: ''));
  //     }

  //     userController.getUserData();
  //     isLoading.value = false;
  //   } on FirebaseAuthException catch (error) {
  //     Get.snackbar(
  //       'Error signing in with Facebook',
  //       error.message ?? 'An unknown error occurred',
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red.shade500,
  //       colorText: Colors.white,
  //     );
  //   } catch (error) {
  //     showSnackBarError(
  //         'error'.tr, 'an_error_occurred_please_try_again_later'.tr);
  //     isLoading.value = false;
  //   }
  // }

  signUpWithGoogle() async {
    try {
      isLoading.value = true;
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: <String>['email'],
      ).signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await auth.signInWithCredential(credential);
      // print('email ${googleUser.email}');
      final isEmailAlreadyExist =
          await AuthController.instance.isEmailAlreadyExist2(googleUser.email);
      // print('isEmailAlreadyExist $isEmailAlreadyExist');
      if (!isEmailAlreadyExist) {
        userController.createUser(modals.User(
            fullName: googleUser.displayName,
            email: googleUser.email,
            phoneNumber: '',
            password: ''));
      }

      userController.getUserData();

      isLoading.value = false;
    } on FirebaseAuthException catch (error) {
      Get.snackbar(
        'Error signing in with Google',
        error.message ?? 'An unknown error occurred',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(milliseconds: 1500),
      );
    } catch (error) {
      showSnackBarError(
          'error'.tr, 'an_error_occurred_please_try_again_later'.tr);
      isLoading.value = false;
    }
  }
}

void showSnackBarError(String titleText, String messageText) {
  Get.snackbar(titleText, messageText,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade500,
      colorText: Colors.white,
      duration: const Duration(milliseconds: 1500));
}

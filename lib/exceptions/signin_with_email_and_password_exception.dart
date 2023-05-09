import 'package:get/get.dart';

class SignInWithEmailAndPasswordException implements Exception {
  final String message;

  SignInWithEmailAndPasswordException([
    this.message = '',
  ]);

  factory SignInWithEmailAndPasswordException.code(String code) {
    switch (code) {
      case 'wrong-password':
        return SignInWithEmailAndPasswordException(
            'the_password_is_invalid_for_the_given_email'.tr);
      case 'invalid-email':
        return SignInWithEmailAndPasswordException(
            'email_is_not_valid_or_badly_formatted'.tr);
      case 'user-disabled':
        return SignInWithEmailAndPasswordException(
            'this_user_has_been_disabled_please_contact_support_for_help'.tr);
      case 'user-not-found':
        return SignInWithEmailAndPasswordException(
            'no_user_corresponding_to_the_given_email'.tr);

      default:
        return SignInWithEmailAndPasswordException(
            'an_error_occurred_please_try_again_later'.tr);
    }
  }

  @override
  String toString() {
    return message;
  }
}

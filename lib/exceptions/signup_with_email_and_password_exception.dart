import 'package:get/get.dart';

class SignUpWithEmailAndPasswordException implements Exception {
  final String message;

  SignUpWithEmailAndPasswordException([
    this.message = '',
  ]);

  factory SignUpWithEmailAndPasswordException.code(String code) {
    switch (code) {
      case 'weak-password':
        return SignUpWithEmailAndPasswordException(
            'please_enter_a_strong_password'.tr);
      case 'invalid-email':
        return SignUpWithEmailAndPasswordException(
            'email_is_not_valid_or_badly_formatted'.tr);
      case 'email-already-in-use':
        return SignUpWithEmailAndPasswordException(
            'an_account_already_exists_for_that_email'.tr);
      case 'operation-not-allowed':
        return SignUpWithEmailAndPasswordException(
            'operation_is_not_allowed_please_contact_support'.tr);
      case 'user-disabled':
        return SignUpWithEmailAndPasswordException(
            'this_user_has_been_disabled_please_contact_support_for_help'.tr);
      default:
        return SignUpWithEmailAndPasswordException(
            'an_error_occurred_please_try_again_later'.tr);
    }
  }

  @override
  String toString() {
    return message;
  }
}

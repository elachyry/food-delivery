import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? id;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? password;
  final String? userImage;

  User({
    this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    this.userImage = '',
  });

  toJson() {
    return {
      "fullName": fullName,
      "email": email,
      "phoneNumber": phoneNumber,
      "password": password,
      "userImage": userImage,
      "createdAt": Timestamp.now(),
    };
  }
}

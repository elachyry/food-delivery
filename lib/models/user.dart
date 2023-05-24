import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multi_languges/models/place.dart';

class User {
  final String? id;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? password;
  final String? userImage;
  final List<Place> addresses;
  final List<String> favoriteRestaurants;
  final List<String> favoriteMenuItems;

  User({
    this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    this.addresses = const [],
    this.favoriteRestaurants = const [],
    this.favoriteMenuItems = const [],
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
      "addresses": addresses,
      "favoriteRestaurants": favoriteRestaurants,
      "favoriteMenuItems": favoriteMenuItems
    };
  }
}

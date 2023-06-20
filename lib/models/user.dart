// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'Address.dart';

class User {
  final String? id;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? password;
  final String? userImage;
  final List<Address> addresses;
  final List<String> favoriteRestaurants;
  final List<String> favoriteMenuItems;

  User({
    this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    this.userImage = '',
    this.addresses = const [],
    this.favoriteRestaurants = const [],
    this.favoriteMenuItems = const [],
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

  User copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? password,
    String? userImage,
    List<Address>? addresses,
    List<String>? favoriteRestaurants,
    List<String>? favoriteMenuItems,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      userImage: userImage ?? this.userImage,
      addresses: addresses ?? this.addresses,
      favoriteRestaurants: favoriteRestaurants ?? this.favoriteRestaurants,
      favoriteMenuItems: favoriteMenuItems ?? this.favoriteMenuItems,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'userImage': userImage,
      'addresses': addresses.map((x) => x.toMap()).toList(),
      'favoriteRestaurants': favoriteRestaurants,
      'favoriteMenuItems': favoriteMenuItems,
    };
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fullName.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        password.hashCode ^
        userImage.hashCode ^
        addresses.hashCode ^
        favoriteRestaurants.hashCode ^
        favoriteMenuItems.hashCode;
  }
}

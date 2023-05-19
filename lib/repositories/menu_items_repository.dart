import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth/auth_controller.dart';
import '../models/menu_item.dart';

class MenuItemsRepository extends GetxService {
  // final CollectionReference _restaurantsCollection =
  //     FirebaseFirestore.instance.collection('restaurants');

  // Future<List<String>> getAllRestaurantIds() async {
  //   final querySnapshot = await _restaurantsCollection.get();
  //   return querySnapshot.docs.map((doc) => doc.id).toList();
  // }

  // Future<List<MenuItem>> getMenuItemsForRestaurant(String restaurantId) async {
  //   final querySnapshot = await _restaurantsCollection
  //       .doc(restaurantId)
  //       .collection('items')
  //       .get();

  //   return querySnapshot.docs
  //       .map((doc) => MenuItem.fromFirestore(doc))
  //       .toList();
  // }
  List<String> restaurantIds = [];

  final CollectionReference _restaurantCollection =
      FirebaseFirestore.instance.collection('restaurants');

  Future<void> getAllRestaurantIds() async {
    final querySnapshot = await _restaurantCollection.get();
    restaurantIds = querySnapshot.docs.map((doc) => doc.id).toList();
  }

  Stream<List<MenuItem>> getMenuItemsForRestaurant(String restaurantId) {
    // final querySnapshot =
    //     await _restaurantCollection.doc(restaurantId).collection('items').get();
    //     return querySnapshot.docs
    //     .map((doc) => MenuItem.fromFirestore(doc))
    //     .toList();
    print('test ');

    return FirebaseFirestore.instance
        .collection('menuItems')
        .doc(restaurantId)
        .collection('items')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        // print('test ${MenuItem.fromFirestore(doc)}');
        return MenuItem.fromFirestore(doc);
      }).toList();
    });
  }

  Stream<List<MenuItem>> getMenuItems() {
    // print('test1 ');

    List<MenuItem> menuItems = [];
    getAllRestaurantIds();
    return _restaurantCollection.snapshots().map((snapshot) {
      // print('test2 ');
      // print('rst $restaurantIds');
      for (var element in restaurantIds) {
        // print('test3 ');

        getMenuItemsForRestaurant(element).listen((event) {
          menuItems.addAll(event);
        });
      }
      return menuItems;
    });
  }

  void showSnackBar(String titleText, String messageText, Color color) {
    Get.snackbar(titleText, messageText,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: color,
        colorText: Colors.white,
        duration: const Duration(milliseconds: 2000));
  }
}

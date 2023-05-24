import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:multi_languges/models/restaurant.dart';

class RestaurantRepository extends GetxController {
  // CollectionReference _restaurantCollection =
  //     FirebaseFirestore.instance.collection('restaurants');

  // Stream<QuerySnapshot> getRatingStream() {
  //   return _restaurantCollection.snapshots();
  // }

  // Future<List<Restaurant>> getRestaurants() async {
  //   try {
  //     CollectionReference _restaurantCollection =
  //         FirebaseFirestore.instance.collection('restaurants');

  //     QuerySnapshot querySnapshot = await _restaurantCollection.get();

  //     // QuerySnapshot querySnapshot =
  //     //     await _firestore.collection('menuItems').get();
  //     List<Restaurant> restaurants = [];
  //     querySnapshot.docs.forEach((doc) {
  //       restaurants.add(Restaurant.fromFirestore(doc));
  //       // print('rating ${Rating.fromFirestore(doc)}');
  //     });
  //     // print('ratings $ratings');
  //     return restaurants;
  //   } catch (e) {
  //     print('Error getting restaurants: $e');
  //     return [];
  //   }
  // }

  final CollectionReference _restaurantCollection =
      FirebaseFirestore.instance.collection('restaurants');

  Stream<List<Restaurant>> getRestaurants() {
    return _restaurantCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Restaurant.fromFirestore(doc);
      }).toList();
    });
  }
}

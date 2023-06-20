import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:food_delivery_express/models/restaurant.dart';

class RestaurantRepository extends GetxController {
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

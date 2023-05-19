import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/rating.dart';

class RatingRepository extends GetxController {
  CollectionReference _ratingCollection =
      FirebaseFirestore.instance.collection('ratings');

  Stream<QuerySnapshot> getRatingStream() {
    return _ratingCollection.snapshots();
  }

  Future<List<Rating>> getRatings() async {
    try {
      CollectionReference _ratingCollection =
          FirebaseFirestore.instance.collection('ratings');

      QuerySnapshot querySnapshot = await _ratingCollection.get();

      // QuerySnapshot querySnapshot =
      //     await _firestore.collection('menuItems').get();
      List<Rating> ratings = [];
      querySnapshot.docs.forEach((doc) {
        ratings.add(Rating.fromFirestore(doc));
        // print('rating ${Rating.fromFirestore(doc)}');
      });
      // print('ratings $ratings');
      return ratings;
    } catch (e) {
      print('Error getting rating: $e');
      return [];
    }
  }
}

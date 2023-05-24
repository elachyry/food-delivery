import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RatingRepository extends GetxController {
  final CollectionReference ratingsCollection =
      FirebaseFirestore.instance.collection('ratings');

  Future<void> addRating(Map<String, dynamic> ratingData) async {
    try {
      await ratingsCollection.add(ratingData);
      // Rating added successfully
    } catch (error) {
      // Handle error
    }
  }

  Future<void> updateRating(
      String ratingId, Map<String, dynamic> ratingData) async {
    try {
      await ratingsCollection.doc(ratingId).update(ratingData);
      // Rating updated successfully
    } catch (error) {
      // Handle error
    }
  }

  Future<void> deleteRating(String ratingId) async {
    try {
      await ratingsCollection.doc(ratingId).delete();
      // Rating deleted successfully
    } catch (error) {
      // Handle error
    }
  }

  Stream<QuerySnapshot> streamRatings() {
    return ratingsCollection.orderBy('addedAt', descending: true).snapshots();
  }
}

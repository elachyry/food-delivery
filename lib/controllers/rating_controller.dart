import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:get/get.dart';
import 'package:food_delivery_express/models/rating.dart';

import '../repositories/rating_repository.dart';

class RatingController extends GetxController {
  final RatingRepository ratingRepository = RatingRepository();
  final List<Rating> ratings = <Rating>[].obs;
  TextEditingController feedbackController = TextEditingController();

  var isLoading = false.obs;
  var isLoading2 = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch initial ratings data
    fetchRatings();
  }

  void fetchRatings() {
    ratingRepository.streamRatings().listen((snapshot) {
      final List<Rating> fetchedRatings = [];
      for (final ratingDoc in snapshot.docs) {
        // final ratingData = ratingDoc.data() as Map<String, dynamic>;
        final rating = Rating.fromFireStore(ratingDoc);
        fetchedRatings.add(rating);
      }
      ratings.assignAll(fetchedRatings);
    });
  }

  void addRating(Map<String, dynamic> ratingData) {
    isLoading.value = true;
    ratingRepository.addRating(ratingData);
    isLoading.value = false;
  }

  void updateRating(String ratingId, Map<String, dynamic> ratingData) {
    isLoading.value = true;

    ratingRepository.updateRating(ratingId, ratingData);
    isLoading.value = false;
  }

  void deleteRating(String ratingId) {
    ratingRepository.deleteRating(ratingId);
  }

  Stream<QuerySnapshot> streamRatings() {
    return ratingRepository.streamRatings();
  }

  Rating? getRating(String costumerId, String restaurantId, String menuIremId) {
    List<Rating> matchingRatings = [];

    if (restaurantId == '') {
      matchingRatings = ratings
          .where((rating) =>
              rating.menuItemId == menuIremId && rating.custmerId == costumerId)
          .toList();
    } else {
      matchingRatings = ratings.where((rating) {
        return rating.restaurantId == restaurantId &&
            rating.custmerId == costumerId;
      }).toList();
    }
    if (matchingRatings.isNotEmpty) {
      return matchingRatings.first;
    } else {
      return null;
    }
  }
}

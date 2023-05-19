import 'package:get/get.dart';

import '../models/rating.dart';
import '../repositories/repositories.dart';

class RatingController extends GetxController {
  final RatingRepository _ratingRepository = Get.put(RatingRepository());

  RxList<Rating> _ratings = RxList<Rating>();
  List<Rating> get ratings => _ratings;

  @override
  void onInit() {
    super.onInit();
    loadRatings();
  }

  void loadRatings() async {
    List<Rating> rating = await _ratingRepository.getRatings();
    _ratings.value = rating;
    // print('test $rating');
  }
}

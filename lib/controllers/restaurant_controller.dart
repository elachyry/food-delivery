import 'package:get/get.dart';

import '../models/restaurant.dart';
import '../repositories/restaurant_repository.dart';

class RestaurantController extends GetxController {
  final RestaurantRepository _restaurantRepo = Get.put(RestaurantRepository());

  RxList<Restaurant> restaurants = RxList<Restaurant>([]);

  Stream<List<Restaurant>> get restaurantStream =>
      _restaurantRepo.getRestaurants();

  @override
  void onInit() {
    super.onInit();
    loadRedtaurants();
  }

  // void loadRedtaurants() async {
  //   List<Restaurant> restaurant = await _restaurantRepo.getRestaurants();
  //   _restaurants.value = restaurant;
  //   // print('test $rating');
  // }

  void loadRedtaurants() {
    restaurantStream.listen((restaurantList) {
      restaurants.value = restaurantList;
    });
  }
}

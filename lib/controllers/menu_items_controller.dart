import 'package:get/get.dart';

import '../models/menu_item.dart';
import '../repositories/repositories.dart';

class MenuItemsController extends GetxController {
  final MenuItemsRepository _menuItemsRepo = Get.put(MenuItemsRepository());

  RxList<MenuItem> menuItems = RxList<MenuItem>([]);
  Stream<List<MenuItem>> get menuItemsStream => _menuItemsRepo.getMenuItems();
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadMenuItems();
  }

  @override
  void onReady() {
    super.onReady();
    loadMenuItems();
  }

  // Future<void> fetchAllMenuItems() async {
  //   menuItems.clear();

  //   final restaurantIds = await _menuItemsRepo.getAllRestaurantIds();

  //   for (final restaurantId in restaurantIds) {
  //     final items =
  //         await _menuItemsRepo.getMenuItemsForRestaurant(restaurantId);
  //     menuItems.addAll(items);
  //   }
  // }

  void loadMenuItems() {
    menuItemsStream.listen((menuItemsList) {
      menuItems.value = menuItemsList;
    });
  }
}

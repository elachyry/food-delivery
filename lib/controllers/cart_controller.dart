import 'package:get/get.dart';

import '../models/cart.dart';
import '../repositories/cart_repository.dart';

class CartController extends GetxController {
  final CartRepository _cartRepo = CartRepository();
  final Rx<Cart?> _cart = Rx<Cart?>(null);

  Cart? get cart => _cart.value;

  @override
  void onInit() {
    super.onInit();
    getCart();
  }

  @override
  void onReady() {
    super.onReady();
    getCart();
  }

  Future<void> getCart() async {
    final cart = await _cartRepo.getCart();
    _cart.value = cart;
    // print('cart222 $cart');
  }
}

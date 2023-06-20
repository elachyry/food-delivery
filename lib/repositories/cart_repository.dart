import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_express/controllers/auth/auth_controller.dart';

import '../models/cart.dart';
import '../models/coupon.dart';
import '../models/menu_item.dart';

class CartRepository {
  final CollectionReference _cartsCollection =
      FirebaseFirestore.instance.collection('carts');

  Future<void> addToCart(Cart cart) async {
    await _cartsCollection
        .doc(AuthController.instance.auth.currentUser!.uid)
        .set({
      'menuItems': cart.menuItems.map((item) => item.toMap()).toList(),
      'checkStates': cart.checkStates,
      'coupon': cart.coupon?.toMap(),
    });
  }

  Future<Cart> getCart() async {
    final DocumentSnapshot cartData = await FirebaseFirestore.instance
        .collection('carts')
        .doc(AuthController.instance.auth.currentUser!.uid)
        .get();

    if (!cartData.exists) {
      return const Cart(menuItems: [], checkStates: {});
    }

    final Map<String, dynamic> data = cartData.data() as Map<String, dynamic>;

    final List<Map<String, dynamic>> menuItemsData =
        List<Map<String, dynamic>>.from(data['menuItems'] ?? []);
    // print(menuItemsData);

    final menuItems =
        menuItemsData.map((itemData) => MenuItem.fromMap(itemData)).toList();
    // print('menuItems $menuItems');

    final Map<String, bool> checkStates =
        Map<String, bool>.from(data['checkStates'] ?? {});

    final couponData = data['coupon'];
    final Coupon? coupon =
        couponData != null ? Coupon.fromMap(couponData) : null;

    return Cart(menuItems: menuItems, checkStates: checkStates, coupon: coupon);
  }

  // Future<Cart?> getCart() async {
  //   final DocumentSnapshot snapshot = await _cartsCollection
  //       .doc(AuthController.instance.auth.currentUser!.uid)
  //       .get();

  //   if (snapshot.exists) {
  //     final data = snapshot.data() as Map<String, dynamic>;
  //     final List<dynamic> menuItemsData = data['menuItems'];
  //     final List<MenuItem> menuItems = menuItemsData
  //         .map((itemData) => MenuItem.fromFirestore(itemData))
  //         .toList();
  //     final Map<String, bool> checkStates =
  //         Map<String, bool>.from(data['checkStates']);
  //     final Coupon? coupon =
  //         data['coupon'] != null ? Coupon.fromFirestore(data['coupon']) : null;

  //     return Cart(
  //       menuItems: menuItems,
  //       checkStates: checkStates,
  //       coupon: coupon,
  //     );
  //   }

  //   return null;
  // }

  Future<void> updateCart(Cart cart) async {
    await _cartsCollection
        .doc(AuthController.instance.auth.currentUser!.uid)
        .update({
      'menuItems': cart.menuItems.map((item) => item.toMap()).toList(),
      'checkStates': cart.checkStates,
      'coupon': cart.coupon?.toMap(),
    });
  }

  Future<void> deleteCart(String userId) async {
    await _cartsCollection.doc(userId).delete();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_express/controllers/auth/auth_controller.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> toggleFavoriteMenuItem(
      String menuItemId, bool isFavorite) async {
    final customerRef = _firestore
        .collection('users')
        .doc(AuthController.instance.auth.currentUser!.uid);

    final menuItemRef =
        customerRef.collection('favoriteMenuItems').doc(menuItemId);

    if (isFavorite) {
      await menuItemRef.set({'isFavorite': true});
    } else {
      await menuItemRef.delete();
    }
  }

  Future<void> toggleFavoriteRestaurant(
      String restaurantId, bool isFavorite) async {
    final customerRef = _firestore
        .collection('users')
        .doc(AuthController.instance.auth.currentUser!.uid);
    final restaurantRef =
        customerRef.collection('favoriteRestaurants').doc(restaurantId);

    if (isFavorite) {
      await restaurantRef.set({'isFavorite': true});
    } else {
      await restaurantRef.delete();
    }
  }

  Future<List<String>> getFavoriteRestaurants() async {
    try {
      QuerySnapshot snapshot = await usersCollection
          .doc(AuthController.instance.auth.currentUser!.uid)
          .collection('favoriteRestaurants')
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.map((doc) => doc.id).toList();
      }

      return [];
    } catch (error) {
      return [];
    }
  }

  Future<List<String>> getFavoriteMenuItems() async {
    try {
      QuerySnapshot snapshot = await usersCollection
          .doc(AuthController.instance.auth.currentUser!.uid)
          .collection('favoriteMenuItems')
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.map((doc) => doc.id).toList();
      }

      return [];
    } catch (error) {
      // print('Failed to fetch favorite menu item IDs: $error');
      return [];
    }
  }
}

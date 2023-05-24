import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multi_languges/controllers/auth/auth_controller.dart';

class OrderRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentReference<Map<String, dynamic>>> addOrder(
      Map<String, dynamic> orderData) async {
    return _firestore
        .collection('orders')
        .doc(AuthController.instance.auth.currentUser!.uid)
        .collection('orders')
        .add(orderData);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getOrders() async {
    return _firestore
        .collection('orders')
        .doc(AuthController.instance.auth.currentUser!.uid)
        .collection('orders')
        .orderBy('addedAt', descending: true)
        .get();
  }

  Future<void> cancelOrder(String id) async {
    return _firestore
        .collection('orders')
        .doc(AuthController.instance.auth.currentUser!.uid)
        .collection('orders')
        .doc(id)
        .update({'status': 'Cancelled'});
  }
}

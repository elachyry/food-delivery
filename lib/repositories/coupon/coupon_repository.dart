import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multi_languges/models/coupon.dart';

import 'base_coupon_repository.dart';

class CouponRepository extends BaseCouponRepository {
  final FirebaseFirestore _firestore;

  CouponRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Coupon>> getCoupons() {
    return _firestore.collection('coupons').snapshots().map((event) {
      return event.docs.map((e) => Coupon.fromFirestore(e)).toList();
    });
  }

  @override
  Future<bool> searchCoupon(String code) async {
    final coupon = await _firestore
        .collection('coupons')
        .where('code', isEqualTo: code)
        .get();
    return coupon.docs.isNotEmpty;
  }
}

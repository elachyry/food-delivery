import '../../models/coupon.dart';

abstract class BaseCouponRepository {
  Future<bool> searchCoupon(String code);
  Stream<List<Coupon>> getCoupons();
}

part of 'coupon_bloc.dart';

abstract class CouponState extends Equatable {
  const CouponState();

  @override
  List<Object> get props => [];
}

class CouponLoading extends CouponState {}

class CouponLoaded extends CouponState {
  final List<Coupon> coupons;

  const CouponLoaded({this.coupons = const <Coupon>[]});

  @override
  List<Object> get props => [coupons];
}

class CouponSelected extends CouponState {
  final Coupon coupon;

  const CouponSelected({required this.coupon});

  @override
  List<Object> get props => [coupon];
}

class CouponError extends CouponState {}

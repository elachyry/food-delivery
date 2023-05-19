// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'coupon_bloc.dart';

abstract class CouponEvent extends Equatable {
  const CouponEvent();

  @override
  List<Object> get props => [];
}

class LoadCoupons extends CouponEvent {}

class UpdateCoupons extends CouponEvent {
  final List<Coupon> coupons;
  const UpdateCoupons({this.coupons = const <Coupon>[]});

  @override
  List<Object> get props => [coupons];
}

class SelectCoupon extends CouponEvent {
  final Coupon coupon;
  const SelectCoupon({required this.coupon});

  @override
  List<Object> get props => [coupon];
}

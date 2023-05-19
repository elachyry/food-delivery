import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/coupon.dart';
import '../../repositories/coupon/coupon_repository.dart';

part 'coupon_event.dart';
part 'coupon_state.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  final CouponRepository _couponRepo;
  StreamSubscription? _couponSubscription;
  CouponBloc({required CouponRepository couponRepo})
      : _couponRepo = couponRepo,
        super(CouponLoading()) {
    on<LoadCoupons>(_onLoadCoupons);
    on<UpdateCoupons>(_onUpdateCoupons);
    on<SelectCoupon>(_onSelectCoupon);
  }
  void _onLoadCoupons(LoadCoupons event, Emitter<CouponState> emit) {
    _couponSubscription?.cancel();
    _couponSubscription = _couponRepo.getCoupons().listen((coupons) {
      add(UpdateCoupons(coupons: coupons));
    });
  }

  void _onUpdateCoupons(UpdateCoupons event, Emitter<CouponState> emit) {
    emit(CouponLoaded(coupons: event.coupons));
  }

  void _onSelectCoupon(SelectCoupon event, Emitter<CouponState> emit) {
    emit(CouponSelected(coupon: event.coupon));
  }
}

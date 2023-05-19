import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:multi_languges/models/menu_item.dart';

import '../../controllers/cart_controller.dart';
import '../../models/cart.dart';
import '../../models/coupon.dart';
import '../../repositories/cart_repository.dart';
import '../coupon/coupon_bloc.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CouponBloc _couponBloc;
  StreamSubscription? _couponSubscription;
  final _cartRepo = CartRepository();
  final cartController = Get.find<CartController>();

  CartBloc({required CouponBloc couponBloc})
      : _couponBloc = couponBloc,
        super(CartLoading()) {
    _couponSubscription = couponBloc.stream.listen((state) {
      if (state is CouponSelected) {
        add(AddCoupon(coupon: state.coupon));
      }
    });
  }

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is StartCart) {
      yield* _mapStartCartToState();
    } else if (event is AddItem) {
      yield* _mapAddItemToState(event, state);
    }
    if (event is RemoveItem) {
      yield* _mapRemoveItemToState(event, state);
    }
    if (event is RemoveItemTotal) {
      yield* _mapRemoveItemTotalToState(event, state);
    }
    if (event is SelectToggle) {
      yield* _mapSelectToggleToState(event, state);
    }
    if (event is AddCoupon) {
      yield* _mapAddCouponToState(event, state);
    }
    if (event is RemoveCoupon) {
      yield* _mapRemoveCouponToState(event, state);
    }
    if (event is ClearCart) {
      yield* _mapClearCartToState(event, state);
    }
  }

  Stream<CartState> _mapStartCartToState() async* {
    yield CartLoading();
    try {
      // await Future<void>.delayed(const Duration(seconds: 1));
      cartController.getCart();
      yield CartLoaded(cart: cartController.cart as Cart);
    } catch (_) {}
  }

  Stream<CartState> _mapAddItemToState(AddItem event, CartState state) async* {
    if (state is CartLoaded) {
      try {
        // print('cart befor ${state.cart}');
        yield CartLoaded(
          cart: state.cart.copyWith(
            menuItems: List.from(state.cart.menuItems)..add(event.menuItem),
            checkStates: Map.from(state.cart.checkStates)
              ..[event.menuItem.id] = true,
          ),
        );
        // print('cart after ${state.cart}');

        await _cartRepo.updateCart(
          state.cart.copyWith(
            menuItems: List.from(state.cart.menuItems)..add(event.menuItem),
            checkStates: Map.from(state.cart.checkStates)
              ..[event.menuItem.id] = true,
          ),
        );
      } catch (_) {}
    }
  }

  Stream<CartState> _mapRemoveItemToState(
      RemoveItem event, CartState state) async* {
    if (state is CartLoaded) {
      final items = state.cart.menuItems
          .where((element) => element.id == event.menuItem.id);
      if (items.length == 1) {
        return;
      }
      try {
        yield CartLoaded(
          cart: state.cart.copyWith(
            menuItems: List.from(state.cart.menuItems)..remove(event.menuItem),
          ),
        );

        await _cartRepo.updateCart(
          state.cart.copyWith(
            menuItems: List.from(state.cart.menuItems)..remove(event.menuItem),
          ),
        );
      } catch (_) {}
    }
  }

  Stream<CartState> _mapRemoveItemTotalToState(
      RemoveItemTotal event, CartState state) async* {
    if (state is CartLoaded) {
      try {
        yield CartLoaded(
          cart: state.cart.copyWith(
              menuItems: List.from(state.cart.menuItems)
                ..removeWhere((element) => element.id == event.menuItem.id),
              checkStates: Map.from(state.cart.checkStates)
                ..remove(event.menuItem.id)),
        );
        await _cartRepo.updateCart(
          state.cart.copyWith(
              menuItems: List.from(state.cart.menuItems)
                ..removeWhere((element) => element.id == event.menuItem.id),
              checkStates: Map.from(state.cart.checkStates)
                ..remove(event.menuItem.id)),
        );
      } catch (_) {}
    }
  }

  Stream<CartState> _mapClearCartToState(
      ClearCart event, CartState state) async* {
    if (state is CartLoaded) {
      try {
        yield CartLoaded(
            cart: state.cart.copyWith(
          menuItems: [],
          checkStates: {},
        ));
        await _cartRepo.updateCart(
          state.cart.copyWith(
            menuItems: [],
            checkStates: {},
          ),
        );
      } catch (_) {}
    }
  }

  Stream<CartState> _mapSelectToggleToState(
      SelectToggle event, CartState state) async* {
    if (state is CartLoaded) {
      try {
        yield CartLoaded(
            cart: state.cart.copyWith(
                checkStates: Map.from(state.cart.checkStates)
                  ..[event.menuItem.id] = event.value));
        await _cartRepo.updateCart(state.cart.copyWith(
            checkStates: Map.from(state.cart.checkStates)
              ..[event.menuItem.id] = event.value));
      } catch (_) {}
    }
  }

  Stream<CartState> _mapAddCouponToState(
      AddCoupon event, CartState state) async* {
    if (state is CartLoaded) {
      try {
        yield CartLoaded(cart: state.cart.copyWith(coupon: event.coupon));
        await _cartRepo.updateCart(state.cart.copyWith(coupon: event.coupon));
      } catch (_) {}
    }
  }

  Stream<CartState> _mapRemoveCouponToState(
      RemoveCoupon event, CartState state) async* {
    if (state is CartLoaded) {
      try {
        yield CartLoaded(cart: state.cart.deleteCoupon());
        await _cartRepo.updateCart(state.cart);
        await _cartRepo.updateCart(state.cart.copyWith().deleteCoupon());
      } catch (_) {}
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:multi_languges/models/menu_item.dart';

import '../../models/cart.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading());

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
  }

  Stream<CartState> _mapStartCartToState() async* {
    yield CartLoading();
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      yield const CartLoaded(cart: Cart());
    } catch (_) {}
  }

  Stream<CartState> _mapAddItemToState(AddItem event, CartState state) async* {
    if (state is CartLoaded) {
      try {
        yield CartLoaded(
          cart: state.cart.copyWith(
            menuItems: List.from(state.cart.menuItems)..add(event.menuItem),
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
          ),
        );
      } catch (_) {}
    }
  }

  Stream<CartState> _mapSelectToggleToState(
      SelectToggle event, CartState state) async* {
    if (state is CartLoaded) {
      try {
        yield CartLoaded(cart: state.cart.copyWith());
      } catch (_) {}
    }
  }
}

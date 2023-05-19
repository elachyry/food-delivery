part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class StartCart extends CartEvent {
  @override
  List<Object> get props => [];
}

class AddItem extends CartEvent {
  final MenuItem menuItem;

  const AddItem({required this.menuItem});

  @override
  List<Object> get props => [menuItem];
}

class RemoveItem extends CartEvent {
  final MenuItem menuItem;

  const RemoveItem({required this.menuItem});

  @override
  List<Object> get props => [menuItem];
}

class RemoveItemTotal extends CartEvent {
  final MenuItem menuItem;

  const RemoveItemTotal({required this.menuItem});

  @override
  List<Object> get props => [menuItem];
}

class SelectToggle extends CartEvent {
  final MenuItem menuItem;
  final bool value;
  const SelectToggle({
    required this.menuItem,
    required this.value,
  });
  @override
  List<Object> get props => [
        menuItem,
        value,
      ];
}

class AddCoupon extends CartEvent {
  final Coupon coupon;

  const AddCoupon({required this.coupon});

  @override
  List<Object> get props => [coupon];
}

class RemoveCoupon extends CartEvent {
  const RemoveCoupon();

  @override
  List<Object> get props => [];
}

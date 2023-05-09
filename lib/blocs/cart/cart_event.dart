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

class SelectToggle extends CartEvent {
  const SelectToggle();
  @override
  List<Object> get props => [];
}

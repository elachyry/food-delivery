import 'package:equatable/equatable.dart';
import 'package:multi_languges/models/menu_item.dart';

class Cart extends Equatable {
  final List<MenuItem> menuItems;

  const Cart({
    this.menuItems = const <MenuItem>[],
  });

  Cart copyWith({
    List<MenuItem>? menuItems,
  }) {
    return Cart(
      menuItems: menuItems ?? this.menuItems,
    );
  }

  @override
  List<Object?> get props => [
        menuItems,
      ];

  Map itemQuantity(menuItem) {
    var quantity = {};
    for (var element in menuItems) {
      if (!quantity.containsKey(element)) {
        quantity[element] = 1;
      } else {
        quantity[element] += 1;
      }
    }
    return quantity;
  }

  Map itemselected(menuItem) {
    var selected = {};
    for (var element in menuItems) {
      if (!selected.containsKey(element)) {
        selected[element] = false;
      } else {
        selected[element] = !selected[element];
      }
    }
    return selected;
  }

  double get subTotal => menuItems.fold(
      0, (previousValue, element) => previousValue + element.price);
  double total(subTotal) {
    return subTotal + 5;
  }
}

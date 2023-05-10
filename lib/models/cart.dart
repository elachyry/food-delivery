import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';
import 'package:multi_languges/models/restaurant.dart';

import '../models/menu_item.dart';

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

  Map<int, List<MenuItem>> groupedMenuItems(List<MenuItem> menuItems) {
    final items = groupBy(menuItems, (MenuItem e) {
      return e.restaurantId;
    });
    return items;
  }

  Map<int, Map<MenuItem, int>> itemQuantity(List<MenuItem> menuItems2) {
    final items = groupBy(menuItems, (MenuItem e) {
      return e.restaurantId;
    });

    // print('Items : $items');
    Map<int, Map<MenuItem, int>> quantityItems = {};

    // items.forEach((key, value) {
    //   quantityItems[key] = {};
    // });

    Map<MenuItem, int> quantity = {};
    // print('begin ');

    for (var e in items.entries) {
      // print('value : ${e.value}');

      for (var element in e.value) {
        // print('element : $element');

        if (!quantity.containsKey(element)) {
          quantity[element] = 1;
        } else {
          quantity[element] = quantity[element]! + 1;
        }
        quantityItems.putIfAbsent(e.key, () => quantity);
        // print('quantity : $quantity');
        // print('quantityItems : $quantityItems');
      }
      quantity = {};
    }
    List<MapEntry<int, Map<MenuItem, int>>> entryList =
        quantityItems.entries.toList();
    entryList.sort((a, b) => a.key.compareTo(b.key));
    Map<int, Map<MenuItem, int>> sortedMap = Map.fromEntries(entryList);

    return quantityItems;
  }

  Map<int, double> subtotal(List<MenuItem> menuItems2) {
    final items = groupBy(menuItems, (MenuItem e) {
      return e.restaurantId;
    });
    Map<int, double> mapSubTotal = {};

    final itemsQuantity = itemQuantity(menuItems2);
    double totale = 0;
    itemsQuantity.forEach((key, value) {
      value.forEach((key2, value2) {
        totale = key2.price * value2;
        if (!mapSubTotal.containsKey(key)) {
          mapSubTotal[key] = totale;
        } else {
          mapSubTotal[key] = mapSubTotal[key]! + totale;
        }
      });
      totale = 0;
    });

    return mapSubTotal;
  }

  double grandTotal(List<MenuItem> menuItems2) {
    final subTotal = subtotal(menuItems2);
    double total = 0;
    subTotal.forEach((key, value) {
      total += Restaurant.restaurants
              .firstWhere((element) => element.id == key)
              .deliveryFee +
          value;
    });
    return total;
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

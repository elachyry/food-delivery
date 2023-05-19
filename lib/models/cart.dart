// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import 'package:multi_languges/controllers/restaurant_controller.dart';
import 'package:multi_languges/models/coupon.dart';

import '../models/menu_item.dart';

class Cart extends Equatable {
  final List<MenuItem> menuItems;
  final Map<String, bool> checkStates;
  final Coupon? coupon;

  const Cart({
    this.menuItems = const <MenuItem>[],
    this.checkStates = const {},
    this.coupon,
  });

  Cart copyWith({
    List<MenuItem>? menuItems,
    Map<String, bool>? checkStates,
    Coupon? coupon,
  }) {
    return Cart(
      menuItems: menuItems ?? this.menuItems,
      checkStates: checkStates ?? this.checkStates,
      coupon: coupon ?? this.coupon,
    );
  }

  Cart deleteCoupon() {
    return Cart(menuItems: menuItems, checkStates: checkStates, coupon: null);
  }

  @override
  List<Object?> get props => [menuItems, checkStates, coupon];

  Map<String, List<MenuItem>> groupedMenuItems(List<MenuItem> menuItems) {
    final items = groupBy(menuItems, (MenuItem e) {
      return e.restaurantId;
    });
    return items;
  }

  Map<String, Map<MenuItem, int>> itemQuantity(List<MenuItem> menuItems2) {
    final items = groupBy(menuItems, (MenuItem e) {
      return e.restaurantId;
    });

    // print('Items : $items');
    Map<String, Map<MenuItem, int>> quantityItems = {};

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
    // List<MapEntry<int, Map<MenuItem, int>>> entryList =
    //     quantityItems.entries.toList();
    // entryList.sort((a, b) => a.key.compareTo(b.key));
    // Map<int, Map<MenuItem, int>> sortedMap = Map.fromEntries(entryList);

    return quantityItems;
  }

  Map<String, double> subtotal(List<MenuItem> menuItems2) {
    final items = groupBy(menuItems, (MenuItem e) {
      return e.restaurantId;
    });
    Map<String, double> mapSubTotal = {};

    final itemsQuantity = itemQuantity(menuItems2);
    double totale = 0;
    itemsQuantity.forEach((key, value) {
      mapSubTotal[key] = 0;
      value.forEach((key2, value2) {
        if (checkStates[key2.id] == true) {
          totale = key2.price * value2;
          if (!mapSubTotal.containsKey(key)) {
            mapSubTotal[key] = totale;
          } else {
            mapSubTotal[key] = mapSubTotal[key]! + totale;
          }
        }
        // } else {
        //   print('final else');

        //   mapSubTotal[key] = 0;
        // }
      });
      totale = 0;
    });

    return mapSubTotal;
  }

  double grandTotal(List<MenuItem> menuItems2) {
    final restaurantController = Get.put(RestaurantController());
    final subTotal = subtotal(menuItems2);
    double total = 0;
    subTotal.forEach((key, value) {
      if (value != 0) {
        total += restaurantController.restaurants
                .firstWhere((element) => element.id == key)
                .deliveryFee +
            value;
      }
    });
    if (coupon != null) {
      if (total >= coupon!.conditionAmount) {
        total -= coupon!.discount;
      }
    }
    return total;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'menuItems': menuItems.map((x) => x.toMap()).toList(),
      'checkStates': checkStates,
      'coupon': coupon?.toMap(),
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      menuItems: List<MenuItem>.from(
        (map['menuItems'] as List<int>).map<MenuItem>(
          (x) => MenuItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
      checkStates:
          Map<String, bool>.from((map['checkStates'] as Map<String, bool>)),
      coupon: map['coupon'] != null
          ? Coupon.fromMap(map['coupon'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) =>
      Cart.fromMap(json.decode(source) as Map<String, dynamic>);
}

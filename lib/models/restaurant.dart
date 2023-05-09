import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../models/menu_item.dart';
import '../models/rating.dart';

class Restaurant extends Equatable {
  final int id;
  final String name;
  final String logoUrl;
  final String imageUrl;
  final List<String> tags;
  final List<MenuItem> menuItems;
  final int deliveryTime;
  final double deliveryFee;
  final double distance;
  final List<Rating> ratings;
  final String priceCategory;
  final String addedAt;

  static final restaurants = [
    Restaurant(
      id: 1,
      name: 'Burger Joint',
      logoUrl:
          'https://media-cdn.grubhub.com/image/upload/d_search:browse-images:default.jpg/w_300,q_100,fl_lossy,dpr_2.0,c_fit,f_auto,h_300/uy4abxa8b5hubp59qod4',
      imageUrl:
          'https://images.unsplash.com/photo-1512152272829-e3139592d56f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
      tags: (MenuItem.menuItems
              .where((element) => element.restaurantId == 1)
              .map((e) => e.category.name)
              .toSet())
          .toList(),
      menuItems: (MenuItem.menuItems
          .where((element) => element.restaurantId == 1)).toList(),
      deliveryTime: 20,
      deliveryFee: 2.99,
      distance: 1.5,
      ratings: [
        Rating(
          id: 1,
          custmer: 'Mohammed Elachyry',
          rate: 3.5,
        ),
        Rating(
          id: 2,
          custmer: 'Mohammed Elachyry',
          rate: 5,
        ),
        Rating(
          id: 3,
          custmer: 'Mohammed Elachyry',
          rate: 4,
        ),
        Rating(
          id: 4,
          custmer: 'Mohammed Elachyry',
          rate: 4.5,
        ),
      ],
      priceCategory: 'Medium',
      addedAt: DateFormat('yyyy-MM-dd').format(DateTime(2023, 01, 23)),
    ),
    Restaurant(
      id: 2,
      name: 'Pizza Place',
      logoUrl:
          'https://media-cdn.grubhub.com/image/upload/d_search:browse-images:default.jpg/w_300,q_100,fl_lossy,dpr_2.0,c_fit,f_auto,h_300/uy4abxa8b5hubp59qod4',
      imageUrl:
          'https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
      tags: (MenuItem.menuItems
              .where((element) => element.restaurantId == 2)
              .map((e) => e.category.name)
              .toSet())
          .toList(),
      menuItems: (MenuItem.menuItems
          .where((element) => element.restaurantId == 2)).toList(),
      deliveryTime: 30,
      deliveryFee: 1.99,
      distance: 2.5,
      ratings: [
        Rating(
          id: 1,
          custmer: 'Mohammed Elachyry',
          rate: 3.5,
        ),
        Rating(
          id: 2,
          custmer: 'Mohammed Elachyry',
          rate: 3,
        ),
        Rating(
          id: 3,
          custmer: 'Mohammed Elachyry',
          rate: 4.8,
        ),
        Rating(
          id: 4,
          custmer: 'Mohammed Elachyry',
          rate: 4,
        ),
      ],
      priceCategory: 'Low',
      addedAt: DateFormat('yyyy-MM-dd').format(DateTime(2023, 02, 23)),
    ),
    Restaurant(
      id: 3,
      name: 'Sushi Bar',
      logoUrl:
          'https://media-cdn.grubhub.com/image/upload/d_search:browse-images:default.jpg/w_300,q_100,fl_lossy,dpr_2.0,c_fit,f_auto,h_300/uy4abxa8b5hubp59qod4',
      imageUrl:
          'https://images.unsplash.com/photo-1611143669185-af224c5e3252?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1032&q=80',
      tags: (MenuItem.menuItems
              .where((element) => element.restaurantId == 3)
              .map((e) => e.category.name)
              .toSet())
          .toList(),
      menuItems: (MenuItem.menuItems
          .where((element) => element.restaurantId == 3)).toList(),
      deliveryTime: 25,
      deliveryFee: 3.99,
      distance: 3.0,
      ratings: [
        Rating(
          id: 1,
          custmer: 'Mohammed Elachyry',
          rate: 5,
        ),
        Rating(
          id: 2,
          custmer: 'Mohammed Elachyry',
          rate: 3.5,
        ),
        Rating(
          id: 3,
          custmer: 'Mohammed Elachyry',
          rate: 4,
        ),
        Rating(
          id: 4,
          custmer: 'Mohammed Elachyry',
          rate: 4.5,
        ),
      ],
      priceCategory: 'Low',
      addedAt: DateFormat('yyyy-MM-dd').format(DateTime(2023, 02, 28)),
    ),
    Restaurant(
      id: 4,
      name: 'Mexican Grill',
      logoUrl:
          'https://media-cdn.grubhub.com/image/upload/d_search:browse-images:default.jpg/w_300,q_100,fl_lossy,dpr_2.0,c_fit,f_auto,h_300/uy4abxa8b5hubp59qod4',
      imageUrl:
          'https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
      tags: (MenuItem.menuItems
              .where((element) => element.restaurantId == 4)
              .map((e) => e.category.name)
              .toSet())
          .toList(),
      menuItems: (MenuItem.menuItems
          .where((element) => element.restaurantId == 4)).toList(),
      deliveryTime: 35,
      deliveryFee: 0,
      distance: 4.0,
      ratings: [
        Rating(
          id: 1,
          custmer: 'Mohammed Elachyry',
          rate: 3.5,
        ),
        Rating(
          id: 2,
          custmer: 'Mohammed Elachyry',
          rate: 3,
        ),
        Rating(
          id: 3,
          custmer: 'Mohammed Elachyry',
          rate: 4.8,
        ),
        Rating(
          id: 4,
          custmer: 'Mohammed Elachyry',
          rate: 4.5,
        ),
      ],
      priceCategory: 'Medium',
      addedAt: DateFormat('yyyy-MM-dd').format(DateTime(2023, 03, 05)),
    ),
    Restaurant(
      id: 5,
      name: 'Cafe',
      logoUrl: '',
      imageUrl:
          'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
      tags: (MenuItem.menuItems
              .where((element) => element.restaurantId == 5)
              .map((e) => e.category.name)
              .toSet())
          .toList(),
      menuItems: (MenuItem.menuItems
          .where((element) => element.restaurantId == 5)).toList(),
      deliveryTime: 15,
      deliveryFee: 1.49,
      distance: 0.5,
      ratings: [
        Rating(
          id: 1,
          custmer: 'Mohammed Elachyry',
          rate: 4,
        ),
        Rating(
          id: 2,
          custmer: 'Mohammed Elachyry',
          rate: 4,
        ),
        Rating(
          id: 3,
          custmer: 'Mohammed Elachyry',
          rate: 4.8,
        ),
        Rating(
          id: 4,
          custmer: 'Mohammed Elachyry',
          rate: 5,
        ),
      ],
      priceCategory: 'High',
      addedAt: DateFormat('yyyy-MM-dd').format(DateTime(2023, 03, 15)),
    ),
  ];

  Restaurant({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.imageUrl,
    required this.tags,
    required this.menuItems,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.distance,
    required this.ratings,
    required this.priceCategory,
    required this.addedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        tags,
        menuItems,
        deliveryTime,
        deliveryFee,
        distance,
      ];
}

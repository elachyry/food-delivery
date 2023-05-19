import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../models/menu_item.dart';
import '../models/rating.dart';

class Restaurant extends Equatable {
  final int id;
  final String name;
  final String logoUrl;
  final String imageUrl;
  final String description;
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
      description:
          'is a cozy French bistro located in the heart of the city. The restaurant offers a warm and intimate atmosphere, with a rustic decor that transports you to the streets of Paris. The menu features classic French dishes, including escargots, bouillabaisse, and coq au vin, all made with the freshest ingredients. The wine list is extensive, featuring a variety of French and international wines to perfectly complement your meal. With its charming ambiance and delicious cuisine, "La Petite Maison" is the perfect spot for a romantic dinner or a night out with friends.',
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
      description:
          'is a cozy French bistro located in the heart of the city. The restaurant offers a warm and intimate atmosphere, with a rustic decor that transports you to the streets of Paris. The menu features classic French dishes, including escargots, bouillabaisse, and coq au vin, all made with the freshest ingredients. The wine list is extensive, featuring a variety of French and international wines to perfectly complement your meal. With its charming ambiance and delicious cuisine, "La Petite Maison" is the perfect spot for a romantic dinner or a night out with friends.',
      logoUrl:
          'https://img.freepik.com/premium-vector/pizza-logo-template-suitable-restaurant-cafe-logo-restaurant-food-delivery-service_279597-968.jpg?w=2000',
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
      description:
          'is a cozy French bistro located in the heart of the city. The restaurant offers a warm and intimate atmosphere, with a rustic decor that transports you to the streets of Paris. The menu features classic French dishes, including escargots, bouillabaisse, and coq au vin, all made with the freshest ingredients. The wine list is extensive, featuring a variety of French and international wines to perfectly complement your meal. With its charming ambiance and delicious cuisine, "La Petite Maison" is the perfect spot for a romantic dinner or a night out with friends.',
      logoUrl:
          'https://img.freepik.com/free-vector/hand-drawn-korean-food-logo_23-2149670612.jpg?w=740&t=st=1683759731~exp=1683760331~hmac=48bb9c7417fc3b587e26ec4e90fdc3a6aefd9e34ef4fd09699a2b44d34940584',
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
      description:
          'is a cozy French bistro located in the heart of the city. The restaurant offers a warm and intimate atmosphere, with a rustic decor that transports you to the streets of Paris. The menu features classic French dishes, including escargots, bouillabaisse, and coq au vin, all made with the freshest ingredients. The wine list is extensive, featuring a variety of French and international wines to perfectly complement your meal. With its charming ambiance and delicious cuisine, "La Petite Maison" is the perfect spot for a romantic dinner or a night out with friends.',
      logoUrl:
          'https://img.freepik.com/free-vector/hand-drawn-mexico-logo_23-2149731041.jpg?size=626&ext=jpg',
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
      description:
          'is a cozy French bistro located in the heart of the city. The restaurant offers a warm and intimate atmosphere, with a rustic decor that transports you to the streets of Paris. The menu features classic French dishes, including escargots, bouillabaisse, and coq au vin, all made with the freshest ingredients. The wine list is extensive, featuring a variety of French and international wines to perfectly complement your meal. With its charming ambiance and delicious cuisine, "La Petite Maison" is the perfect spot for a romantic dinner or a night out with friends.',
      logoUrl:
          'https://img.freepik.com/free-vector/coffee-shop-badge-vintage-style_1176-95.jpg?size=626&ext=jpg',
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
    required this.description,
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

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MenuItem extends Equatable {
  final String id;
  final String restaurantId;
  final String name;
  final String categoryId;
  final String description;
  final Map<String, String> elements;
  final List<String> ingredientsId;
  final double price;
  final String imageUrl;
  final List<String> ratingsId;

  const MenuItem({
    this.id = '',
    required this.restaurantId,
    required this.name,
    required this.categoryId,
    required this.description,
    required this.elements,
    required this.ingredientsId,
    required this.price,
    required this.imageUrl,
    this.ratingsId = const [],
  });

  @override
  List<Object> get props {
    return [
      id,
      restaurantId,
      name,
      categoryId,
      description,
      elements,
      ingredientsId,
      price,
      imageUrl,
      ratingsId,
    ];
  }

  MenuItem copyWith({
    String? id,
    String? restaurantId,
    String? name,
    String? categoryId,
    String? description,
    Map<String, String>? elements,
    List<String>? ingredientsId,
    double? price,
    String? imageUrl,
    List<String>? ratingsId,
  }) {
    return MenuItem(
      id: id ?? this.id,
      restaurantId: restaurantId ?? this.restaurantId,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      description: description ?? this.description,
      elements: elements ?? this.elements,
      ingredientsId: ingredientsId ?? this.ingredientsId,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      ratingsId: ratingsId ?? this.ratingsId,
    );
  }

  factory MenuItem.fromFirestore(DocumentSnapshot snap) => MenuItem(
        id: snap.id,
        restaurantId: snap['restaurantId'] as String,
        name: snap['name'] as String,
        categoryId: snap['categoryId'] as String,
        description: snap['description'] as String,
        elements: Map<String, String>.from(snap['elements']),
        ingredientsId: List<String>.from(snap['ingredientsId']),
        price: snap['price'].toDouble(),
        imageUrl: snap['imageUrl'] as String,
        ratingsId: List<String>.from(snap['ratingsId']),
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'restaurantId': restaurantId,
      'name': name,
      'categoryId': categoryId,
      'description': description,
      'elements': elements,
      'ingredientsId': ingredientsId,
      'price': price,
      'imageUrl': imageUrl,
      'ratingsId': ratingsId,
    };
  }

  String toJson() => json.encode(toMap());

//  static final menuItems = [
//     MenuItem(
//       id: 1,
//       restaurantId: 3,
//       name: 'Cheeseburger',
//       description: 'A juicy burger with melted cheese',
//       category: Category.categories.elementAt(0),
//       elements: const [
//         {
//           'name': 'Burger',
//           'quantity': '1',
//         },
//         {
//           'name': 'Fries',
//           'quantity': '1',
//         },
//         {
//           'name': 'Pepsi',
//           'quantity': '1',
//         },
//       ],
//       ingredients: const [
//         Ingredient(
//           id: 1,
//           name: 'Ground beef',
//           imageUrl:
//               'https://img.freepik.com/free-icon/meat_318-387863.jpg?size=626&ext=jpg',
//         ),
//         Ingredient(
//           id: 2,
//           name: 'Cheddar cheese',
//           imageUrl:
//               'https://img.freepik.com/free-icon/cheese_318-896581.jpg?size=626&ext=jpg',
//         ),
//         Ingredient(
//           id: 3,
//           name: 'Burger buns',
//           imageUrl:
//               'https://img.freepik.com/free-icon/bun_318-879575.jpg?size=626&ext=jpg',
//         ),
//         Ingredient(
//           id: 4,
//           name: 'Lettuce',
//           imageUrl:
//               'https://img.freepik.com/free-icon/lettuce_318-369163.jpg?size=626&ext=jpg',
//         ),
//         Ingredient(
//           id: 5,
//           name: 'Tomato',
//           imageUrl:
//               'https://img.freepik.com/free-icon/tomato_318-892194.jpg?size=626&ext=jpg',
//         ),
//         Ingredient(
//           id: 6,
//           name: 'Onion',
//           imageUrl:
//               'https://img.freepik.com/free-icon/onion_318-937760.jpg?size=626&ext=jpg',
//         ),
//         Ingredient(
//           id: 7,
//           name: 'Ketchup',
//           imageUrl:
//               'https://img.freepik.com/free-icon/tomato-sauce_318-913129.jpg?size=626&ext=jpg',
//         ),
//         Ingredient(
//           id: 8,
//           name: 'Mustard',
//           imageUrl:
//               'https://img.freepik.com/free-icon/sauce_318-850962.jpg?size=626&ext=jpg',
//         ),
//         Ingredient(
//           id: 9,
//           name: 'Mayonnaise',
//           imageUrl:
//               'https://img.freepik.com/free-icon/mayonnaise_318-706569.jpg?size=626&ext=jpg',
//         ),
//       ],
//       ratings: [
//         Rating(
//           id: 1,
//           custmer: 'Mohammed Elachyry',
//           rate: 3.5,
//         ),
//         Rating(
//           id: 2,
//           custmer: 'Mohammed Elachyry',
//           rate: 5,
//         ),
//         Rating(
//           id: 3,
//           custmer: 'Mohammed Elachyry',
//           rate: 4,
//         ),
//         Rating(
//           id: 4,
//           custmer: 'Mohammed Elachyry',
//           rate: 4.5,
//         ),
//       ],
//       price: 8.99,
//       imageUrl:
//           'https://images.unsplash.com/photo-1572802419224-296b0aeee0d9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=815&q=80',
//     ),
//     MenuItem(
//       id: 2,
//       restaurantId: 1,
//       name: 'Fries',
//       description: 'Crispy golden fries',
//       category: Category.categories.elementAt(5),
//       elements: const [
//         {
//           'name': 'Fries',
//           'quantity': '1',
//         },
//       ],
//       ratings: [
//         Rating(
//           id: 1,
//           custmer: 'Mohammed Elachyry',
//           rate: 3.5,
//         ),
//         Rating(
//           id: 2,
//           custmer: 'Mohammed Elachyry',
//           rate: 5,
//         ),
//         Rating(
//           id: 3,
//           custmer: 'Mohammed Elachyry',
//           rate: 4,
//         ),
//         Rating(
//           id: 4,
//           custmer: 'Mohammed Elachyry',
//           rate: 4.5,
//         ),
//       ],
//       price: 2.99,
//       imageUrl:
//           'https://images.unsplash.com/photo-1518013431117-eb1465fa5752?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
//     ),
//     MenuItem(
//       id: 3,
//       restaurantId: 1,
//       name: 'Chocolate Milkshake',
//       description: 'Creamy chocolate goodness',
//       category: Category.categories.elementAt(7),
//       elements: const [
//         {
//           'name': 'Chocolate Milkshake',
//           'quantity': '1',
//         },
//       ],
//       ratings: [
//         Rating(
//           id: 1,
//           custmer: 'Mohammed Elachyry',
//           rate: 3.5,
//         ),
//         Rating(
//           id: 2,
//           custmer: 'Mohammed Elachyry',
//           rate: 5,
//         ),
//         Rating(
//           id: 3,
//           custmer: 'Mohammed Elachyry',
//           rate: 4,
//         ),
//         Rating(
//           id: 4,
//           custmer: 'Mohammed Elachyry',
//           rate: 4.5,
//         ),
//       ],
//       price: 4.99,
//       imageUrl:
//           'https://images.unsplash.com/photo-1572490122747-3968b75cc699?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
//     ),
//     MenuItem(
//       id: 4,
//       restaurantId: 2,
//       name: 'Margherita Pizza',
//       description: 'Classic tomato sauce and mozzarella cheese pizza',
//       category: Category.categories.elementAt(1),
//       elements: const [
//         {
//           'name': 'Margherita Pizza',
//           'quantity': '1',
//         },
//         {
//           'name': 'Pepsi',
//           'quantity': '1',
//         },
//       ],
//       ratings: [
//         Rating(
//           id: 1,
//           custmer: 'Mohammed Elachyry',
//           rate: 3.5,
//         ),
//         Rating(
//           id: 2,
//           custmer: 'Mohammed Elachyry',
//           rate: 5,
//         ),
//         Rating(
//           id: 3,
//           custmer: 'Mohammed Elachyry',
//           rate: 4,
//         ),
//         Rating(
//           id: 4,
//           custmer: 'Mohammed Elachyry',
//           rate: 4.5,
//         ),
//       ],
//       price: 12.99,
//       imageUrl:
//           'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=869&q=80',
//     ),
//     MenuItem(
//       id: 5,
//       restaurantId: 2,
//       name: 'Caesar Salad',
//       description: 'Fresh romaine lettuce with Caesar dressing and croutons',
//       category: Category.categories.elementAt(5),
//       elements: const [
//         {
//           'name': 'Caesar Salad',
//           'quantity': '1',
//         },
//         {
//           'name': 'Pepsi',
//           'quantity': '1',
//         },
//       ],
//       ratings: [
//         Rating(
//           id: 1,
//           custmer: 'Mohammed Elachyry',
//           rate: 3.5,
//         ),
//         Rating(
//           id: 2,
//           custmer: 'Mohammed Elachyry',
//           rate: 5,
//         ),
//         Rating(
//           id: 3,
//           custmer: 'Mohammed Elachyry',
//           rate: 4,
//         ),
//         Rating(
//           id: 4,
//           custmer: 'Mohammed Elachyry',
//           rate: 4.5,
//         ),
//       ],
//       price: 7.99,
//       imageUrl:
//           'https://images.unsplash.com/photo-1550304943-4f24f54ddde9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
//     ),
//     MenuItem(
//       id: 6,
//       restaurantId: 2,
//       name: 'Garlic Knots',
//       description: 'Soft garlic bread knots with parsley and Parmesan cheese',
//       category: Category.categories.elementAt(1),
//       elements: const [
//         {
//           'name': 'Burger',
//           'quantity': '1',
//         },
//         {
//           'name': 'Fries',
//           'quantity': '1',
//         },
//         {
//           'name': 'Pepsi',
//           'quantity': '1',
//         },
//       ],
//       ratings: [
//         Rating(
//           id: 1,
//           custmer: 'Mohammed Elachyry',
//           rate: 3.5,
//         ),
//         Rating(
//           id: 2,
//           custmer: 'Mohammed Elachyry',
//           rate: 5,
//         ),
//         Rating(
//           id: 3,
//           custmer: 'Mohammed Elachyry',
//           rate: 4,
//         ),
//         Rating(
//           id: 4,
//           custmer: 'Mohammed Elachyry',
//           rate: 4.5,
//         ),
//       ],
//       price: 4.99,
//       imageUrl:
//           'https://images.unsplash.com/photo-1591299177061-2151e53fcaea?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=725&q=80',
//     ),
//     MenuItem(
//       id: 7,
//       restaurantId: 3,
//       name: 'California Roll',
//       description: 'Sushi roll with crab, avocado, and cucumber',
//       category: Category.categories.elementAt(8),
//       elements: const [
//         {
//           'name': 'Burger',
//           'quantity': '1',
//         },
//         {
//           'name': 'Fries',
//           'quantity': '1',
//         },
//         {
//           'name': 'Pepsi',
//           'quantity': '1',
//         },
//       ],
//       ratings: [
//         Rating(
//           id: 1,
//           custmer: 'Mohammed Elachyry',
//           rate: 3.5,
//         ),
//         Rating(
//           id: 2,
//           custmer: 'Mohammed Elachyry',
//           rate: 5,
//         ),
//         Rating(
//           id: 3,
//           custmer: 'Mohammed Elachyry',
//           rate: 4,
//         ),
//         Rating(
//           id: 4,
//           custmer: 'Mohammed Elachyry',
//           rate: 4.5,
//         ),
//       ],
//       price: 8.99,
//       imageUrl:
//           'https://images.unsplash.com/photo-1559410545-0bdcd187e0a6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
//     ),
//     MenuItem(
//       id: 8,
//       restaurantId: 1,
//       name: 'Teriyaki Chicken Bowl',
//       description: 'Rice bowl with teriyaki chicken, broccoli, and carrots',
//       category: Category.categories.elementAt(3),
//       elements: const [
//         {
//           'name': 'Teriyaki Chicken Bowl',
//           'quantity': '3',
//         },
//         {
//           'name': 'Fries',
//           'quantity': '1',
//         },
//         {
//           'name': 'Pepsi',
//           'quantity': '1',
//         },
//       ],
//       ratings: [
//         Rating(
//           id: 1,
//           custmer: 'Mohammed Elachyry',
//           rate: 3.5,
//         ),
//         Rating(
//           id: 2,
//           custmer: 'Mohammed Elachyry',
//           rate: 5,
//         ),
//         Rating(
//           id: 3,
//           custmer: 'Mohammed Elachyry',
//           rate: 4,
//         ),
//         Rating(
//           id: 4,
//           custmer: 'Mohammed Elachyry',
//           rate: 4.5,
//         ),
//       ],
//       price: 11.99,
//       imageUrl:
//           'https://images.unsplash.com/photo-1598515214211-89d3c73ae83b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
//     ),
//     MenuItem(
//       id: 9,
//       restaurantId: 4,
//       name: 'Miso Soup',
//       description: 'Traditional Japanese soup with tofu and seaweed',
//       category: Category.categories.elementAt(5),
//       elements: const [
//         {
//           'name': 'Burger',
//           'quantity': '1',
//         },
//         {
//           'name': 'Fries',
//           'quantity': '1',
//         },
//         {
//           'name': 'Pepsi',
//           'quantity': '1',
//         },
//       ],
//       ratings: [
//         Rating(
//           id: 1,
//           custmer: 'Mohammed Elachyry',
//           rate: 3.5,
//         ),
//         Rating(
//           id: 2,
//           custmer: 'Mohammed Elachyry',
//           rate: 5,
//         ),
//         Rating(
//           id: 3,
//           custmer: 'Mohammed Elachyry',
//           rate: 4,
//         ),
//         Rating(
//           id: 4,
//           custmer: 'Mohammed Elachyry',
//           rate: 4.5,
//         ),
//       ],
//       price: 3.99,
//       imageUrl:
//           'https://images.unsplash.com/photo-1591224876006-be862c0f1d7a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
//     ),
//     MenuItem(
//       id: 10,
//       restaurantId: 4,
//       name: 'Beef Tacos',
//       description: 'Soft shell tacos with seasoned beef, lettuce, and cheese',
//       category: Category.categories.elementAt(9),
//       elements: const [
//         {
//           'name': 'Beef Tacos',
//           'quantity': '1',
//         },
//         {
//           'name': 'Fries',
//           'quantity': '1',
//         },
//         {
//           'name': 'Pepsi',
//           'quantity': '1',
//         },
//       ],
//       ratings: [
//         Rating(
//           id: 1,
//           custmer: 'Mohammed Elachyry',
//           rate: 3.5,
//         ),
//         Rating(
//           id: 2,
//           custmer: 'Mohammed Elachyry',
//           rate: 5,
//         ),
//         Rating(
//           id: 3,
//           custmer: 'Mohammed Elachyry',
//           rate: 4,
//         ),
//         Rating(
//           id: 4,
//           custmer: 'Mohammed Elachyry',
//           rate: 4.5,
//         ),
//       ],
//       price: 9.99,
//       imageUrl:
//           'https://images.unsplash.com/photo-1504544750208-dc0358e63f7f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=434&q=80',
//     ),
//     MenuItem(
//       id: 11,
//       restaurantId: 5,
//       name: 'Guacamole and Chips',
//       description: 'Fresh avocado dip with tortilla chips',
//       category: Category.categories.elementAt(5),
//       elements: const [
//         {
//           'name': 'Burger',
//           'quantity': '1',
//         },
//         {
//           'name': 'Fries',
//           'quantity': '1',
//         },
//         {
//           'name': 'Pepsi',
//           'quantity': '1',
//         },
//       ],
//       ratings: [
//         Rating(
//           id: 1,
//           custmer: 'Mohammed Elachyry',
//           rate: 3.5,
//         ),
//         Rating(
//           id: 2,
//           custmer: 'Mohammed Elachyry',
//           rate: 5,
//         ),
//         Rating(
//           id: 3,
//           custmer: 'Mohammed Elachyry',
//           rate: 4,
//         ),
//         Rating(
//           id: 4,
//           custmer: 'Mohammed Elachyry',
//           rate: 4.5,
//         ),
//       ],
//       price: 6.99,
//       imageUrl:
//           'https://images.unsplash.com/photo-1523634700860-90d0ef74f137?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=725&q=80',
//     ),
//     MenuItem(
//       id: 12,
//       restaurantId: 5,
//       name: 'Churros',
//       description: 'Mexican pastry rolled in cinnamon and sugar',
//       category: Category.categories.elementAt(5),
//       elements: const [
//         {
//           'name': 'Burger',
//           'quantity': '1',
//         },
//         {
//           'name': 'Fries',
//           'quantity': '1',
//         },
//         {
//           'name': 'Pepsi',
//           'quantity': '1',
//         },
//       ],
//       ratings: [
//         Rating(
//           id: 1,
//           custmer: 'Mohammed Elachyry',
//           rate: 3.5,
//         ),
//         Rating(
//           id: 2,
//           custmer: 'Mohammed Elachyry',
//           rate: 5,
//         ),
//         Rating(
//           id: 3,
//           custmer: 'Mohammed Elachyry',
//           rate: 4,
//         ),
//         Rating(
//           id: 4,
//           custmer: 'Mohammed Elachyry',
//           rate: 4.5,
//         ),
//       ],
//       price: 4.99,
//       imageUrl:
//           'https://images.unsplash.com/photo-1624371414361-e670edf4898d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
//     ),
//   ];

  factory MenuItem.fromMap(Map<String, dynamic> map) {
    return MenuItem(
      id: map['id'] as String,
      restaurantId: map['restaurantId'] as String,
      name: map['name'] as String,
      categoryId: map['categoryId'] as String,
      description: map['description'] as String,
      elements: Map<String, String>.from((map['elements'])),
      ingredientsId: List<String>.from((map['ingredientsId'])),
      price: map['price'] as double,
      imageUrl: map['imageUrl'] as String,
      ratingsId: List<String>.from((map['ratingsId'])),
    );
  }

  factory MenuItem.fromJson(String source) =>
      MenuItem.fromMap(json.decode(source) as Map<String, dynamic>);
}

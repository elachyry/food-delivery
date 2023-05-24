import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final String imageUrl;

  const Category({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  @override
  List<Object> get props => [id, name, imageUrl];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  String toJson() => json.encode(toMap());

  factory Category.fromFirestore(DocumentSnapshot snap) {
    return Category(
      id: snap.id,
      name: snap['name'] as String,
      imageUrl: snap['imageUrl'] as String,
    );
  }
}
// static List<Category> categories = [
//     Category(
//       id: 1,
//       name: 'Burger',
//       image: Image.asset(ImageConstants.categoryBurgur),
//     ),
//     Category(
//       id: 2,
//       name: 'Pizza',
//       image: Image.asset(ImageConstants.categoryPizza),
//     ),
//     Category(
//       id: 3,
//       name: 'Coffee',
//       image: Image.asset(ImageConstants.categoryCoffee),
//     ),
//     Category(
//       id: 4,
//       name: 'Chicken',
//       image: Image.asset(ImageConstants.categoryFriedChicken),
//     ),
//     Category(
//       id: 5,
//       name: 'Salad',
//       image: Image.asset(ImageConstants.categoryBibimbap),
//     ),
//     Category(
//       id: 6,
//       name: 'Appetizers',
//       image: Image.asset(ImageConstants.categoryDonut),
//     ),
//     Category(
//       id: 7,
//       name: 'Groceries',
//       image: Image.asset(ImageConstants.categoryGroceries),
//     ),
//     Category(
//       id: 8,
//       name: 'Drinks',
//       image: Image.asset(ImageConstants.categoryGroceries),
//     ),
//     Category(
//       id: 9,
//       name: 'Sushi',
//       image: Image.asset(ImageConstants.categoryGroceries),
//     ),
//     Category(
//       id: 10,
//       name: 'Taco',
//       image: Image.asset(ImageConstants.categoryGroceries),
//     ),
//   ];
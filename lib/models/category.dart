import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:multi_languges/utils/constants/image_constants.dart';

class Category extends Equatable {
  final int id;
  final String name;
  final Image image;

  static List<Category> categories = [
    Category(
      id: 1,
      name: 'Burger',
      image: Image.asset(ImageConstants.categoryBurgur),
    ),
    Category(
      id: 2,
      name: 'Pizza',
      image: Image.asset(ImageConstants.categoryPizza),
    ),
    Category(
      id: 3,
      name: 'Coffee',
      image: Image.asset(ImageConstants.categoryCoffee),
    ),
    Category(
      id: 4,
      name: 'Chicken',
      image: Image.asset(ImageConstants.categoryFriedChicken),
    ),
    Category(
      id: 5,
      name: 'Salad',
      image: Image.asset(ImageConstants.categoryBibimbap),
    ),
    Category(
      id: 6,
      name: 'Appetizers',
      image: Image.asset(ImageConstants.categoryDonut),
    ),
    Category(
      id: 7,
      name: 'Groceries',
      image: Image.asset(ImageConstants.categoryGroceries),
    ),
    Category(
      id: 8,
      name: 'Drinks',
      image: Image.asset(ImageConstants.categoryGroceries),
    ),
    Category(
      id: 9,
      name: 'Sushi',
      image: Image.asset(ImageConstants.categoryGroceries),
    ),
    Category(
      id: 10,
      name: 'Taco',
      image: Image.asset(ImageConstants.categoryGroceries),
    ),
  ];

  Category({
    required this.id,
    required this.name,
    required this.image,
  });

  @override
  List<Object?> get props => [id, name, image];
}
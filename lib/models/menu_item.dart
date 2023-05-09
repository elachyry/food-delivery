import 'package:equatable/equatable.dart';
import 'package:multi_languges/models/category.dart';
import 'package:multi_languges/models/ingredient.dart';

class MenuItem extends Equatable {
  final int id;
  final int restaurantId;
  final String name;
  final Category category;
  final String description;
  final List<Map<String, String>> elements;
  final List<Ingredient> ingredients;
  final double price;
  final String imageUrl;

  static final menuItems = [
    MenuItem(
      id: 1,
      restaurantId: 3,
      name: 'Cheeseburger',
      description: 'A juicy burger with melted cheese',
      category: Category.categories.elementAt(0),
      elements: const [
        {
          'name': 'Burger',
          'quantity': '1',
        },
        {
          'name': 'Fries',
          'quantity': '1',
        },
        {
          'name': 'Pepsi',
          'quantity': '1',
        },
      ],
      price: 8.99,
      imageUrl:
          'https://images.unsplash.com/photo-1572802419224-296b0aeee0d9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=815&q=80',
    ),
    MenuItem(
      id: 2,
      restaurantId: 1,
      name: 'Fries',
      description: 'Crispy golden fries',
      category: Category.categories.elementAt(5),
      elements: const [
        {
          'name': 'Fries',
          'quantity': '1',
        },
      ],
      price: 2.99,
      imageUrl:
          'https://images.unsplash.com/photo-1518013431117-eb1465fa5752?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    ),
    MenuItem(
      id: 3,
      restaurantId: 1,
      name: 'Chocolate Milkshake',
      description: 'Creamy chocolate goodness',
      category: Category.categories.elementAt(7),
      elements: const [
        {
          'name': 'Chocolate Milkshake',
          'quantity': '1',
        },
      ],
      price: 4.99,
      imageUrl:
          'https://images.unsplash.com/photo-1572490122747-3968b75cc699?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
    ),
    MenuItem(
      id: 4,
      restaurantId: 2,
      name: 'Margherita Pizza',
      description: 'Classic tomato sauce and mozzarella cheese pizza',
      category: Category.categories.elementAt(1),
      elements: const [
        {
          'name': 'Margherita Pizza',
          'quantity': '1',
        },
        {
          'name': 'Pepsi',
          'quantity': '1',
        },
      ],
      price: 12.99,
      imageUrl:
          'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=869&q=80',
    ),
    MenuItem(
      id: 5,
      restaurantId: 2,
      name: 'Caesar Salad',
      description: 'Fresh romaine lettuce with Caesar dressing and croutons',
      category: Category.categories.elementAt(5),
      elements: const [
        {
          'name': 'Caesar Salad',
          'quantity': '1',
        },
        {
          'name': 'Pepsi',
          'quantity': '1',
        },
      ],
      price: 7.99,
      imageUrl:
          'https://images.unsplash.com/photo-1550304943-4f24f54ddde9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    ),
    MenuItem(
      id: 6,
      restaurantId: 2,
      name: 'Garlic Knots',
      description: 'Soft garlic bread knots with parsley and Parmesan cheese',
      category: Category.categories.elementAt(1),
      elements: const [
        {
          'name': 'Burger',
          'quantity': '1',
        },
        {
          'name': 'Fries',
          'quantity': '1',
        },
        {
          'name': 'Pepsi',
          'quantity': '1',
        },
      ],
      price: 4.99,
      imageUrl:
          'https://images.unsplash.com/photo-1591299177061-2151e53fcaea?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=725&q=80',
    ),
    MenuItem(
      id: 7,
      restaurantId: 3,
      name: 'California Roll',
      description: 'Sushi roll with crab, avocado, and cucumber',
      category: Category.categories.elementAt(8),
      elements: const [
        {
          'name': 'Burger',
          'quantity': '1',
        },
        {
          'name': 'Fries',
          'quantity': '1',
        },
        {
          'name': 'Pepsi',
          'quantity': '1',
        },
      ],
      price: 8.99,
      imageUrl:
          'https://images.unsplash.com/photo-1559410545-0bdcd187e0a6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    ),
    MenuItem(
      id: 8,
      restaurantId: 1,
      name: 'Teriyaki Chicken Bowl',
      description: 'Rice bowl with teriyaki chicken, broccoli, and carrots',
      category: Category.categories.elementAt(3),
      elements: const [
        {
          'name': 'Teriyaki Chicken Bowl',
          'quantity': '3',
        },
        {
          'name': 'Fries',
          'quantity': '1',
        },
        {
          'name': 'Pepsi',
          'quantity': '1',
        },
      ],
      price: 11.99,
      imageUrl:
          'https://images.unsplash.com/photo-1598515214211-89d3c73ae83b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    ),
    MenuItem(
      id: 9,
      restaurantId: 4,
      name: 'Miso Soup',
      description: 'Traditional Japanese soup with tofu and seaweed',
      category: Category.categories.elementAt(5),
      elements: const [
        {
          'name': 'Burger',
          'quantity': '1',
        },
        {
          'name': 'Fries',
          'quantity': '1',
        },
        {
          'name': 'Pepsi',
          'quantity': '1',
        },
      ],
      price: 3.99,
      imageUrl:
          'https://images.unsplash.com/photo-1591224876006-be862c0f1d7a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    ),
    MenuItem(
      id: 10,
      restaurantId: 4,
      name: 'Beef Tacos',
      description: 'Soft shell tacos with seasoned beef, lettuce, and cheese',
      category: Category.categories.elementAt(9),
      elements: const [
        {
          'name': 'Beef Tacos',
          'quantity': '1',
        },
        {
          'name': 'Fries',
          'quantity': '1',
        },
        {
          'name': 'Pepsi',
          'quantity': '1',
        },
      ],
      price: 9.99,
      imageUrl:
          'https://images.unsplash.com/photo-1504544750208-dc0358e63f7f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=434&q=80',
    ),
    MenuItem(
      id: 11,
      restaurantId: 5,
      name: 'Guacamole and Chips',
      description: 'Fresh avocado dip with tortilla chips',
      category: Category.categories.elementAt(5),
      elements: const [
        {
          'name': 'Burger',
          'quantity': '1',
        },
        {
          'name': 'Fries',
          'quantity': '1',
        },
        {
          'name': 'Pepsi',
          'quantity': '1',
        },
      ],
      price: 6.99,
      imageUrl:
          'https://images.unsplash.com/photo-1523634700860-90d0ef74f137?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=725&q=80',
    ),
    MenuItem(
      id: 12,
      restaurantId: 5,
      name: 'Churros',
      description: 'Mexican pastry rolled in cinnamon and sugar',
      category: Category.categories.elementAt(5),
      elements: const [
        {
          'name': 'Burger',
          'quantity': '1',
        },
        {
          'name': 'Fries',
          'quantity': '1',
        },
        {
          'name': 'Pepsi',
          'quantity': '1',
        },
      ],
      price: 4.99,
      imageUrl:
          'https://images.unsplash.com/photo-1624371414361-e670edf4898d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    ),
  ];

  MenuItem({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.description,
    required this.category,
    required this.elements,
    this.ingredients = const [],
    required this.price,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        imageUrl,
        price,
        restaurantId,
      ];
}

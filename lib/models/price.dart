import 'package:equatable/equatable.dart';

class Price extends Equatable {
  final int id;
  final String price;
  static List<Price> prices = const [
    Price(
      id: 1,
      price: 'Low',
    ),
    Price(
      id: 2,
      price: 'Medium',
    ),
    Price(
      id: 3,
      price: 'High',
    ),
  ];

  const Price({
    required this.id,
    required this.price,
  });

  @override
  List<Object?> get props => [
        id,
        price,
      ];
}

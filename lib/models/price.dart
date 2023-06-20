import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

class Price extends Equatable {
  final int id;
  final String price;
  static List<Price> prices = [
    Price(
      id: 1,
      price: 'low'.tr,
    ),
    Price(
      id: 2,
      price: 'medium'.tr,
    ),
    Price(
      id: 3,
      price: 'high'.tr,
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

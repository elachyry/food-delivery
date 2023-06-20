import 'package:equatable/equatable.dart';
import 'package:food_delivery_express/models/price.dart';

class PriceFilter extends Equatable {
  final int id;
  final Price price;
  final bool value;

  static List<PriceFilter> filters = Price.prices
      .map(
        (e) => PriceFilter(
          id: e.id,
          price: e,
          value: false,
        ),
      )
      .toList();

  PriceFilter({
    required this.id,
    required this.price,
    required this.value,
  });

  PriceFilter copyWith({
    int? id,
    Price? price,
    bool? value,
  }) {
    return PriceFilter(
        id: id ?? this.id,
        price: price ?? this.price,
        value: value ?? this.value);
  }

  @override
  List<Object?> get props => [
        id,
        price,
        value,
      ];
}

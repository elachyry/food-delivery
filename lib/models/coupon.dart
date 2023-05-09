import 'package:equatable/equatable.dart';

class Coupon extends Equatable {
  final int id;
  final String title;
  final String subtitle;
  final String validation;
  final String code;
  final String discount;

  static final List<Coupon> coupons = [
    Coupon(
      id: 1,
      title: 'OFF',
      subtitle: 'SUMMER IS \nHERE',
      validation: 'Valid Till - 30 May 2023',
      code: 'FREESALES',
      discount: '23%',
    ),
    Coupon(
      id: 2,
      title: 'OFF',
      subtitle: 'SUMMER IS \nHERE',
      validation: 'Valid Till - 20 Jun 2023',
      code: 'CODE10',
      discount: '10%',
    ),
    Coupon(
      id: 3,
      title: 'OFF',
      subtitle: 'SUMMER IS \nHERE',
      validation: 'Valid Till - 25 May 2023',
      code: 'FREESHIP',
      discount: '100%',
    ),
  ];

  Coupon({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.validation,
    required this.code,
    required this.discount,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        subtitle,
        validation,
        code,
        discount,
      ];
}

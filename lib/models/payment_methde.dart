import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:multi_languges/utils/constants/image_constants.dart';

class PaymentMethode extends Equatable {
  final String id;
  final String name;
  final Image image;

  const PaymentMethode({
    required this.id,
    required this.name,
    required this.image,
  });

  static final List<PaymentMethode> paymentMethodes = [
    const PaymentMethode(
      id: '0',
      name: 'Cash on Delivery',
      image: Image(
        image: AssetImage(
          ImageConstants.cashOnDelivery,
        ),
      ),
    ),
  ];

  @override
  List<Object?> get props => [
        id,
        name,
        image,
      ];
}

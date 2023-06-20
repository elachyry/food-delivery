import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_delivery_express/utils/constants/image_constants.dart';

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
    PaymentMethode(
      id: '0',
      name: 'cash_on_delivery'.tr,
      image: const Image(
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

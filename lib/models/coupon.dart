// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Coupon extends Equatable {
  final String id;
  final String title;
  final DateTime validation;
  final String code;
  final double discount;
  final double conditionAmount;

  const Coupon({
    required this.id,
    required this.title,
    required this.validation,
    required this.code,
    required this.discount,
    required this.conditionAmount,
  });

  Coupon copyWith({
    String? id,
    String? title,
    DateTime? validation,
    String? code,
    double? discount,
    double? conditionAmount,
  }) {
    return Coupon(
      id: id ?? this.id,
      title: title ?? this.title,
      validation: validation ?? this.validation,
      code: code ?? this.code,
      discount: discount ?? this.discount,
      conditionAmount: conditionAmount ?? this.conditionAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'validation': validation.millisecondsSinceEpoch,
      'code': code,
      'discount': discount,
      'conditionAmount': conditionAmount,
    };
  }

  factory Coupon.fromFirestore(DocumentSnapshot snap) {
    return Coupon(
      id: snap.id,
      title: snap['title'] as String,
      validation: DateTime.parse(snap['validation']),
      code: snap['code'] as String,
      discount: snap['discount'].toDouble(),
      conditionAmount: snap['conditionAmount'].toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      title,
      validation,
      code,
      discount,
      conditionAmount,
    ];
  }

  static final List<Coupon> coupons = [
    Coupon(
      id: '1',
      title: 'OFF',
      validation: DateTime.parse('2023-05-30'),
      code: 'FREESALES23',
      discount: 100,
      conditionAmount: 1000,
    ),
    Coupon(
      id: '2',
      title: 'OFF',
      validation: DateTime.parse('2023-06-20'),
      code: 'CODEFOOD10',
      discount: 25,
      conditionAmount: 250,
    ),
    Coupon(
      id: '3',
      title: 'OFF',
      validation: DateTime.parse('2023-05-25'),
      code: 'CODEFOOD14',
      discount: 50,
      conditionAmount: 400,
    ),
  ];

  factory Coupon.fromMap(Map<String, dynamic> map) {
    return Coupon(
      id: map['id'] as String,
      title: map['title'] as String,
      validation: DateTime.parse(map['validation']),
      code: map['code'] as String,
      discount: map['discount'] as double,
      conditionAmount: map['conditionAmount'] as double,
    );
  }

  factory Coupon.fromJson(String source) =>
      Coupon.fromMap(json.decode(source) as Map<String, dynamic>);
}

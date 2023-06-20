import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

class Popular extends Equatable {
  final int id;
  final String popular;

  static List<Popular> populars = [
    Popular(
      id: 1,
      popular: 'top_rated'.tr,
    ),
    Popular(
      id: 2,
      popular: 'free_delivery'.tr,
    ),
    Popular(
      id: 3,
      popular: 'fast_delivery'.tr,
    ),
    Popular(
      id: 4,
      popular: 'new_added'.tr,
    ),
  ];

  Popular({
    required this.id,
    required this.popular,
  });

  @override
  List<Object?> get props => [
        id,
        popular,
      ];
}

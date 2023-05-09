import 'package:equatable/equatable.dart';

class Popular extends Equatable {
  final int id;
  final String popular;

  static List<Popular> populars = [
    Popular(
      id: 1,
      popular: 'Top rated',
    ),
    Popular(
      id: 2,
      popular: 'Free delivery',
    ),
    Popular(
      id: 3,
      popular: 'Fast delivery',
    ),
    Popular(
      id: 4,
      popular: 'New added',
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

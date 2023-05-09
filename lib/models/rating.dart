import 'package:equatable/equatable.dart';

class Rating extends Equatable {
  final int id;
  final String custmer;
  final double rate;

  Rating({
    required this.id,
    required this.custmer,
    required this.rate,
  });

  @override
  List<Object?> get props => [
        id,
        custmer,
        rate,
      ];
}

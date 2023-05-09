import 'package:equatable/equatable.dart';
import 'package:multi_languges/models/popular.dart';

class PopularFilters extends Equatable {
  final int id;
  final Popular popular;
  final bool value;

  static List<PopularFilters> filters = Popular.populars
      .map(
        (e) => PopularFilters(
          id: e.id,
          popular: e,
          value: false,
        ),
      )
      .toList();

  const PopularFilters({
    required this.id,
    required this.popular,
    required this.value,
  });

  PopularFilters copyWith({
    int? id,
    Popular? popular,
    bool? value,
  }) {
    return PopularFilters(
      id: id ?? this.id,
      popular: popular ?? this.popular,
      value: value ?? this.value,
    );
  }

  @override
  List<Object?> get props => [
        id,
        popular,
        value,
      ];
}

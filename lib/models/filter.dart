import 'package:equatable/equatable.dart';
import 'package:food_delivery_express/models/category_filter.dart';
import 'package:food_delivery_express/models/popular_filters.dart';
import 'package:food_delivery_express/models/price_filter.dart';

class Filter extends Equatable {
  final List<CategoryFilter> categoryFilters;
  final List<PriceFilter> priceFilters;
  final List<PopularFilters> popularFilters;

  const Filter({
    this.categoryFilters = const <CategoryFilter>[],
    this.priceFilters = const <PriceFilter>[],
    this.popularFilters = const <PopularFilters>[],
  });

  Filter copyWith({
    List<CategoryFilter>? categoryFilters,
    List<PriceFilter>? priceFilters,
    List<PopularFilters>? popularFilters,
  }) {
    return Filter(
      categoryFilters: categoryFilters ?? this.categoryFilters,
      priceFilters: priceFilters ?? this.priceFilters,
      popularFilters: popularFilters ?? this.popularFilters,
    );
  }

  @override
  List<Object?> get props => [categoryFilters, priceFilters, popularFilters];
}

part of 'filters_bloc.dart';

abstract class FiltersEvent extends Equatable {
  const FiltersEvent();

  @override
  List<Object> get props => [];
}

class FilterLoad extends FiltersEvent {
  @override
  List<Object> get props => [];
}

class CategoryFilterUpdate extends FiltersEvent {
  final CategoryFilter categoryFilter;

  const CategoryFilterUpdate({required this.categoryFilter});
  @override
  List<Object> get props => [categoryFilter];
}

class PriceFilterUpdate extends FiltersEvent {
  final PriceFilter priceFilter;

  const PriceFilterUpdate({required this.priceFilter});
  @override
  List<Object> get props => [priceFilter];
}

class PopularFiltersUpdate extends FiltersEvent {
  final PopularFilters popularFilters;

  const PopularFiltersUpdate({required this.popularFilters});
  @override
  List<Object> get props => [popularFilters];
}

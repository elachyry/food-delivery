import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:multi_languges/models/category_filter.dart';
import 'package:multi_languges/models/filter.dart';
import 'package:multi_languges/models/popular_filters.dart';
import 'package:multi_languges/models/price_filter.dart';

part 'filters_event.dart';
part 'filters_state.dart';

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  FiltersBloc() : super(FiltersLoading());

  @override
  Stream<FiltersState> mapEventToState(FiltersEvent event) async* {
    if (event is FilterLoad) {
      yield* _mapFilterLoadToState();
    } else if (event is CategoryFilterUpdate) {
      yield* _mapCategoryFilterUpdateToState(event, state);
    } else if (event is PriceFilterUpdate) {
      yield* _mapPriceFilterUpdateToState(event, state);
    } else if (event is PopularFiltersUpdate) {
      yield* _mapPopularFiltersUpdateToState(event, state);
    }
  }
}

Stream<FiltersState> _mapFilterLoadToState() async* {
  yield FiltersLoaded(
    filter: Filter(
      categoryFilters: CategoryFilter.filters,
      priceFilters: PriceFilter.filters,
      popularFilters: PopularFilters.filters,
    ),
  );
}

Stream<FiltersState> _mapCategoryFilterUpdateToState(
    CategoryFilterUpdate event, FiltersState state) async* {
  if (state is FiltersLoaded) {
    final List<CategoryFilter> updatedCategoryFilters =
        state.filter.categoryFilters.map((e) {
      return e.id == event.categoryFilter.id ? event.categoryFilter : e;
    }).toList();
    yield FiltersLoaded(
      filter: Filter(
        categoryFilters: updatedCategoryFilters,
        priceFilters: state.filter.priceFilters,
        popularFilters: state.filter.popularFilters,
      ),
    );
  }
}

Stream<FiltersState> _mapPriceFilterUpdateToState(
    PriceFilterUpdate event, FiltersState state) async* {
  if (state is FiltersLoaded) {
    final List<PriceFilter> updatedPriceFilters =
        state.filter.priceFilters.map((e) {
      return e.id == event.priceFilter.id ? event.priceFilter : e;
    }).toList();
    yield FiltersLoaded(
      filter: Filter(
        categoryFilters: state.filter.categoryFilters,
        priceFilters: updatedPriceFilters,
        popularFilters: state.filter.popularFilters,
      ),
    );
  }
}

Stream<FiltersState> _mapPopularFiltersUpdateToState(
    PopularFiltersUpdate event, FiltersState state) async* {
  if (state is FiltersLoaded) {
    final List<PopularFilters> updatedPopularFilters =
        state.filter.popularFilters.map((e) {
      return e.id == event.popularFilters.id ? event.popularFilters : e;
    }).toList();
    yield FiltersLoaded(
      filter: Filter(
        categoryFilters: state.filter.categoryFilters,
        priceFilters: state.filter.priceFilters,
        popularFilters: updatedPopularFilters,
      ),
    );
  }
}
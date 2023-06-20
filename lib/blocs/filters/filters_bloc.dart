import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:food_delivery_express/models/category_filter.dart';
import 'package:food_delivery_express/models/filter.dart';
import 'package:food_delivery_express/models/popular_filters.dart';
import 'package:food_delivery_express/models/price_filter.dart';

import '../../controllers/category_controller.dart';

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

final categoryContoller = Get.put(CategoryController());

Stream<FiltersState> _mapFilterLoadToState() async* {
  yield FiltersLoaded(
    filter: Filter(
      categoryFilters: categoryContoller.categories.map((e) {
        return CategoryFilter(
          id: e.id,
          category: e,
          value: false,
        );
      }).toList(),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../blocs/filters/filters_bloc.dart';

class CustomPriceFilter extends StatelessWidget {
  const CustomPriceFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiltersBloc, FiltersState>(builder: (context, state) {
      if (state is FiltersLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is FiltersLoaded) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: state.filter.priceFilters
              .asMap()
              .entries
              .map((e) => GestureDetector(
                    onTap: () {
                      context.read<FiltersBloc>().add(
                            PriceFilterUpdate(
                              priceFilter: state.filter.priceFilters[e.key]
                                  .copyWith(
                                      value: !state
                                          .filter.priceFilters[e.key].value),
                            ),
                          );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      margin: const EdgeInsets.only(top: 25, bottom: 10),
                      decoration: BoxDecoration(
                          color: state.filter.priceFilters[e.key].value
                              ? Theme.of(context).primaryColor.withOpacity(0.8)
                              : Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(state.filter.priceFilters[e.key].price.price),
                    ),
                  ))
              .toList(),
        );
      } else {
        return Center(
          child: Text('an_error_occurred_please_try_again_later'.tr),
        );
      }
    });
  }
}

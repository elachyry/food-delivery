import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:food_delivery_express/blocs/filters/filters_bloc.dart';

import '../../widgets/filter/show_filter_modal_bottom_sheet.dart';

class CustomPopularFilters extends StatelessWidget {
  const CustomPopularFilters({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiltersBloc, FiltersState>(
      builder: (context, state) {
        if (state is FiltersLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FiltersLoaded) {
          return Column(
            children: state.filter.popularFilters.asMap().entries.map((e) {
              return Column(
                children: [
                  filterBuilder(
                    state.filter.popularFilters[e.key].popular.popular,
                    state.filter.popularFilters[e.key].value,
                    (value) {
                      context.read<FiltersBloc>().add(
                            PopularFiltersUpdate(
                              popularFilters: state.filter.popularFilters[e.key]
                                  .copyWith(
                                      value: !state
                                          .filter.popularFilters[e.key].value),
                            ),
                          );
                    },
                  ),
                  const Divider()
                ],
              );
            }).toList(),
            // children: [

            //   filterBuilder('Top rated', false, (value) {}),
            //   const Divider(),
            //   filterBuilder('Free delivery', false, (value) {}),
            //   const Divider(),
            //   filterBuilder('Fast delivery', false, (value) {}),
            //   const Divider(),
            //   filterBuilder('New added', false, (value) {}),
            //   const Divider(),
            // ],
          );
        } else {
          return Center(
            child: Text('an_error_occurred_please_try_again_later'.tr),
          );
        }
      },
    );
  }
}

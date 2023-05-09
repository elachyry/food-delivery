import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../blocs/filters/filters_bloc.dart';
import '../../widgets/filter/show_filter_modal_bottom_sheet.dart';

class CustomCategoryFilter extends StatelessWidget {
  const CustomCategoryFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiltersBloc, FiltersState>(
      builder: (context, state) {
        if (state is FiltersLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FiltersLoaded) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.71,
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: state.filter.categoryFilters.length,
              itemBuilder: (context, index) => SizedBox(
                width: double.infinity,
                child: filterBuilder(
                    state.filter.categoryFilters[index].category.name,
                    state.filter.categoryFilters[index].value, (value) {
                  context.read<FiltersBloc>().add(
                        CategoryFilterUpdate(
                          categoryFilter:
                              state.filter.categoryFilters[index].copyWith(
                            value: !state.filter.categoryFilters[index].value,
                          ),
                        ),
                      );
                }),
              ),
            ),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:multi_languges/blocs/autocomplete/autocomplete_bloc.dart';

class LocationSearchBox extends StatelessWidget {
  const LocationSearchBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AutocompleteBloc, AutocompleteState>(
      builder: (context, state) {
        if (state is AutocompleteLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AutocompleteLoaded) {
          return Padding(
            padding:
                const EdgeInsets.only(top: 12, right: 12, left: 12, bottom: 5),
            child: TextField(
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                hintText: 'enter_your_location'.tr,
                contentPadding:
                    const EdgeInsets.only(bottom: 5, right: 5, left: 20),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white),
                ),
              ),
              onChanged: (value) {
                print(value);
                context
                    .read<AutocompleteBloc>()
                    .add(LoadAutocomplete(input: value));
              },
            ),
          );
        } else {
          return Text('an_error_occurred_please_try_again_later'.tr);
        }
      },
    );
  }
}

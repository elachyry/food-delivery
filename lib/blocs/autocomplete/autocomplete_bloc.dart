import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_express/models/place_autocomplete.dart';
import 'package:food_delivery_express/repositories/place/place_repository.dart';

part 'autocomplete_event.dart';
part 'autocomplete_state.dart';

class AutocompleteBloc extends Bloc<AutocompleteEvent, AutocompleteState> {
  final PlaceRepository _placeRepository;
  StreamSubscription? _placeSubscription;

  AutocompleteBloc({required PlaceRepository placeRepository})
      : _placeRepository = placeRepository,
        super(AutocompleteLoading());

  @override
  Stream<AutocompleteState> mapEventToState(AutocompleteEvent event) async* {
    if (event is LoadAutocomplete) {
      yield* _mapLoadAutocomplateToState(event);
    }
  }

  Stream<AutocompleteState> _mapLoadAutocomplateToState(
      LoadAutocomplete event) async* {
    _placeSubscription?.cancel();
    final List<PlaceAutoComplete> autocomplete =
        await _placeRepository.getAutocomplete(event.input);
    yield AutocompleteLoaded(autocomplete: autocomplete);
  }
}

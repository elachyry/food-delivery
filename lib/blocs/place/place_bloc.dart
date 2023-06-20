import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_express/models/place.dart';
import 'package:food_delivery_express/repositories/place/place_repository.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final PlaceRepository _placeRepository;
  StreamSubscription? _placeSubscription;
  PlaceBloc({required PlaceRepository placeRepository})
      : _placeRepository = placeRepository,
        super(PlaceLoading());

  @override
  Stream<PlaceState> mapEventToState(PlaceEvent event) async* {
    if (event is LoadPlace) {
      yield* _mapLoadPlaceToState(event);
    }
  }

  Stream<PlaceState> _mapLoadPlaceToState(LoadPlace event) async* {
    yield PlaceLoading();
    try {
      _placeSubscription?.cancel();
      final Place place = await _placeRepository.getPlace(event.id);
      print('place = ${place.name}');
      yield PlaceLoaded(place: place);
    } catch (_) {}
  }

  @override
  Future<void> close() {
    _placeSubscription?.cancel();
    return super.close();
  }
}

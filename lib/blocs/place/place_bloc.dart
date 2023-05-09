import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:multi_languges/models/place.dart';
import 'package:multi_languges/repositories/place/place_repository.dart';

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
      print('event is PlaceLoaded');
      yield* _mapLoadPlaceToState(event);
    }
  }

  Stream<PlaceState> _mapLoadPlaceToState(LoadPlace event) async* {
    yield PlaceLoading();
    try {
      _placeSubscription?.cancel();
      final Place place = await _placeRepository.getPlace(event.id);
      yield PlaceLoaded(place: place);
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<void> close() {
    _placeSubscription?.cancel();
    return super.close();
  }
}

part of 'place_bloc.dart';

abstract class PlaceEvent extends Equatable {
  const PlaceEvent();

  @override
  List<Object> get props => [];
}

class LoadPlace extends PlaceEvent {
  final String id;

  const LoadPlace({required this.id});

  @override
  List<Object> get props => [id];
}

part of 'favorites_bloc.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<String> favorites;

  const FavoritesLoaded(this.favorites);

  @override
  List<Object> get props => [favorites];
}

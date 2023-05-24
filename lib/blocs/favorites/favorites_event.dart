part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class LoadFavoritesEvent extends FavoritesEvent {}

class AddFavoriteEvent extends FavoritesEvent {
  final String id;

  const AddFavoriteEvent(this.id);

  @override
  List<Object> get props => [id];
}

class RemoveFavoriteEvent extends FavoritesEvent {
  final String id;

  const RemoveFavoriteEvent(this.id);

  @override
  List<Object> get props => [id];
}

class LoadFavoritesMenuItemEvent extends FavoritesEvent {}

class AddFavoriteMenuItemEvent extends FavoritesEvent {
  final String id;

  const AddFavoriteMenuItemEvent(this.id);

  @override
  List<Object> get props => [id];
}

class RemoveFavoriteMenuItemEvent extends FavoritesEvent {
  final String id;

  const RemoveFavoriteMenuItemEvent(this.id);

  @override
  List<Object> get props => [id];
}

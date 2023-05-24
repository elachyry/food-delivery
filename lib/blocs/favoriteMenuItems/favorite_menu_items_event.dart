part of 'favorite_menu_items_bloc.dart';

abstract class FavoriteMenuItemsEvent extends Equatable {
  const FavoriteMenuItemsEvent();

  @override
  List<Object> get props => [];
}

class LoadFavoritesMenuItemsEvent extends FavoriteMenuItemsEvent {}

class AddFavoriteMenuItemsEvent extends FavoriteMenuItemsEvent {
  final String id;

  const AddFavoriteMenuItemsEvent(this.id);

  @override
  List<Object> get props => [id];
}

class RemoveFavoriteMenuItemsEvent extends FavoriteMenuItemsEvent {
  final String id;

  const RemoveFavoriteMenuItemsEvent(this.id);

  @override
  List<Object> get props => [id];
}

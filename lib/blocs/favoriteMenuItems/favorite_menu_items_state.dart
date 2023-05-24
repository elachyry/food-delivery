part of 'favorite_menu_items_bloc.dart';

abstract class FavoriteMenuItemsState extends Equatable {
  const FavoriteMenuItemsState();

  @override
  List<Object> get props => [];
}

class FavoriteMenuItemsLoading extends FavoriteMenuItemsState {}

class FavoriteMenuItemsLoaded extends FavoriteMenuItemsState {
  final List<String> favorites;

  const FavoriteMenuItemsLoaded(this.favorites);

  @override
  List<Object> get props => [favorites];
}

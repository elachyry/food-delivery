import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/user_reposityory.dart';

part 'favorite_menu_items_event.dart';
part 'favorite_menu_items_state.dart';

class FavoriteMenuItemsBloc
    extends Bloc<FavoriteMenuItemsEvent, FavoriteMenuItemsState> {
  final UserRepository favoritesRepository;

  FavoriteMenuItemsBloc(this.favoritesRepository)
      : super(FavoriteMenuItemsLoading());
  @override
  Stream<FavoriteMenuItemsState> mapEventToState(
      FavoriteMenuItemsEvent event) async* {
    if (event is LoadFavoritesMenuItemsEvent) {
      yield* _mapLoadFavoriteMenuItemsEventToState();
    } else if (event is AddFavoriteMenuItemsEvent) {
      yield* _mapAddFavoriteMenuItemEventToState(event);
    } else if (event is RemoveFavoriteMenuItemsEvent) {
      yield* _mapRemoveFavoriteMenuItemEventToState(event);
    }
  }

  Stream<FavoriteMenuItemsState>
      _mapLoadFavoriteMenuItemsEventToState() async* {
    yield FavoriteMenuItemsLoading();

    try {
      final List<String> favorites =
          await favoritesRepository.getFavoriteMenuItems();

      yield FavoriteMenuItemsLoaded(favorites);
    } catch (error) {
      // Handle error
      // print('Failed to load favorites: $error');
    }
  }

  Stream<FavoriteMenuItemsState> _mapAddFavoriteMenuItemEventToState(
      AddFavoriteMenuItemsEvent event) async* {
    try {
      await favoritesRepository.toggleFavoriteMenuItem(event.id, true);

      yield* _mapLoadFavoriteMenuItemsEventToState();
    } catch (error) {
      // Handle error
    }
  }

  Stream<FavoriteMenuItemsState> _mapRemoveFavoriteMenuItemEventToState(
      RemoveFavoriteMenuItemsEvent event) async* {
    try {
      await favoritesRepository.toggleFavoriteMenuItem(event.id, false);
      yield* _mapLoadFavoriteMenuItemsEventToState();
    } catch (error) {
      // Handle error
    }
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/user_reposityory.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final UserRepository favoritesRepository;
  FavoritesBloc(this.favoritesRepository) : super(FavoritesLoading());

  @override
  Stream<FavoritesState> mapEventToState(FavoritesEvent event) async* {
    if (event is LoadFavoritesEvent) {
      yield* _mapLoadFavoritesEventToState();
    } else if (event is AddFavoriteEvent) {
      yield* _mapAddFavoriteEventToState(event);
    } else if (event is RemoveFavoriteEvent) {
      yield* _mapRemoveFavoriteEventToState(event);
    }
  }

  Stream<FavoritesState> _mapLoadFavoritesEventToState() async* {
    yield FavoritesLoading();

    try {
      final List<String> favorites =
          await favoritesRepository.getFavoriteRestaurants();
      yield FavoritesLoaded(favorites);
    } catch (error) {
      // Handle error
    }
  }

  Stream<FavoritesState> _mapAddFavoriteEventToState(
      AddFavoriteEvent event) async* {
    try {
      await favoritesRepository.toggleFavoriteRestaurant(event.id, true);
      yield* _mapLoadFavoritesEventToState();
    } catch (error) {
      // Handle error
      // print('Failed to add favorite: $error');
    }
  }

  Stream<FavoritesState> _mapRemoveFavoriteEventToState(
      RemoveFavoriteEvent event) async* {
    try {
      await favoritesRepository.toggleFavoriteRestaurant(event.id, false);
      yield* _mapLoadFavoritesEventToState();
    } catch (error) {
      // Handle error
      // print('Failed to remove favorite: $error');
    }
  }
}

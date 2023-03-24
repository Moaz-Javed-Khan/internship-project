part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();
}

class FavoriteItemAdded extends FavoritesEvent {
  const FavoriteItemAdded(this.favoriteItem);

  final ProductModel favoriteItem;

  @override
  List<Object> get props => [favoriteItem];
}

class FavoriteItemRemoved extends FavoritesEvent {
  const FavoriteItemRemoved(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}

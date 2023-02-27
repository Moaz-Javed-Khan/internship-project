part of 'favorites_bloc.dart';

class FavoritesState extends Equatable {
  const FavoritesState({
    this.favoriteItem = const [],
  });

  final List<ProductModel> favoriteItem;

  FavoritesState copyWith({List<ProductModel>? item}) {
    return FavoritesState(favoriteItem: item ?? favoriteItem);
  }

  @override
  List<Object> get props => [favoriteItem];
}

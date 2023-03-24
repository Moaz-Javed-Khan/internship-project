part of 'favorites_bloc.dart';

enum FavoritesStatus {
  initialState,
  loadingState,
  loadedState,
  errorState,
}

class FavoritesState extends Equatable {
  const FavoritesState({this.userFavorites = const {}});

  final Map<String, List<ProductModel>> userFavorites;

  FavoritesState copyWith({Map<String, List<ProductModel>>? userFavorites}) {
    return FavoritesState(userFavorites: userFavorites ?? this.userFavorites);
  }

  factory FavoritesState.fromJson(Map<String, dynamic> json) => FavoritesState(
        userFavorites: (json['userFavorites'] as Map).map(
          (key, value) => MapEntry(
            key,
            (value as List).map((e) => ProductModel.fromJson(e)).toList(),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        'userFavorites': userFavorites.map((key, value) =>
            MapEntry(key, value.map((e) => e.toJson()).toList()))
      };

  List<ProductModel> get favoriteItem {
    var uid2 = FirebaseAuth.instance.currentUser!.uid;
    print("Getter Current User ID: $uid2");
    return userFavorites[uid2] ?? [];
  }

  User? get currentUser => FirebaseAuth.instance.currentUser;

  @override
  List<Object> get props => [userFavorites];
}

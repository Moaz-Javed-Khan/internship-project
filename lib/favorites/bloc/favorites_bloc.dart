import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:internship_project/models/product_model.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends HydratedBloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(const FavoritesState()) {
    on<FavoriteItemAdded>((event, emit) async {
      if (state.currentUser?.uid == null) return;
      final a =
          state.userFavorites[state.currentUser!.uid]?.map((e) => e).toList();

      if (a != null) {
        final itemExists =
            a.any((item) => item.name == event.favoriteItem.name);
        if (!itemExists) {
          a.add(event.favoriteItem);
        }
      }

      final b = state.userFavorites.map((key, value) => MapEntry(key, value));

      b[state.currentUser!.uid] = a ?? [event.favoriteItem];

      emit(state.copyWith(userFavorites: b));
    });
    on<FavoriteItemRemoved>((event, emit) async {
      final itemFound = state.userFavorites[state.currentUser!.uid]
          ?.where((item) => item.id == event.id);

      if (itemFound == null || itemFound.isEmpty) return;

      final a =
          state.userFavorites[state.currentUser!.uid]?.map((e) => e).toList();

      if (a == null) return;

      final index = a.indexOf(itemFound.first);

      a.removeAt(index);

      final b = state.userFavorites.map((key, value) => MapEntry(key, value));

      b[state.currentUser!.uid] = a;

      emit(state.copyWith(userFavorites: b));
    });
  }

  @override
  FavoritesState? fromJson(Map<String, dynamic> json) {
    print("JSON DAta: $json");
    return FavoritesState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(FavoritesState state) => state.toJson();
}










/*
final favoriteState = json['ZkXPUM1cgCWUAyVW3NL3isCk2gw1']['favoritesState'] as List;

{
  'ZkXPUM1cgCWUAyVW3NL3isCk2gw1': {
    'favoritesState': state.favoriteItem.map((e) => e.toJson()).toList()
  }
}
 */

// import 'dart:convert';

// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../models/product_model.dart';

// part 'favorites_event.dart';
// part 'favorites_state.dart';

// class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
//   late SharedPreferences _prefs;

//   Future<void> init() async {
//     _prefs = await SharedPreferences.getInstance();
//   }

//   FavoritesBloc() : super(FavoritesInitial()) {
//     on<FavoritesEvent>((event, emit) async {
//       await init();
//       emit(state.copyWith(item: _loadItems()));
//     });
//     on<FavoriteItemAdded>((event, emit) async {
//       final a = state.favoriteItem.map((e) => e).toList();

//       final itemExists =
//           a.any((favoriteItem) => favoriteItem.name == event.favoriteItem.name);
//       if (!itemExists) {
//         a.add(
//           ProductModel(
//             description: event.favoriteItem.description,
//             id: event.favoriteItem.id,
//             maxItem: event.favoriteItem.id,
//             name: event.favoriteItem.name,
//             price: event.favoriteItem.price,
//           ),
//         );
//       }

//       emit(state.copyWith(item: a));

//       await _saveItems(a);
//     });
//     on<FavoriteItemRemoved>((event, emit) async {
//       final favoriteItemFound = state.favoriteItem
//           .where((favoriteItem) => favoriteItem.id == event.id);

//       if (favoriteItemFound.isEmpty) return;

//       final a = state.favoriteItem.map((e) => e).toList();
//       final index = a.indexOf(favoriteItemFound.first);

//       a.removeAt(index);

//       emit(state.copyWith(item: a));
//       await _saveItems(a);
//     });
//   }

//   //to shared pref
//   Future<void> _saveItems(List<ProductModel> items) async {
//     final jsonItems = items.map((item) => jsonEncode(item.toJson())).toList();
//     await _prefs.setStringList('items', jsonItems);
//   }

//   //from shared pref
//   List<ProductModel>? _loadItems() {
//     final jsonItems = _prefs.getStringList('items');
//     if (jsonItems == null) return null;

//     final items = jsonItems
//         .map((json) => ProductModel.fromJson(jsonDecode(json)))
//         .toList();
//     return items;
//   }
// }

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:internship_project/models/product_model.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends HydratedBloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(const FavoritesState()) {
    on<FavoriteItemAdded>((event, emit) async {
      final a = state.favoriteItem.map((e) => e).toList();

      final itemExists = a.any((item) => item.name == event.favoriteItem.name);
      if (!itemExists) {
        a.add(event.favoriteItem);
      }

      emit(state.copyWith(item: a));
    });
    on<FavoriteItemRemoved>((event, emit) async {
      final itemFound = state.favoriteItem.where((item) => item.id == event.id);

      if (itemFound.isEmpty) return;

      final a = state.favoriteItem.map((e) => e).toList();
      final index = a.indexOf(itemFound.first);

      a.removeAt(index);

      emit(state.copyWith(item: a));
    });
  }

  @override
  FavoritesState? fromJson(Map<String, dynamic> json) {
    final favoriteState = json['favoritesState'] as List;
    var list = favoriteState.map((e) => ProductModel.fromJson(e)).toList();
    return FavoritesState(favoriteItem: list);
  }

  @override
  Map<String, dynamic>? toJson(FavoritesState state) {
    return {
      'favoritesState': state.favoriteItem.map((e) => e.toJson()).toList()
    };
  }
}















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

import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:internship_project/models/cart_item_model.dart';
import 'package:internship_project/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  CartBloc() : super(const CartState()) {
    on<CartItemInitial>((event, emit) async {
      await init();
      emit(state.copyWith(item: _loadItems()));
    });
    on<CartItemAdded>((event, emit) async {
      print("added1");

      final a = state.item.map((e) => e).toList();

      final itemExists = a.any((item) => item.product.name == event.item.name);
      if (!itemExists) {
        a.add(CartItemModel(
          quantity: 1,
          subTotal: event.item.price.amount,
          product: event.item,
          total: event.item.price.amount,
        ));
      }

      emit(state.copyWith(item: a));

      print("added2");
      await _saveItems(a);
    });
    on<CartItemRemoved>((event, emit) async {
      final itemFound = state.item.where((item) => item.product.id == event.id);

      if (itemFound.isEmpty) return;

      final a = state.item.map((e) => e).toList();
      final index = a.indexOf(itemFound.first);

      a.removeAt(index);

      emit(state.copyWith(item: a));
      await _saveItems(a);
    });
    on<CartItemIncrement>((event, emit) async {
      final itemFound = state.item.where((item) => item.product.id == event.id);

      if (itemFound.isEmpty) return;

      final incrementedItem = itemFound.first.increment();

      final stateItems = state.item.map((e) => e).toList();
      final index = stateItems.indexOf(itemFound.first);

      stateItems[index] = incrementedItem;

      emit(state.copyWith(item: stateItems));
      await _saveItems(stateItems);
    });
    on<CartItemDecrement>((event, emit) async {
      final itemFound = state.item.where((item) => item.product.id == event.id);

      if (itemFound.isEmpty) return;

      final decrementedItem = itemFound.first.decrement();

      final stateItems = state.item.map((e) => e).toList();
      final index = stateItems.indexOf(itemFound.first);

      stateItems[index] = decrementedItem;

      emit(state.copyWith(item: stateItems));
      await _saveItems(stateItems);
    });

    on<ClearCartItem>((event, emit) async {
      final a = state.item.map((e) => e).toList();

      a.clear();

      emit(state.copyWith(item: a));
      await _saveItems(a);
    });
  }

  //to shared pref
  Future<void> _saveItems(List<CartItemModel> items) async {
    final jsonItems = items.map((item) => jsonEncode(item.toJson())).toList();
    final abc = await _prefs.setStringList('items', jsonItems);

    print(abc);
    print("save wala");
  }

  //from shared pref
  List<CartItemModel>? _loadItems() {
    final jsonItems = _prefs.getStringList('items');
    if (jsonItems == null) return null;

    final items = jsonItems
        .map((json) => CartItemModel.fromJson(jsonDecode(json)))
        .toList();
    return items;
  }
}

// void showDialog(BuildContext context, String message) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         content: Text(message),
//         actions: [
//           TextButton(
//             child: const Text("OK"),
//             onPressed: () => Navigator.pop(context),
//           ),
//         ],
//       );
//     },
//   );
// }

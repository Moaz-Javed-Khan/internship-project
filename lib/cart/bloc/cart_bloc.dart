import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  User? currentUser = FirebaseAuth.instance.currentUser;

  //to shared pref
  Future<void> _saveItems(List<CartItemModel> items) async {
    final jsonItems = items.map((item) => (item.toJson())).toList();
    final a = {'items': jsonItems};
    await _prefs.setString(currentUser?.uid ?? '', jsonEncode(a));
  }

  //from shared pref
  List<CartItemModel>? _loadItems() {
    final jsonItems = _prefs.getString(currentUser?.uid ?? '');
    if (jsonItems == null) return null;

    final decodeJsonItems = jsonDecode(jsonItems);

    final items = (decodeJsonItems['items'] as List)
        .map((json) => CartItemModel.fromJson(json))
        .toList();
    return items;

    // final items = jsonItems
    //     .map((json) => CartItemModel.fromJson(jsonDecode(json)))
    //     .toList();
    // return items;
  }
}







/*
Before:
{
  'items': [{..}, {..}, ...]
}

After:
{
  'ZkXPUM1cgCWUAyVW3NL3isCk2gw1': {
    'items': [{..}, {..}, ...]
  }
}


temModel>? _loadItems() {
    final jsonItems = _prefs.getString('ZkXPUM1cgCWUAyVW3NL3isCk2gw1');
    if (jsonItems == null) return null;

    final a = jsonDeode(jsonItems);

    final items = (a['items'] as List)
        .map((json) => CartItemModel.fromJson(json))
        .toList();
    return items;
  }
 */
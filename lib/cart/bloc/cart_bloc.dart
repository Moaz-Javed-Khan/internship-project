import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internship_project/models/cart_model.dart';
import 'package:internship_project/models/product_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<CartItemAdded>((event, emit) {
      if (event.item.quantity == 0) return;
      final a = state.item.map((e) => e).toList();

      a.add(CartItemModel(
          quantity: event.item.quantity,
          subTotal: event.item.price.amount * event.item.quantity,
          product: event.item));

      emit(state.copyWith(item: a));
    });
    on<CartItemRemoved>((event, emit) {
      final a = state.item.map((e) => e).toList();

      a.remove(event.item);

      emit(state.copyWith(item: a));
    });
    on<CartItemIncrement>((event, emit) {
      final incrementedItem = event.item.increment();

      final stateItems = state.item.map((e) => e).toList();
      final index = stateItems.indexOf(event.item);

      stateItems[index] = incrementedItem;

      emit(state.copyWith(item: stateItems));
    });
    on<CartItemDecrement>((event, emit) {
      final decrementedItem = event.item.decrement();

      final stateItems = state.item.map((e) => e).toList();
      final index = stateItems.indexOf(event.item);

      stateItems[index] = decrementedItem;

      emit(state.copyWith(item: stateItems));
    });
  }
}

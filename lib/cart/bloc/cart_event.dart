part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class CartItemInitial extends CartEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CartItemAdded extends CartEvent {
  const CartItemAdded(this.item);

  final ProductModel item;

  @override
  List<Object> get props => [item];
}

class CartItemRemoved extends CartEvent {
  const CartItemRemoved(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}

class CartItemIncrement extends CartEvent {
  const CartItemIncrement(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}

class CartItemDecrement extends CartEvent {
  const CartItemDecrement(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}

class ClearCartItem extends CartEvent {
  const ClearCartItem(this.item);

  final CartItemModel item;

  @override
  List<Object> get props => [item];
}

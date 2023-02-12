part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class CartItemAdded extends CartEvent {
  const CartItemAdded(this.item);

  final ProductModel item;

  @override
  List<Object> get props => [item];
}

class CartItemRemoved extends CartEvent {
  const CartItemRemoved(this.item);

  final CartItemModel item;

  @override
  List<Object> get props => [item];
}

class CartItemIncrement extends CartEvent {
  const CartItemIncrement(this.item);

  final CartItemModel item;

  @override
  List<Object> get props => [item];
}

class CartItemDecrement extends CartEvent {
  const CartItemDecrement(this.item);

  final CartItemModel item;

  @override
  List<Object> get props => [item];
}

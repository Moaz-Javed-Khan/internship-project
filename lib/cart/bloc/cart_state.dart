part of 'cart_bloc.dart';

class CartState extends Equatable {
  const CartState({this.item = const []});

  final List<CartItemModel> item;

  CartState copyWith({List<CartItemModel>? item}) {
    return CartState(item: item ?? this.item);
  }

  @override
  List<Object> get props => [item, item.length];
}

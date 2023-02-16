part of 'cart_bloc.dart';

class CartState extends Equatable {
  const CartState({this.item = const []});

  final List<CartItemModel> item;

  CartState copyWith({List<CartItemModel>? item}) {
    return CartState(item: item ?? this.item);
  }

  double calculateTotal() {
    double total = 0;
    for (int i = 0; i < item.length; i++) {
      total += item[i].subTotal;
    }

    return total;
  }

  int getItemQuantity(int id) {
    final itemFound = item.where((item) => item.product.id == id);
    if (itemFound.isEmpty) return 0;
    return itemFound.first.quantity;
  }

  @override
  List<Object> get props => [item, item.length];
}

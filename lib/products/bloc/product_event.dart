part of 'product_bloc.dart';

@immutable
abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class LoadProductEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}

class ProductIncrement extends ProductEvent {
  const ProductIncrement(this.product);

  final ProductModel product;

  @override
  List<Object> get props => [product];
}

class ProductDecrement extends ProductEvent {
  const ProductDecrement(this.product);

  final ProductModel product;

  @override
  List<Object> get props => [product];
}

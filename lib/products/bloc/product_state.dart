part of 'product_bloc.dart';

enum ProductStatus {
  InitialState,
  LoadingState,
  LoadedState,
  ErrorState,
}

class ProductState extends Equatable {
  const ProductState({
    this.productstatus = ProductStatus.InitialState,
    this.error,
    this.product = const [],
  });

  final List<ProductModel> product;
  final ProductStatus productstatus;
  final String? error;

  ProductState copyWith({List<ProductModel>? product, productstatus, error}) {
    return ProductState(
      product: product ?? this.product,
      productstatus: productstatus ?? this.productstatus,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [product, productstatus, error];
}



// class ProductInitial extends ProductState {
//   @override
//   List<Object?> get props => [];
// }

// class ProductLoadingState extends ProductState {
//   @override
//   List<Object?> get props => [];
// }

// class ProductLoadedState extends ProductState {
//   ProductLoadedState(this.products);

//   final List<ProductModel> products;

//   ProductState copyWith({List<ProductModel>? products}) {
//     return ProductLoadedState(products ?? this.products);
//   }

//   @override
//   List<Object?> get props => [products];
// }

// class ProductErrorState extends ProductState {
//   final String error;

//   ProductErrorState(this.error);

//   @override
//   List<Object?> get props => [error];
// }

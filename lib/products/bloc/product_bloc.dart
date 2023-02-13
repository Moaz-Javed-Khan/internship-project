import 'package:bloc/bloc.dart';
import 'package:internship_project/models/product_model.dart';
import 'package:internship_project/products/bloc/product_repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;

  ProductBloc(this._productRepository) : super(const ProductState()) {
    on<LoadProductEvent>((event, emit) async {
      emit(state.copyWith(productstatus: ProductStatus.LoadingState));
      try {
        final products = await _productRepository.readProducts();
        emit(
          state.copyWith(
            productstatus: ProductStatus.LoadedState,
            product: products,
          ),
        );
      } catch (e) {
        emit(state.copyWith(
            productstatus: ProductStatus.ErrorState, error: e.toString()));
      }
    });
    on<ProductIncrement>((event, emit) {
      final incrementedItem = event.product.increment();

      final stateItems = state.product.map((e) => e).toList();
      final index = stateItems.indexOf(event.product);

      stateItems[index] = incrementedItem;

      emit(state.copyWith(product: stateItems));
    });
    on<ProductDecrement>((event, emit) {
      final decrementedItem = event.product.decrement();

      final stateItems = state.product.map((e) => e).toList();
      final index = stateItems.indexOf(event.product);

      stateItems[index] = decrementedItem;

      emit(state.copyWith(product: stateItems));
    });
  }
}

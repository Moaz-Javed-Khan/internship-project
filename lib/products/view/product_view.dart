import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_project/favorites/bloc/favorites_bloc.dart';
import 'package:internship_project/products/bloc/product_bloc.dart';
import 'package:internship_project/products/bloc/product_repositories.dart';
import 'package:internship_project/products/view/product_detail_view.dart';
import 'package:internship_project/widgets/carousel_widget.dart';
import 'package:internship_project/widgets/product_item_widget.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductBloc(ProductRepository()),
      child: const ProductView(),
    );
    // return MultiBlocProvider(
    //   providers: [
    //     BlocProvider<ProductBloc>(
    //       create: (BuildContext context) => ProductBloc(
    //         ProductRepository(),
    //       ),
    //     ),
    //   ],
    //   child: const ProductView(),
    // );
  }
}

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          // if (state is ProductInitial) {
          if (state.productstatus == ProductStatus.InitialState) {
            context.read<ProductBloc>().add(LoadProductEvent());

            // } else if (state is ProductLoadingState) {
          } else if (state.productstatus == ProductStatus.LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );

            // } else if (state is ProductLoadedState) {
          } else if (state.productstatus == ProductStatus.LoadedState) {
            return Column(
              children: [
                const Expanded(child: CarouselWidget()),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.74,
                    ),
                    itemCount: state.product.length,
                    itemBuilder: (context, index) {
                      final product = state.product[index];
                      return GestureDetector(
                        onTap: () {
                          var bloc = context.read<FavoritesBloc>();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ProductDetail(
                                  bloc: bloc,
                                  product: product,
                                );
                              },
                            ),
                          );
                        },
                        child: ProductItemWidget(
                          product: product,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
            // } else if (state is ProductErrorState) {
          } else if (state.productstatus == ProductStatus.ErrorState) {
            return Center(child: Text(state.error ?? ''));
            // context.read<ProductBloc>().add(LoadProductEvent());
          }
          return const SizedBox();
        },
      ),
    );
  }
}

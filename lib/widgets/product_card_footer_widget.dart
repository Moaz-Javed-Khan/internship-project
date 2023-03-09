import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_project/cart/bloc/cart_bloc.dart';
import 'package:internship_project/favorites/bloc/favorites_bloc.dart';
import 'package:internship_project/models/product_model.dart';
import 'package:internship_project/widgets/item_counter_widget.dart';
import 'package:internship_project/widgets/reset_counter_widget.dart';

class ProductCardFooterWidget extends StatefulWidget {
  const ProductCardFooterWidget({
    super.key,
    required this.incrementCounter,
    required this.decrementCounter,
    required this.resetCounter,
    required this.onChanged,
    required this.addToCart,
    required this.id,
    required this.maxItem,
    required this.quantity,
    required this.addToFavorite,
    required this.product,
    // required this.count,
  });

  final void Function() incrementCounter;
  final void Function()? decrementCounter;
  final void Function() resetCounter;
  final void Function() addToFavorite;
  final void Function() addToCart;
  final void Function(String value) onChanged;
  final int id;
  final int maxItem;
  final int quantity;
  // final int count;

  final ProductModel product;

  @override
  State<ProductCardFooterWidget> createState() =>
      _ProductCardFooterWidgetState();
}

class _ProductCardFooterWidgetState extends State<ProductCardFooterWidget> {
  TextEditingController counterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(height: 4),
          Row(
            children: [
              (context.watch<CartBloc>().state.getItemQuantity(widget.id) > 0)
                  ? Container(
                      margin: const EdgeInsets.only(left: 23),
                      child: ItemCounterWidget(
                        addToCart: widget.addToCart,
                        incrementCounter: widget.incrementCounter,
                        decrementCounter: widget.decrementCounter,
                        onChanged: widget.onChanged,
                        // count: widget.count,
                        count: context
                            .watch<CartBloc>()
                            .state
                            .getItemQuantity(widget.id),
                        maxItem: widget.maxItem,
                      ),
                    )
                  : Container(
                      height: 45,
                      margin: const EdgeInsets.only(left: 23),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.orange,
                          width: 1,
                        ),
                      ),
                      child: InkWell(
                        onTap: widget.addToCart,
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Text(
                              "Add to Cart ",
                              style: TextStyle(fontSize: 17),
                            ),
                            const Icon(Icons.shopping_cart),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (widget.quantity > 0)
                  ? ResetCounterWidget(
                      resetCounter: widget.resetCounter,
                    )
                  : const SizedBox(
                      height: 1,
                    ),
              // Icons.favorite : Icons.favorite_border
              IconButton(
                icon: context
                        .watch<FavoritesBloc>()
                        .state
                        .favoriteItem
                        .contains(widget.product)
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : const Icon(Icons.favorite_border),
                onPressed: widget.addToFavorite,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

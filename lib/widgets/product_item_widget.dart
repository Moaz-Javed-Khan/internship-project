import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_project/cart/bloc/cart_bloc.dart';
import 'package:internship_project/favorites/bloc/favorites_bloc.dart';
import 'package:internship_project/models/cart_item_model.dart';
import 'package:internship_project/models/product_model.dart';
import 'package:internship_project/products/bloc/product_bloc.dart';
import 'package:internship_project/widgets/product_card_footer_widget.dart';

class ProductItemWidget extends StatefulWidget {
  const ProductItemWidget({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  int count = 0;

  void _incrementCounter() {
    setState(() {
      count += 1;
    });
    print("count $count");
  }

  void _decrementCounter() {
    setState(() {
      if (count > 0) {
        count -= 1;
      } else {
        final snackBar = SnackBar(
          content: const Text('Reached 0, can\'t decrement more'),
          backgroundColor: (Colors.black),
          action: SnackBarAction(
            label: 'dismiss',
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
    print("count $count");
  }

  void _resetCounter() {
    setState(() {
      count = 0;
    });
    print("count $count");
  }

  void _onChanged(value) {
    count = int.parse(value);
  }

  void newOnChanged(int? value) {
    if (value != null) {
      setState(() {
        count = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var itemQuantity =
        context.watch<CartBloc>().state.getItemQuantity(widget.product.id);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.all(8),
      elevation: 8,
      shadowColor: Colors.black26,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/image.jpg",
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 4),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        widget.product.name,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${widget.product.price.amount} ${widget.product.price.currency}',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5),
              ProductCardFooterWidget(
                // incrementCounter: () => newOnChanged(count + 1),
                incrementCounter: () => context
                    .read<CartBloc>()
                    .add(CartItemIncrement(widget.product.id)),
                // decrementCounter: () => newOnChanged(count - 1),
                decrementCounter: (itemQuantity <= 1)
                    ? () => context
                        .read<CartBloc>()
                        .add(CartItemRemoved(widget.product.id))
                    : () => context
                        .read<CartBloc>()
                        .add(CartItemDecrement(widget.product.id)),
                // incrementCounter: () =>
                //     context.read<CartBloc>().add(CartItemIncrement()),
                // resetCounter: () => newOnChanged(0),

                // resetCounter: () => newOnChanged(0),
                resetCounter: () => context
                    .read<CartBloc>()
                    .add(CartItemRemoved(widget.product.id)),
                onChanged: (value) => newOnChanged(int.tryParse(value)),
                // count: count,
                // quantity: widget.product.quantity,
                id: widget.product.id,
                addToCart: () {
                  context
                      .read<CartBloc>()
                      .add(CartItemIncrement(widget.product.id));
                  context.read<CartBloc>().add(CartItemAdded(widget.product));
                },
                maxItem: widget.product.maxItem,
                quantity: context
                    .read<CartBloc>()
                    .state
                    .getItemQuantity(widget.product.id),
                // context.read<CartBloc>().add(CartItemAdded(widget.product, widget.product.quantity)),
                addToFavorite: () => context.read<FavoritesBloc>().add(
                      FavoriteItemAdded(widget.product),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

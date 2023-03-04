import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_project/cart/bloc/cart_bloc.dart';
import 'package:internship_project/check_out/view/check_out_view.dart';
import 'package:internship_project/models/product_model.dart';
import 'package:internship_project/widgets/product_card_footer_widget.dart';

import '../../favorites/bloc/favorites_bloc.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  int count = 0;

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.name,
        ),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            Hero(
              tag: 'animatedImage',
              child: Image.network(
                widget.product.image,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.product.name,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${widget.product.price.amount} ${widget.product.price.currency}',
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text(
              widget.product.description,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: 180,
              alignment: Alignment.bottomCenter,
              child: ProductCardFooterWidget(
                incrementCounter: () => context
                    .read<CartBloc>()
                    .add(CartItemIncrement(widget.product.id)),
                decrementCounter: (itemQuantity <= 1)
                    ? () => context
                        .read<CartBloc>()
                        .add(CartItemRemoved(widget.product.id))
                    : () => context
                        .read<CartBloc>()
                        .add(CartItemDecrement(widget.product.id)),
                resetCounter: () => context
                    .read<CartBloc>()
                    .add(CartItemRemoved(widget.product.id)),
                onChanged: (value) => newOnChanged(int.tryParse(value)),
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
                addToFavorite: () => context.read<FavoritesBloc>().add(
                      FavoriteItemAdded(widget.product),
                    ),
                product: widget.product,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

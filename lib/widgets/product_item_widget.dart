import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_project/cart/bloc/cart_bloc.dart';
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
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/image.jpg",
                height: 85,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 2),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        widget.product.name,
                        style: const TextStyle(fontSize: 17),
                      ),
                      Row(
                        children: [
                          Text(
                            widget.product.price.amount.toString(),
                            style: const TextStyle(fontSize: 17),
                          ),
                          Text(
                            widget.product.price.currency,
                            style: const TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    widget.product.description,
                    style: const TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              ProductCardFooterWidget(
                // incrementCounter: () => newOnChanged(count + 1),
                incrementCounter: () => context
                    .read<ProductBloc>()
                    .add(ProductIncrement(widget.product)),
                // decrementCounter: () => newOnChanged(count - 1),
                decrementCounter: (widget.product.quantity <= 1)
                    ? null
                    : () => context
                        .read<ProductBloc>()
                        .add(ProductDecrement(widget.product)),
                // incrementCounter: () =>
                //     context.read<CartBloc>().add(CartItemIncrement()),
                resetCounter: () => newOnChanged(0),
                onChanged: (value) => newOnChanged(int.tryParse(value)),
                // count: count,
                // count: widget.product.quantity,
                quantity: widget.product.quantity,
                addToCart: () =>
                    context.read<CartBloc>().add(CartItemAdded(widget.product)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

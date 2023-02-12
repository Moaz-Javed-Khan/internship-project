import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_project/cart/bloc/cart_bloc.dart';
import 'package:internship_project/models/cart_model.dart';
import 'package:internship_project/widgets/product_card_footer_widget.dart';
import 'package:internship_project/widgets/cart_card_footer_widget.dart';

class CartItemWidget extends StatefulWidget {
  const CartItemWidget({super.key, required this.item});

  final CartItemModel item;

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
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
                        widget.item.product.name,
                        style: const TextStyle(fontSize: 17),
                      ),
                      Text(
                        widget.item.subTotal.toString(),
                        style: const TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                  Text(
                    widget.item.quantity.toString(),
                    style: const TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              CartCardFooterWidget(
                // decrementCounter: () => newOnChanged(count - 1),
                decrementCounter: (widget.item.quantity <= 1)
                    ? null
                    : () => context
                        .read<CartBloc>()
                        .add(CartItemDecrement(widget.item)),
                incrementCounter: () => context
                    .read<CartBloc>()
                    .add(CartItemIncrement(widget.item)),
                // incrementCounter: () => newOnChanged(count + 1),
                // resetCounter: () => newOnChanged(0),
                removeItem: () =>
                    context.read<CartBloc>().add(CartItemRemoved(widget.item)),
                onChanged: (value) => newOnChanged(int.tryParse(value)),
                count: widget.item.quantity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

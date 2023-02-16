import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_project/cart/bloc/cart_bloc.dart';
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
    // required this.count,
  });

  final void Function() incrementCounter;
  final void Function()? decrementCounter;
  final void Function() resetCounter;
  final void Function() addToCart;
  final void Function(String value) onChanged;
  final int id;
  // final int count;

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
          const SizedBox(height: 8),
          Row(
            children: [
              (context.watch<CartBloc>().state.getItemQuantity(widget.id) > 0)
                  ? ItemCounterWidget(
                      addToCart: widget.addToCart,
                      incrementCounter: widget.incrementCounter,
                      decrementCounter: widget.decrementCounter,
                      onChanged: widget.onChanged,
                      // count: widget.count,
                      count: context
                          .watch<CartBloc>()
                          .state
                          .getItemQuantity(widget.id),
                    )
                  : Container(
                      height: 45,
                      margin: const EdgeInsets.only(left: 23),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.blue,
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
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // (widget.quantity > 1)
              //     ? const SizedBox(
              //         height: 1,
              //       )
              //     :

              ResetCounterWidget(
                resetCounter: widget.resetCounter,
              ),
              // Icons.favorite : Icons.favorite_border
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: Colors.blue,
                    width: 1,
                  ),
                ),
                child: IconButton(
                  icon: const Icon(Icons.favorite),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

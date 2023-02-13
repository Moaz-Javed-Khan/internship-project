import 'package:flutter/material.dart';
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
    required this.quantity,
    // required this.count,
  });

  final void Function() incrementCounter;
  final void Function()? decrementCounter;
  final void Function() resetCounter;
  final void Function() addToCart;
  final void Function(String value) onChanged;
  final int quantity;
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
          Row(
            children: [
              ItemCounterWidget(
                addToCart: widget.addToCart,
                incrementCounter: widget.incrementCounter,
                decrementCounter: widget.decrementCounter,
                onChanged: widget.onChanged,
                // count: widget.count,
                count: widget.quantity,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // (widget.quantity > 1)
              //     ? const SizedBox(
              //         height: 1,
              //       )
              //     :
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: Colors.blue,
                    width: 1,
                  ),
                ),
                child: InkWell(
                  onTap: widget.addToCart,
                  child: const Icon(Icons.shopping_cart),
                ),
              ),
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
                child: InkWell(
                  onTap: () {},
                  child: const Icon(Icons.favorite),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

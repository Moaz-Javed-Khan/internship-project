import 'package:flutter/material.dart';
import 'package:internship_project/widgets/item_counter_widget.dart';
import 'package:internship_project/widgets/reset_counter_widget.dart';

class CartCardFooterWidget extends StatefulWidget {
  const CartCardFooterWidget({
    super.key,
    required this.incrementCounter,
    required this.decrementCounter,
    // required this.resetCounter,
    required this.removeItem,
    required this.onChanged,
    required this.count,
  });

  final void Function() incrementCounter;
  final void Function()? decrementCounter;
  // final void Function() resetCounter;
  final void Function() removeItem;
  final void Function(String value) onChanged;
  final int count;

  @override
  State<CartCardFooterWidget> createState() => _CartCardFooterWidgetState();
}

class _CartCardFooterWidgetState extends State<CartCardFooterWidget> {
  TextEditingController counterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              ItemCounterWidget(
                incrementCounter: widget.incrementCounter,
                decrementCounter: widget.decrementCounter,
                onChanged: widget.onChanged,
                count: widget.count,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  onPressed: widget.removeItem,
                  icon: const Icon(Icons.delete),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

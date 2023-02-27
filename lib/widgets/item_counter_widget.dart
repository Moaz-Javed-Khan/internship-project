import 'package:flutter/material.dart';

class ItemCounterWidget extends StatefulWidget {
  const ItemCounterWidget({
    super.key,
    this.addToCart,
    required this.incrementCounter,
    required this.decrementCounter,
    required this.onChanged,
    required this.count,
    required this.maxItem,
  });

  final void Function()? addToCart;
  final void Function() incrementCounter;
  final void Function()? decrementCounter;
  final void Function(String value) onChanged;
  final int count;
  final int maxItem;

  @override
  State<ItemCounterWidget> createState() => _ItemCounterWidgetState();
}

class _ItemCounterWidgetState extends State<ItemCounterWidget> {
  maxItemSnackbar() {
    final snackBar = SnackBar(
      content: const Text('Reached Max quantity, can\'t increment more'),
      backgroundColor: (Colors.black),
      action: SnackBarAction(
        label: 'dismiss',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          visualDensity: VisualDensity.compact,
          icon: const Icon(Icons.remove),
          onPressed: widget.decrementCounter,
        ),
        SizedBox(
          width: 50,
          child: TextField(
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            // onChanged: (value) => count = int.parse(value),
            onChanged: widget.onChanged,
            controller: TextEditingController(text: '${widget.count}'),
          ),
        ),
        IconButton(
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          onPressed: (widget.count == widget.maxItem)
              ? () => maxItemSnackbar()
              : widget.incrementCounter,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}

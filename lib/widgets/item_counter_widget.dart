import 'package:flutter/material.dart';

class ItemCounterWidget extends StatefulWidget {
  const ItemCounterWidget({
    super.key,
    required this.incrementCounter,
    required this.decrementCounter,
    required this.onChanged,
    required this.count,
  });

  final void Function() incrementCounter;
  final void Function()? decrementCounter;
  final void Function(String value) onChanged;
  final int count;

  @override
  State<ItemCounterWidget> createState() => _ItemCounterWidgetState();
}

class _ItemCounterWidgetState extends State<ItemCounterWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Opacity(
            opacity: (widget.count > 0) ? 1.0 : 0.5,
            child: Container(
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
                icon: const Icon(Icons.remove),
                onPressed: widget.decrementCounter,
              ),
            ),
          ),
          Expanded(
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
              onPressed: widget.incrementCounter,
              icon: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}

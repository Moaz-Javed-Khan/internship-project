import 'package:flutter/material.dart';

class FooterWidget extends StatefulWidget {
  const FooterWidget({
    super.key,
    required this.incrementCounter,
    required this.decrementCounter,
    required this.resetCounter,
    required this.onChanged,
    required this.count,
  });

  final void Function() incrementCounter;
  final void Function() decrementCounter;
  final void Function() resetCounter;
  final void Function(String value) onChanged;
  final int count;

  @override
  State<FooterWidget> createState() => _FooterWidgetState();
}

class _FooterWidgetState extends State<FooterWidget> {
  TextEditingController counterController = TextEditingController();

  // int count = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     count += 1;
  //   });
  //   print("count $count");
  // }

  // void _decrementCounter() {
  //   setState(() {
  //     if (count > 0) {
  //       count -= 1;
  //     } else {
  //       final snackBar = SnackBar(
  //         content: const Text('Reached 0, can\'t decrement more'),
  //         backgroundColor: (Colors.black),
  //         action: SnackBarAction(
  //           label: 'dismiss',
  //           onPressed: () {},
  //         ),
  //       );
  //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //     }
  //   });
  //   print("count $count");
  // }

  // void _resetCounter() {
  //   setState(() {
  //     count = 0;
  //   });
  //   print("count $count");
  // }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
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
                child: InkWell(
                  onTap: widget.decrementCounter,
                  child: const Icon(Icons.remove),
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
                child: InkWell(
                  onTap: widget.incrementCounter,
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisSize: MainAxisSize.min,
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
                child: InkWell(
                  onTap: () {},
                  child: const Icon(Icons.shopping_cart),
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
                child: InkWell(
                  onTap: widget.resetCounter,
                  child: const Icon(Icons.delete),
                ),
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

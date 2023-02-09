import 'package:flutter/material.dart';
import 'package:internship_project/widgets/product_card_footer_widget.dart';

class ProductItemWidget extends StatefulWidget {
  const ProductItemWidget({super.key});

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
                      const Text(
                        "Name",
                        style: TextStyle(fontSize: 17),
                      ),
                      const Text(
                        "Price",
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              ProductCardFooterWidget(
                decrementCounter: () => newOnChanged(count - 1),
                incrementCounter: () => newOnChanged(count + 1),
                resetCounter: () => newOnChanged(0),
                onChanged: (value) => newOnChanged(int.tryParse(value)),
                count: count,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:internship_project/views/footer_widget.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  static Route route() =>
      MaterialPageRoute(builder: (context) => const CartView());

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          Card(
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
                      height: 80,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    FooterWidget(
                      decrementCounter: _decrementCounter,
                      incrementCounter: _incrementCounter,
                      resetCounter: _resetCounter,
                      onChanged: _onChanged,
                      count: count,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
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
                      height: 80,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    FooterWidget(
                      decrementCounter: _decrementCounter,
                      incrementCounter: _incrementCounter,
                      resetCounter: _resetCounter,
                      onChanged: _onChanged,
                      count: count,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
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
                      height: 80,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    FooterWidget(
                      decrementCounter: _decrementCounter,
                      incrementCounter: _incrementCounter,
                      resetCounter: _resetCounter,
                      onChanged: _onChanged,
                      count: count,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
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
                      height: 80,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    FooterWidget(
                      decrementCounter: _decrementCounter,
                      incrementCounter: _incrementCounter,
                      resetCounter: _resetCounter,
                      onChanged: _onChanged,
                      count: count,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
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
                      height: 80,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    FooterWidget(
                      decrementCounter: _decrementCounter,
                      incrementCounter: _incrementCounter,
                      resetCounter: _resetCounter,
                      onChanged: _onChanged,
                      count: count,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

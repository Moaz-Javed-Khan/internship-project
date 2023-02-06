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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/image.jpg",
                    height: 70,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 10),
                  const FooterWidget(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

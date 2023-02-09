import 'package:flutter/material.dart';
import 'package:internship_project/widgets/cart_item_widget.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

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
        childAspectRatio: 0.7,
        crossAxisCount: 2,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const CartItemWidget(),
          const CartItemWidget(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_project/cart/bloc/cart_bloc.dart';

import 'package:internship_project/check_out/view/check_out_view.dart';

class CartBottomBar extends StatefulWidget {
  const CartBottomBar({
    super.key,
  });

  @override
  State<CartBottomBar> createState() => _CartBottomBarState();
}

class _CartBottomBarState extends State<CartBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.maxFinite,
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Text(
              "Total",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              context.watch<CartBloc>().state.calculateTotal().toString(),
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CheckOutView(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      10,
                    ),
                  ),
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text(
                      'Checkout',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    // ignore: prefer_const_constructors
                    SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.shopping_cart_checkout,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

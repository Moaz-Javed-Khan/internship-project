import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_project/cart/bloc/cart_bloc.dart';
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
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: state.item.length,
                  itemBuilder: (context, index) {
                    final item = state.item[index];
                    return CartItemWidget(
                      item: item,
                    );
                  },
                ),
              ),
              Container(
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
                      const Text(
                        "Rs. 100 .80",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Container(
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
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
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

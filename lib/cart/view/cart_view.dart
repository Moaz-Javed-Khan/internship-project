import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_project/cart/bloc/cart_bloc.dart';
import 'package:internship_project/widgets/cart_bottom_bar.dart';
import 'package:internship_project/widgets/cart_item_widget.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => CartViewState();
}

class CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        backgroundColor: Colors.orange,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: const Text("Are you sure"),
                      actions: [
                        TextButton(
                          child: const Text("Yes"),
                          onPressed: () {
                            context.read<CartBloc>().add(const ClearCartItem());
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: const Text("No"),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    );
                  }),
              child: const Text(
                "Clear Cart",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //   crossAxisCount: 2,
                  //   childAspectRatio: 0.7,
                  // ),
                  // shrinkWrap: true,
                  itemCount: state.item.length,
                  itemBuilder: (context, index) {
                    final item = state.item[index];
                    return CartItemWidget(item: item);
                  },
                ),
              ),
              const CartBottomBar(),
            ],
          );
        },
      ),
    );
  }
}

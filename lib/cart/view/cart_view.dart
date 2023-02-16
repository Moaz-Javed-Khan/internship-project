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
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //   crossAxisCount: 2,
                  //   childAspectRatio: 0.7,
                  // ),
                  // shrinkWrap: true,
                  itemCount: state.item.length,
                  itemBuilder: (context, index) {
                    final item = state.item[index];
                    return CartItemWidget(
                      item: item,
                    );
                    // Container(
                    //   width: double.infinity,
                    //   height: 10,
                    //   color: Colors.amber,
                    // );
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

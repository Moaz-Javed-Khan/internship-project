import 'package:flutter/material.dart';
import 'package:internship_project/check_out/view/check_out_view.dart';
import 'package:internship_project/models/product_model.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Laptop"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            Image.asset(
              "assets/image.jpg",
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.product.name,
                  style: const TextStyle(fontSize: 22),
                ),
                Row(
                  children: [
                    Text(
                      widget.product.price.amount.toString(),
                      style: const TextStyle(fontSize: 22),
                    ),
                    Text(
                      widget.product.price.currency,
                      style: const TextStyle(fontSize: 22),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              widget.product.description,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const CheckOutView(),
            //       ),
            //     );
            //   },
            // child: Container(
            //   width: 145,
            //   padding: const EdgeInsets.all(5),
            //   decoration: BoxDecoration(
            //     borderRadius: const BorderRadius.all(
            //       Radius.circular(
            //         10,
            //       ),
            //     ),
            //     border: Border.all(
            //       color: Colors.blue,
            //       width: 1,
            //     ),
            //   ),
            //   child: Row(
            //     // ignore: prefer_const_literals_to_create_immutables
            //     children: [
            //       const Text(
            //         'Add to cart',
            //         style: TextStyle(
            //           fontSize: 20,
            //         ),
            //       ),
            //       // ignore: prefer_const_constructors
            //       SizedBox(
            //         width: 10,
            //       ),
            //       const Icon(
            //         Icons.shopping_cart,
            //       ),
            //     ],
            //   ),
            // ),
            // ),
          ],
        ),
      ),
    );
  }
}

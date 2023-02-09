import 'package:flutter/material.dart';
import 'package:internship_project/widgets/product_card_footer_widget.dart';
import 'package:internship_project/widgets/product_item_widget.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  static Route route() =>
      MaterialPageRoute(builder: (context) => const ProductView());

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        childAspectRatio: 0.7,
        crossAxisCount: 2,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const ProductItemWidget(),
          const ProductItemWidget(),
          const ProductItemWidget(),
          const ProductItemWidget(),
          const ProductItemWidget(),
        ],
      ),
    );
  }
}

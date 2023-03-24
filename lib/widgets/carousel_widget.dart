import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_project/favorites/bloc/favorites_bloc.dart';
import 'package:internship_project/models/product_model.dart';
import 'package:internship_project/products/bloc/product_bloc.dart';
import 'package:internship_project/products/view/product_detail_view.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({super.key});

  // final ProductModel featuredItem;

  @override
  State<CarouselWidget> createState() => CarouselWidgetState();
}

class CarouselWidgetState extends State<CarouselWidget> {
  late final PageController pageController;
  final ScrollController _scrollController = ScrollController();
  int pageNo = 0;

  Timer? carasouelTmer;

  Timer getTimer() {
    return Timer.periodic(const Duration(seconds: 3), (timer) {
      if (pageNo == 3) {
        pageNo = 0;
      }
      pageController.animateToPage(
        pageNo,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOutCirc,
      );
      pageNo++;
    });
  }

  @override
  void initState() {
    pageController = PageController(initialPage: 0, viewportFraction: 0.85);
    carasouelTmer = getTimer();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        showBtmAppBr = false;
        setState(() {});
      } else {
        showBtmAppBr = true;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  bool showBtmAppBr = true;

  @override
  Widget build(BuildContext context) {
    List featuredProducts = context
        .read<ProductBloc>()
        .state
        .product
        .where((e) => e.featured)
        .toList();

    return SizedBox(
      height: 100,
      child: PageView.builder(
        controller: pageController,
        onPageChanged: (index) {
          pageNo = index;
          setState(() {});
        },
        itemBuilder: (_, index) {
          return AnimatedBuilder(
            animation: pageController,
            builder: (ctx, child) {
              return child!;
            },
            child: GestureDetector(
              onTap: () {
                var bloc = context.read<FavoritesBloc>();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ProductDetail(
                        bloc: bloc,
                        product: featuredProducts[index],
                      );
                    },
                  ),
                );
              },
              onPanDown: (d) {
                carasouelTmer?.cancel();
                carasouelTmer = null;
              },
              onPanCancel: () {
                carasouelTmer = getTimer();
              },
              child: Container(
                margin: const EdgeInsets.only(
                    right: 8, left: 8, top: 24, bottom: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.0),
                  color: Colors.amberAccent,
                ),
                child: Image.network(
                  featuredProducts[index].image,
                  width: 100,
                  height: 100,
                ),
              ),
            ),
          );
        },
        itemCount: featuredProducts.length,
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({super.key});

  @override
  State<CarouselWidget> createState() => CarouselWidgetState();
}

class CarouselWidgetState extends State<CarouselWidget> {
  List images = [
    'https://firebasestorage.googleapis.com/v0/b/exam-f15a2.appspot.com/o/belt1-removebg-preview.png?alt=media&token=a9e75d30-5e10-4546-af40-d40a96bd2f26',
    'https://firebasestorage.googleapis.com/v0/b/exam-f15a2.appspot.com/o/image.jpg?alt=media&token=91dda48e-fa2a-43fa-85ca-0dd40c54d112',
    'https://firebasestorage.googleapis.com/v0/b/exam-f15a2.appspot.com/o/wallet-removebg-preview.png?alt=media&token=1fd0b23e-dab1-49d9-9921-2262bcbba91c',
  ];

  late final PageController pageController;
  final ScrollController _scrollController = ScrollController();
  int pageNo = 0;

  Timer? carasouelTmer;

  Timer getTimer() {
    return Timer.periodic(const Duration(seconds: 3), (timer) {
      if (pageNo == 2) {
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
              onTap: () {},
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
                  images[index],
                  width: 100,
                  height: 100,
                ),
              ),
            ),
          );
        },
        itemCount: 3,
      ),
    );
  }
}

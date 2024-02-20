import 'package:diaryapp/screens/intro/intropage1.dart';
import 'package:diaryapp/screens/intro/intropage2.dart';
import 'package:diaryapp/screens/intro/intropage3.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroPageView extends StatelessWidget {
  const IntroPageView({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      Intro1(
        context1: context,
      ),
      Intro2(
        context1: context,
      ),
      Intro3(
        context1: context,
      )
    ];
    final controller = PageController(viewportFraction: 0.8, keepPage: true);

    return Scaffold(
        body: Column(
      children: [
        Expanded(
            child: PageView(
          controller: controller,
          children: [...pages],
        )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SmoothPageIndicator(
            controller: controller,
            count: pages.length,
            effect: const WormEffect(
              dotHeight: 16,
              dotWidth: 16,
              type: WormType.thinUnderground,
            ),
          ),
        ),
      ],
    ));
  }
}

// const colors = [
//   Colors.red,
//   Colors.green,
//   Colors.greenAccent,
//   Colors.amberAccent,
//   Colors.blue,
//   Colors.amber,
// ];

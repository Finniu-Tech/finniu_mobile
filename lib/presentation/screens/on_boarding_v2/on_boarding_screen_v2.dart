import 'dart:async';

import 'package:finniu/presentation/screens/on_boarding_v2/widgets/page_one.dart';
import 'package:finniu/presentation/screens/on_boarding_v2/widgets/positiones_column.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OnBoardingScreen extends ConsumerWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: StackOnBoarding(),
      ),
    );
  }
}

class StackOnBoarding extends ConsumerStatefulWidget {
  const StackOnBoarding({
    super.key,
  });

  @override
  StackOnBoardingState createState() => StackOnBoardingState();
}

class StackOnBoardingState extends ConsumerState<StackOnBoarding> {
  int _index = 0;
  final PageController _controller = PageController(
    initialPage: 0,
    keepPage: false,
    viewportFraction: 1.0,
  );
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (_index < 4) {
        _index++;
      } else {
        _timer?.cancel();
      }
      _controller.animateToPage(
        _index,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (value) => setState(() => _index = value),
            children: const [
              PageOneContainer(),
              PageTwoContainer(),
              PageThreeContainer(),
              PageFourContainer(),
              PageFiveContainer(),
            ],
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.1,
            child: PositionedColumn(
              index: _index,
            ),
          ),
        ],
      ),
    );
  }
}

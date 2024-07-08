import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SliderBar extends ConsumerStatefulWidget {
  const SliderBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SliderBarState();
}

class _SliderBarState extends ConsumerState<SliderBar>
    with SingleTickerProviderStateMixin {
  late bool isDarkMode;
  late AnimationController _controller;
  late Animation<double> _animation;
  double width = 0.0;
  @override
  void initState() {
    super.initState();
    isDarkMode = ref.read(settingsNotifierProvider).isDarkMode;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 270,
    ).animate(_controller)
      ..addListener(() {
        setState(() {
          width = _animation.value;
        });
      });
    _controller.forward();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 20,
      child: StackSlider(
        width: width,
      ),
    );
  }
}

class StackSlider extends ConsumerWidget {
  const StackSlider({
    super.key,
    required this.width,
  });
  final double width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    int progressFillColor = isDarkMode ? 0xff0D3A5C : 0xffA2E6FA;
    int progressColor = isDarkMode ? 0xffA2E6FA : 0xff0D3A5C;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 3,
          width: 270,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Color(progressFillColor),
          ),
        ),
        Positioned(
          left: 0,
          child: Container(
            width: width,
            height: 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Color(progressColor),
            ),
          ),
        ),
        Positioned(
          left: width,
          top: 0,
          child: Container(
            width: 19,
            height: 19,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(progressColor),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Center(
              child: Image.asset(
                'assets/images/money_wings_19.png',
                width: 19,
                height: 19,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

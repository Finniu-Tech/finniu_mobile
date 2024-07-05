import 'package:finniu/constants/number_format.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AnimationNumber extends ConsumerWidget {
  const AnimationNumber({
    super.key,
    required this.endNumber,
    required this.duration,
    required this.fontSize,
    required this.colorText,
    required this.beginNumber,
  });

  final int endNumber;
  final int beginNumber;
  final int duration;
  final double fontSize;
  final int colorText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSoles = ref.watch(isSolesStateProvider);
    return TweenAnimationBuilder(
      tween: IntTween(begin: beginNumber, end: endNumber),
      duration: Duration(seconds: duration),
      builder: (BuildContext context, int value, Widget? child) {
        return Text(
          isSoles ? formatterSoles.format(value) : formatterUSD.format(value),
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Color(colorText),
          ),
        );
      },
    );
  }
}

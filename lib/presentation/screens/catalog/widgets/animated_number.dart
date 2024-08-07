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

  final num endNumber;
  final num beginNumber;
  final int duration;
  final double fontSize;
  final int colorText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSoles = ref.watch(isSolesStateProvider);

    return TweenAnimationBuilder(
      tween: Tween<double>(begin: beginNumber.toDouble(), end: endNumber.toDouble()),
      duration: Duration(seconds: duration),
      builder: (BuildContext context, double value, Widget? child) {
        final formattedValue = value % 1 == 0 ? value.toInt() : value;

        String formattedString;
        try {
          formattedString = isSoles ? formatterSoles.format(formattedValue) : formatterUSD.format(formattedValue);
        } catch (e) {
          formattedString = formattedValue.toStringAsFixed(2);
        }

        return Text(
          formattedString,
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

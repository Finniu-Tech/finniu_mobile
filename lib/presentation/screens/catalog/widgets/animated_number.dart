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
    this.isSoles,
  });

  final num endNumber;
  final num beginNumber;
  final int duration;
  final double fontSize;
  final int colorText;
  final bool? isSoles;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isSolesState = isSoles ?? ref.watch(isSolesStateProvider);

    return TweenAnimationBuilder(
      tween: Tween<double>(
          begin: beginNumber.toDouble(), end: endNumber.toDouble()),
      duration: Duration(seconds: duration),
      builder: (BuildContext context, double value, Widget? child) {
        final formattedValue = value % 1 == 0 ? value.toInt() : value;

        String formattedString;
        try {
          formattedString = isSolesState
              ? formatterSoles.format(formattedValue)
              : formatterUSD.format(formattedValue);
        } catch (e) {
          formattedString = formattedValue.toStringAsFixed(2);
        }

        return Text(
          formattedString,
          style: TextStyle(
            fontSize: fontSize,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
            color: Color(colorText),
          ),
        );
      },
    );
  }
}

class AnimationNumberNotComma extends ConsumerWidget {
  const AnimationNumberNotComma({
    super.key,
    required this.endNumber,
    required this.duration,
    required this.fontSize,
    required this.colorText,
    required this.beginNumber,
    required this.isSoles,
  });

  final num endNumber;
  final num beginNumber;
  final int duration;
  final double fontSize;
  final int colorText;
  final bool? isSoles;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isSolesState = isSoles ?? ref.watch(isSolesStateProvider);
    return TweenAnimationBuilder(
      tween: Tween<double>(
          begin: beginNumber.toDouble(), end: endNumber.toDouble()),
      duration: Duration(seconds: duration),
      builder: (BuildContext context, double value, Widget? child) {
        final formattedValue = value % 1 == 0 ? value.toInt() : value;

        String formattedString;
        try {
          formattedString = isSolesState
              ? formatterSolesNotComma.format(formattedValue)
              : formatterUSDNotComma.format(formattedValue);
        } catch (e) {
          formattedString = formattedValue.toStringAsFixed(2);
        }

        return Text(
          formattedString,
          style: TextStyle(
            fontSize: fontSize,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
            color: Color(colorText),
          ),
        );
      },
    );
  }
}

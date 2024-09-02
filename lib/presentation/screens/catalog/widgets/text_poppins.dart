import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TextPoppins extends ConsumerWidget {
  final String text;
  final double fontSize;
  final int? textDark;
  final int? textLight;
  final bool? isBold;
  final int? lines;
  final TextAlign? align;

  const TextPoppins({
    super.key,
    required this.text,
    required this.fontSize,
    this.textDark,
    this.textLight,
    this.isBold,
    this.lines,
    this.align,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return Text(
      text,
      textAlign: align ?? TextAlign.start,
      maxLines: lines ?? 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: "Poppins",
        fontSize: fontSize,
        color: isDarkMode
            ? Color(textDark ?? 0xffffffff)
            : Color(textLight ?? 0xff000000),
        fontWeight: (isBold ?? false) ? FontWeight.w500 : FontWeight.w400,
      ),
    );
  }
}

class TextSans extends ConsumerWidget {
  final String text;
  final double fontSize;
  final int? textDark;
  final int? textLight;
  final FontWeight? fontWeight;
  final int? lines;
  final TextAlign? align;

  const TextSans({
    super.key,
    required this.text,
    required this.fontSize,
    this.textDark,
    this.textLight,
    this.fontWeight,
    this.lines,
    this.align,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return Text(
      text,
      textAlign: align ?? TextAlign.start,
      maxLines: lines ?? 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: "DM Sans",
        fontSize: fontSize,
        color: isDarkMode
            ? Color(textDark ?? 0xffffffff)
            : Color(textLight ?? 0xff000000),
        fontWeight: fontWeight ?? FontWeight.w500,
      ),
    );
  }
}

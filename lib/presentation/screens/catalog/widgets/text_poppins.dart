import 'package:auto_size_text/auto_size_text.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// class TextPoppins extends ConsumerWidget {
//   final String text;
//   final double fontSize;
//   final int? textDark;
//   final int? textLight;
//   final bool? isBold;
//   final int? lines;
//   final TextAlign? align;
//   final FontWeight? fontWeight;
//   final double? width;
//   final double? height;
//   final Alignment? alignmentSized;

//   const TextPoppins({
//     super.key,
//     required this.text,
//     required this.fontSize,
//     this.textDark,
//     this.textLight,
//     this.isBold,
//     this.lines,
//     this.align,
//     this.fontWeight,
//     this.width,
//     this.height,
//     this.alignmentSized,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
//     return SizedBox(
//       width: width ?? MediaQuery.of(context).size.width * 0.6,
//       height: 24.0 * (lines ?? 1.0),
//       child: Align(
//         alignment: alignmentSized ?? Alignment.centerLeft,
//         child: AutoSizeText(
//           text,
//           textAlign: align ?? TextAlign.start,
//           maxLines: lines ?? 1,
//           overflow: TextOverflow.ellipsis,
//           style: TextStyle(
//             fontFamily: "Poppins",
//             fontSize: fontSize,
//             color: isDarkMode
//                 ? Color(textDark ?? 0xffffffff)
//                 : Color(textLight ?? 0xff000000),
//             fontWeight: fontWeight ?? FontWeight.w400,
//           ),
//         ),
//       ),
//     );
//   }
// }

class TextPoppins extends ConsumerWidget {
  final String text;
  final double fontSize;
  final int? textDark;
  final int? textLight;

  final int? lines;
  final TextAlign? align;
  final FontWeight? fontWeight;

  const TextPoppins({
    super.key,
    required this.text,
    required this.fontSize,
    this.textDark,
    this.textLight,
    this.lines,
    this.align,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return AutoSizeText(
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
        fontWeight: fontWeight ?? FontWeight.w400,
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
    return AutoSizeText(
      text,
      textAlign: align ?? TextAlign.start,
      // maxLines: lines ?? 1,
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

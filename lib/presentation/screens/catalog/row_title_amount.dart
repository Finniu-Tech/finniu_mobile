import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/catalog/widgets/animated_number.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RowTitleAmount extends ConsumerWidget {
  const RowTitleAmount({
    super.key,
    required this.lineRow,
    required this.titleColorDark,
    required this.titleColorLight,
    required this.amountColorDark,
    required this.amountColorLight,
    required this.height,
    required this.textTitle,
    required this.amountNumber,
    required this.titleSize,
    required this.amountSize,
    this.isLoader = false,
  });
  final int lineRow;
  final int titleColorDark;
  final int titleColorLight;
  final int amountColorDark;
  final int amountColorLight;
  final double height;
  final String textTitle;
  final int amountNumber;
  final double titleSize;
  final double amountSize;
  final bool isLoader;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: height,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(lineRow),
              borderRadius: BorderRadius.circular(10),
            ),
            width: 6,
            height: 74,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textTitle,
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode
                      ? Color(titleColorDark)
                      : Color(titleColorLight),
                ),
              ),
              isLoader
                  ? CircularLoader(
                      height: height - 30,
                      width: height - 30,
                    )
                  : AnimationNumber(
                      beginNumber: 0,
                      endNumber: amountNumber,
                      duration: 1,
                      fontSize: amountSize,
                      colorText:
                          isDarkMode ? amountColorDark : amountColorLight,
                    ),
            ],
          ),
        ],
      ),
    );
  }
}

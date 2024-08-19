import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CheckBoxInput extends ConsumerWidget {
  const CheckBoxInput({
    super.key,
    required this.checkboxValue,
    required this.onPressed,
    required this.text,
  });
  final bool checkboxValue;
  final VoidCallback onPressed;
  final String text;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    const int linkDark = 0xffA2E6FA;
    const int linkLight = 0xff0D3A5C;
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: TextPoppins(
              text: text,
              fontSize: 14,
              lines: 3,
            ),
          ),
          Checkbox(
            activeColor:
                isDarkMode ? const Color(linkDark) : const Color(linkLight),
            value: checkboxValue,
            onChanged: (onChanged) {
              onPressed();
            },
          ),
        ],
      ),
    );
  }
}

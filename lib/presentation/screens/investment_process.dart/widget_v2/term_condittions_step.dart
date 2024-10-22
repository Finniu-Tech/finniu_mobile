import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/expansion_title_profile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TermConditionsStep extends ConsumerWidget {
  const TermConditionsStep({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int textDark = 0xffFFFFFF;
    const int textLight = 0xff0D3A5C;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CheckBoxWidget(
          value: true,
          onChanged: (value) {},
        ),
        Text.rich(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          TextSpan(
            text: "He leído y acepto el ",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color:
                  isDarkMode ? const Color(textDark) : const Color(textLight),
            ),
            children: [
              TextSpan(
                text: 'Contrato de Inversión de Finniu',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode
                      ? const Color(textDark)
                      : const Color(textLight),
                ),
              ),
            ],
          ),
          textAlign: TextAlign.start,
        ),
      ],
    );
  }
}

class TextRickStep extends ConsumerWidget {
  const TextRickStep({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int textDark = 0xffFFFFFF;
    const int textLight = 0xff0D3A5C;
    return Text.rich(
      TextSpan(
        text: "Realiza tu transferencia de ",
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: isDarkMode ? const Color(textDark) : const Color(textLight),
        ),
        children: [
          TextSpan(
            text: 'S/5,000',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color:
                  isDarkMode ? const Color(textDark) : const Color(textLight),
            ),
          ),
          TextSpan(
            text: ' a la cuenta bancaria de Finniu:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color:
                  isDarkMode ? const Color(textDark) : const Color(textLight),
            ),
          ),
        ],
      ),
      textAlign: TextAlign.start,
    );
  }
}

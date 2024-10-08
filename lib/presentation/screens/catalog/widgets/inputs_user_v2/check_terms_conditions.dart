import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CheckTermsAndConditions extends ConsumerWidget {
  const CheckTermsAndConditions({
    super.key,
    required this.checkboxValue,
    required this.onPressed,
  });
  final bool checkboxValue;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int spanDark = 0xffFFFFFF;
    const int spanLight = 0xff000000;
    const int linkDark = 0xffA2E6FA;
    const int linkLight = 0xff0D3A5C;
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            activeColor:
                isDarkMode ? const Color(linkDark) : const Color(linkLight),
            value: checkboxValue,
            onChanged: (onChanged) {
              onPressed();
            },
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Estoy de acuerdo con los ',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDarkMode
                              ? const Color(spanDark)
                              : const Color(spanLight),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins",
                        ),
                      ),
                      TextSpan(
                        text:
                            'Términos & condiciones y Políticas de privacidad',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDarkMode
                              ? const Color(linkDark)
                              : const Color(linkLight),
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins",
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print("tap");
                            print(
                              "al usuario que lea los terminos y condiciones hay que darle un premio",
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

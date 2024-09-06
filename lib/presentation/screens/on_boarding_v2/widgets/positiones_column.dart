import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/on_boarding_v2/widgets/page_select.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PositionedColumn extends ConsumerWidget {
  const PositionedColumn({
    super.key,
    required this.index,
    required this.pushRegister,
    required this.pushLogin,
  });
  final int index;
  final VoidCallback pushRegister;
  final VoidCallback pushLogin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PageSelect(
            isDarkMode: index == 0
                ? false
                : index == 1
                    ? isDarkMode
                    : true,
            index: index,
          ),
          const SizedBox(
            height: 20,
          ),
          OnboardingButton(
            isDarkMode: index == 0
                ? false
                : index == 1
                    ? isDarkMode
                    : true,
            text: "Crear mi cuenta",
            onPressed: pushRegister,
          ),
          const SizedBox(
            height: 10,
          ),
          TextAsk(
            isDarkMode: index == 0
                ? false
                : index == 1
                    ? isDarkMode
                    : true,
          ),
          const SizedBox(
            height: 10,
          ),
          UnderlinedButtonText(
            isDarkMode: index == 0
                ? false
                : index == 1
                    ? isDarkMode
                    : true,
            text: "Ingresar",
            onPressed: pushLogin,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class UnderlinedButtonText extends StatelessWidget {
  const UnderlinedButtonText({
    super.key,
    required this.isDarkMode,
    required this.text,
    required this.onPressed,
  });
  final String text;
  final bool isDarkMode;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    const int textColorDark = 0xffA2E6FA;
    const int textColorLight = 0xff0D3A5C;
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          decoration: TextDecoration.underline,
          decorationColor: isDarkMode
              ? const Color(textColorDark)
              : const Color(textColorLight),
          color: isDarkMode
              ? const Color(textColorDark)
              : const Color(textColorLight),
          fontFamily: "Poppins",
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class TextAsk extends StatelessWidget {
  const TextAsk({
    super.key,
    required this.isDarkMode,
  });
  final bool isDarkMode;
  @override
  Widget build(BuildContext context) {
    const int textColorDark = 0xffFFFFFF;
    const int textColorLight = 0xff000000;
    const String text = "¿Ya tienes una cuenta?";
    return TextPoppins(
      text: text,
      fontSize: 16,
      isBold: false,
      textLight: isDarkMode ? textColorDark : textColorLight,
      textDark: isDarkMode ? textColorDark : textColorLight,
    );
  }
}

class OnboardingButton extends StatelessWidget {
  const OnboardingButton({
    super.key,
    required this.isDarkMode,
    required this.text,
    required this.onPressed,
  });
  final void Function()? onPressed;
  final String text;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    const int buttonColorDark = 0xffA2E6FA;
    const int buttonColorLight = 0xff0D3A5C;
    const int textColorDark = 0xff000000;
    const int textColorLight = 0xffFFFFFF;
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(5),
          backgroundColor: WidgetStateProperty.all(
            isDarkMode
                ? const Color(buttonColorDark)
                : const Color(buttonColorLight),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isDarkMode
                ? const Color(textColorDark)
                : const Color(textColorLight),
            fontSize: 16,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

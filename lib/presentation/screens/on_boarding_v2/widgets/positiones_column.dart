import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/on_boarding_v2/widgets/page_select.dart';
import 'package:flutter/material.dart';

class PositionedColumn extends StatelessWidget {
  const PositionedColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const bool isDarkMode = false;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const PageSelect(isDarkMode: false),
          const SizedBox(
            height: 20,
          ),
          OnboardingButton(
            isDarkMode: isDarkMode,
            text: "Crear mi cuenta",
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(
            height: 20,
          ),
          const TextAsk(
            isDarkMode: isDarkMode,
          ),
          const SizedBox(
            height: 10,
          ),
          UnderlinedButtonText(
            isDarkMode: isDarkMode,
            text: "Ingresar",
            onPressed: () => Navigator.pop(context),
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
          color: isDarkMode ? Color(textColorDark) : Color(textColorLight),
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
    return TextPoppins(
      text: "¿Ya tienes una cuenta?",
      fontSize: 16,
      isBold: false,
      textLight: isDarkMode ? textColorDark : textColorLight,
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

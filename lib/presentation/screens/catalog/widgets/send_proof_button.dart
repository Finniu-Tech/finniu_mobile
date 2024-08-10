import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ButtonSendProof extends StatelessWidget {
  const ButtonSendProof({
    super.key,
  });

  final String textBody =
      '''Recuerda que las tranferencias se confimarán en un plazo de 24hr si son directas y en un plazo de máximo 72hr si son interbancarios!''';
  final String textTitle = 'Gracias por \ninvertir en Finniu!';
  final String textTanks = 'Gracias por tu comprensión! ';
  final String textButton = 'Ver mi progreso';

  @override
  Widget build(BuildContext context) {
    void onPressAndNavigate() {
      Navigator.pop(context);
    }

    return ButtonInvestment(
      text: 'Enviar constancia',
      onPressed: () => showThanksInvestmentDialog(
        context,
        textBody: textBody,
        textTitle: textTitle,
        textTanks: textTanks,
        textButton: textButton,
        onPressed: onPressAndNavigate,
      ),
    );
  }
}

class ButtonInvestment extends ConsumerWidget {
  final String text;
  final VoidCallback? onPressed;
  const ButtonInvestment({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(5),
          backgroundColor: WidgetStateProperty.all(
            Color(
              isDarkMode
                  ? buttonBackgroundColorDark
                  : buttonBackgroundColorLight,
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isDarkMode
                ? const Color(colorTextButtonDarkColor)
                : const Color(colorTextButtonLightColor),
            fontSize: 16,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class ButtonDialog extends ConsumerWidget {
  final String text;
  final VoidCallback? onPressed;
  const ButtonDialog({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 45,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            Color(
              isDarkMode
                  ? buttonBackgroundColorDark
                  : buttonBackgroundColorLight,
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isDarkMode
                ? const Color(colorTextButtonDarkColor)
                : const Color(colorTextButtonLightColor),
            fontSize: 16,
            fontFamily: "Poppins",
          ),
        ),
      ),
    );
  }
}

Future<dynamic> showThanksInvestmentDialog(BuildContext context,
    {required String textTanks,
    required String textBody,
    required String textTitle,
    required String textButton,
    required VoidCallback? onPressed,
    VoidCallback? onClosePressed}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Dialog(
      child: BodyDialog(
        textTanks: textTanks,
        textBody: textBody,
        textTitle: textTitle,
        textButton: textButton,
        onPressed: onPressed,
        onClosePressed: onClosePressed,
      ),
    ),
  );
}

class BodyDialog extends ConsumerWidget {
  final String textTanks;
  final String textBody;
  final String textTitle;
  final String textButton;
  final VoidCallback? onPressed;
  final VoidCallback? onClosePressed;
  const BodyDialog(
      {super.key,
      required this.textTanks,
      required this.textBody,
      required this.textTitle,
      required this.textButton,
      required this.onPressed,
      this.onClosePressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      width: 329,
      height: 272,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: onClosePressed ?? () => Navigator.pop(context),
              icon: Transform.rotate(
                angle: math.pi / 4,
                child: const Icon(
                  Icons.add_circle_outline,
                  size: 25,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 282,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 23,
                ),
                Row(
                  children: [
                    Text(
                      textTitle,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode
                            ? const Color(labelTextDarkColor)
                            : const Color(labelTextLightColor),
                      ),
                    ),
                    Image.asset('assets/icons/icon_tanks.png'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      textBody,
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: "Poppins",
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      textTanks,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins",
                        color: isDarkMode
                            ? const Color(labelTextDarkColor)
                            : const Color(labelTextLightColor),
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ButtonDialog(
                  onPressed: onPressed,
                  text: textButton,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

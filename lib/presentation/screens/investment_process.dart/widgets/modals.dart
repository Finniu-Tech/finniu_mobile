import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math' as math;

Future<dynamic> showThanksForInvestingModal(BuildContext context, VoidCallback onPressed) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => ThanksForInvestingModal(
      onPressed: onPressed,
    ),
  );
}

class ThanksForInvestingModal extends ConsumerWidget {
  final VoidCallback onPressed;
  const ThanksForInvestingModal({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final String titleText = "Gracias por";
    final String secondTitleText = "invertir en Finniu!";
    final String textButton = "Ver mi progreso";
    final String textTanks = "Gracias por tu comprensión!";
    final String anyResponse = "";
    final String textBody =
        "Recuerda que las tranferencias se confimarán en un plazo de 24hr si son directas y en un plazo de máximo 72hr si son interbancarios!";

    return ThanksModalBody(
      titleText: titleText,
      secondTitleText: secondTitleText,
      textBody: textBody,
      textTanks: textTanks,
      anyResponse: anyResponse,
      textButton: textButton,
      isDarkMode: isDarkMode,
      onPressed: onPressed,
    );
  }
}

class ThanksModalBody extends StatelessWidget {
  const ThanksModalBody({
    super.key,
    required this.titleText,
    required this.isDarkMode,
    required this.secondTitleText,
    required this.textBody,
    required this.textTanks,
    required this.anyResponse,
    required this.onPressed,
    required this.textButton,
  });

  final String titleText;
  final bool isDarkMode;
  final String secondTitleText;
  final String textBody;
  final String textTanks;
  final String anyResponse;
  final VoidCallback onPressed;
  final String textButton;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        width: 329,
        height: 272,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titleText,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? const Color(labelTextDarkColor) : const Color(labelTextLightColor),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            secondTitleText,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? const Color(labelTextDarkColor) : const Color(labelTextLightColor),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset('assets/icons/icon_tanks.png'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
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
                          color: isDarkMode ? const Color(labelTextDarkColor) : const Color(labelTextLightColor),
                        ),
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ThankButtonDialog(
                    onPressed: onPressed,
                    text: textButton,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThankButtonDialog extends ConsumerWidget {
  final String text;
  final VoidCallback? onPressed;
  const ThankButtonDialog({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 38,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            const Color(primaryDark),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(whiteText),
                fontSize: 14,
                fontFamily: "Poppins",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountNumbersWidget extends StatelessWidget {
  const AccountNumbersWidget({
    super.key,
    required this.currentTheme,
    required this.textCurrency,
    required this.isSoles,
  });

  final SettingsProviderState currentTheme;
  final String textCurrency;
  final bool isSoles;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 154,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(38),
        ),
        color: currentTheme.isDarkMode
            ? const Color(
                primaryDark,
              )
            : const Color(gradient_secondary),
        border: Border.all(
          color: currentTheme.isDarkMode ? const Color(primaryDark) : const Color(gradient_secondary),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Finniu S.A.C',
                style: TextStyle(
                  color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'RUC ',
                    style: TextStyle(
                      color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(grayText),
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '20609327210',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(grayText),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Text(
                    'N de cuenta $textCurrency Interbank ',
                    style: TextStyle(
                      color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(grayText),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    isSoles ? '2003004077570' : '2003004754309',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(grayText),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(
                        ClipboardData(
                          text: isSoles ? "2003004077570" : "2003004754309",
                        ),
                      ).then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Copiado!'),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        );
                      });
                    },
                    child: ImageIcon(
                      color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(grayText),
                      size: 18,
                      const AssetImage(
                        'assets/icons/double_square.png',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Text(
                    'CCI ',
                    style: TextStyle(
                      color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(grayText),
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    isSoles ? '003 200 00300407757039' : '003 20000300475430932',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(grayText),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(
                        ClipboardData(
                          text: isSoles ? "00320000300407757039" : '00320000300475430932',
                        ),
                      ).then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Copiado!'),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        );
                      });
                    },
                    child: ImageIcon(
                      color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(grayText),
                      size: 18,
                      const AssetImage(
                        'assets/icons/double_square.png',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

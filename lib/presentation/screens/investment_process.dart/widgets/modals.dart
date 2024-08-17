import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math' as math;
import 'package:permission_handler/permission_handler.dart';

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
                    'N de cuenta corriente $textCurrency Interbank ',
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

void showGrantPermissionModal(BuildContext ctx, bool isDarkMode, bool showRequestVersionModal) {
  showDialog(
    context: ctx,
    builder: (ctx) => AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      backgroundColor: isDarkMode ? const Color(backgroundColorDark) : const Color(orangeLight),
      content: GrantPermissionModalBody(
        showRequestVersionModal: showRequestVersionModal,
      ),
    ),
  );
}

class GrantPermissionModalBody extends HookConsumerWidget {
  final bool showRequestVersionModal;
  const GrantPermissionModalBody({super.key, required this.showRequestVersionModal});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(settingsNotifierProvider);
    const int darkModeOKButtonColor = 0xff333333;
    final String textBody = showRequestVersionModal
        ? 'Se ha denegado el acceso a la fototeca, porfavor habilítelo en Ajustes para poder adjuntar la foto de tu comprobante de pago.'
        : 'Se ha denegado el acceso a la fototeca, no podemos adjuntar la foto de tu comprobante de pago sin los permisos';
    return Container(
      height: 298,
      width: 319,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showRequestVersionModal
              ? const SizedBox.shrink()
              : Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: SvgPicture.asset(
                      'assets/svg_icons/x-circle.svg',
                      width: 24,
                      height: 24,
                      color: Color(themeProvider.isDarkMode ? whiteText : blackText),
                    ),
                  ),
                ),
          showRequestVersionModal ? const SizedBox.shrink() : const SizedBox(height: 20),
          const Center(
            child: Image(
              image: AssetImage('assets/images/cellphone.png'),
              height: 92,
              alignment: Alignment.center,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'Finniu',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            textBody,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: themeProvider.isDarkMode ? const Color(whiteText) : const Color(blackText),
            ),
          ),
          const SizedBox(height: 20),
          showRequestVersionModal
              ? SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                          backgroundColor: Color(
                            themeProvider.isDarkMode ? darkModeOKButtonColor : primaryLight,
                          ),
                        ),
                        child: Text(
                          'OK',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: themeProvider.isDarkMode ? Colors.white : Color(primaryDark),
                          ),
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          backgroundColor: Color(
                            themeProvider.isDarkMode ? primaryLight : primaryDark,
                          ),
                        ),
                        onPressed: () {
                          openAppSettings();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Ir a los ajustes',
                          style: TextStyle(
                            color: themeProvider.isDarkMode ? const Color(primaryDark) : Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

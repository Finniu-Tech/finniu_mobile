import 'dart:ui';

import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math' as math;

class NoInvestmentsButton extends ConsumerWidget {
  const NoInvestmentsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () => noInvestmentsModal(context, '/v4/home'),
      child: const Text('new modal'),
    );
  }
}

Future<dynamic> noInvestmentsModal(BuildContext context, String routeName) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => NoInvestmentBody(
      onPressed: () => Navigator.pushNamedAndRemoveUntil(
        context,
        routeName,
        (route) => false,
      ),
    ),
  );
}

class NoInvestmentBody extends ConsumerWidget {
  final VoidCallback? onPressed;
  const NoInvestmentBody({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                color: isDarkMode
                    ? Colors.black.withOpacity(0.4)
                    : Colors.white.withOpacity(0.4),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.2,
              left: 0,
              right: 0,
              child: Center(
                child: ContainerEmptyMessageWidget(
                  onPressed: onPressed,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ContainerEmptyMessageWidget extends ConsumerWidget {
  final void Function()? onPressed;
  const ContainerEmptyMessageWidget({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const String titleText = "Aún no has realizado tu primera inversión";
    // const String titleText = "Aún no has realizado tu primera inversión 🥹";
    const String bodyText =
        "Descubre los fondos que tenemos para ti y realiza tu primera inversión.";
    // "Descubre nuestros fondos y realiza tu primera inversión en uno de nuestros fondos que tenemos para ti.";
    const int buttonTextColorDark = 0xff0D3A5C;
    const int buttonTextColorLight = 0xffFFFFFF;
    const int buttonBackgroundColorDark = 0xffA2E6FA;
    const int buttonBackgroundColorLight = 0xff0D3A5C;
    const int dialogBackgroundColorDark = 0xff1A1A1A;
    const int dialogBackgroundColorLight = 0xffFFFFFF;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode
            ? Color(dialogBackgroundColorDark)
            : Color(dialogBackgroundColorLight),
        borderRadius: BorderRadius.circular(10),
      ),
      width: 287,
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextPoppins(
            text: titleText,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            lines: 2,
          ),
          TextPoppins(
            text: bodyText,
            fontSize: 12,
            lines: 3,
          ),
          ElevatedButton(
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextPoppins(
                  text: 'Ver los fondos de inversión',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  textLight: buttonTextColorLight,
                  textDark: buttonTextColorDark,
                ),
                const SizedBox(width: 5),
                Transform.rotate(
                  angle: math.pi / -4,
                  child: Icon(
                    Icons.arrow_forward,
                    size: 25,
                    color: isDarkMode
                        ? Color(buttonTextColorDark)
                        : Color(buttonTextColorLight),
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

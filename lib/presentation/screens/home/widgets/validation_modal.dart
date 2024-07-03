import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math' as math;

class ValidationModal extends StatelessWidget {
  const ValidationModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: () => showValidationModal(context),
        child: const Text('showValidationModal'),
      ),
    );
  }
}

Future<dynamic> showValidationModal(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => const ValidationDialog(),
  );
}

class ValidationDialog extends ConsumerWidget {
  const ValidationDialog({
    super.key,
  });
  final String titleText = "Validación de tu\ninversión";
  final String textTanks = "Gracias por tu comprensión!";
  final String anyResponse = "¿No tuviste ninguna respuesta?";
  final String textBody =
      "Recuerda que las tranferencias se confimarán en un plazo de 24hr si son directas y en un plazo de máximo 72hr si son interbancarios!";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
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
                  Row(
                    children: [
                      Text(
                        titleText,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode
                              ? const Color(labelTextDarkColor)
                              : const Color(labelTextLightColor),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Image.asset('assets/icons/validation_icon.png'),
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
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          height: 3,
                          color: Color(0xffBFF0FF),
                        ),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(anyResponse),
                      const SizedBox(
                        width: 3,
                      ),
                      const Expanded(
                        child: Divider(
                          height: 2,
                          color: Color(0xffBFF0FF),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const ButtonIconDialog(
                    onPressed: null,
                    text: "Hablar con un asesor",
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

class ButtonIconDialog extends ConsumerWidget {
  final String text;
  final VoidCallback? onPressed;
  const ButtonIconDialog({
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
            const Color(buttonBackgroundColorDark),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.chat_outlined,
              color: Color(colorTextButtonDarkColor),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(colorTextButtonDarkColor),
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

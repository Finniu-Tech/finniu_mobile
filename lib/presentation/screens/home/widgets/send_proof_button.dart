import 'package:finniu/constants/colors.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

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

class ButtonInvestment extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const ButtonInvestment({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              WidgetStateProperty.all(const Color(buttonBackgroundColorLight)),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: "Poppins",
          ),
        ),
      ),
    );
  }
}

class ButtonDialog extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const ButtonDialog({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 45,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              WidgetStateProperty.all(const Color(buttonBackgroundColorLight)),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: "Poppins",
          ),
        ),
      ),
    );
  }
}

Future<dynamic> showThanksInvestmentDialog(
  BuildContext context, {
  required String textTanks,
  required String textBody,
  required String textTitle,
  required String textButton,
  required VoidCallback? onPressed,
}) {
  return showDialog(
    context: context,
    builder: (context) => Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        textTitle,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
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
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
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
      ),
    ),
  );
}

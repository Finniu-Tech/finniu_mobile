import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/reinvest_process/widgets/cards_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void showBankAccountModal(BuildContext ctx, WidgetRef ref, String currency, bool isSender, String typeReInvestment) {
  final themeProvider = ref.watch(settingsNotifierProvider);

  showModalBottomSheet(
    context: ctx,
    isDismissible: false,
    isScrollControlled: true,
    builder: (context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              textAlign: TextAlign.center,
              isSender
                  ? '¿Desde qué cuenta nos transfieres el dinero? 💸'
                  : '¿A qué cuenta transferimos tu rentabilidad? 💸',
              style: TextStyle(
                fontSize: 20,
                color: Color(primaryDark),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CreditCardWheel(currency: currency, isSender: isSender, typeReInvestment: typeReInvestment),
          ],
        ),
      );
    },
  );
}

void showThanksModal(BuildContext ctx) {
  showDialog(
    context: ctx,
    builder: (context) {
      return ThankYouModal();
    },
  );
}

class ThankYouModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: 358,
        height: 356,
        padding: const EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
        decoration: BoxDecoration(
          color: const Color(primaryDark),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Image(
              image: AssetImage('assets/reinvestment/clock_with_face.png'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Gracias por invertir en Finniu.\nRecuerda que las transferencias se confirmarán en un plazo de 24hr si son directas y en un plazo máximo de 72hr si son interbancarios!\nGracias por tu comprensión!',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Acción al presionar el botón "Siguiente"
                Navigator.of(context).pop();
                //go to evaluation screen
                Navigator.of(context).pushNamed('/evaluation');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(primaryLight),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Siguiente',
                    style: TextStyle(
                      color: Color(primaryDark),
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.arrow_forward,
                    color: Color(primaryDark),
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

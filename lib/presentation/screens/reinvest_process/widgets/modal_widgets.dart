import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/reinvest_process/widgets/cards_widgets.dart';
import 'package:flutter/cupertino.dart';
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
        height: 580,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Text(
                  textAlign: TextAlign.center,
                  isSender
                      ? '¿Desde qué cuenta nos transfieres el dinero? 💸'
                      : '¿A qué cuenta transferimos tu rentabilidad? 💸',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color(primaryDark),
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
      return ThanksReinvestmentModal();
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
                backgroundColor: const Color(primaryLight),
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

class VoucherHelpModal extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Agregar Voucher',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8.0),
                Image.asset(
                  'assets/reinvestment/voucher.png',
                  height: 24,
                  width: 24,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Recuerda solo subir el voucher del monto agregado para tu reinversión',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 24.0),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
              child: const Text('Entendido'),
            ),
          ],
        ),
      ),
    );
  }
}

class ThanksReinvestmentModal extends StatefulHookConsumerWidget {
  @override
  _ReinvestmentModalState createState() => _ReinvestmentModalState();
}

class _ReinvestmentModalState extends ConsumerState<ThanksReinvestmentModal> {
  int _currentStep = 0;

  void _nextStep() {
    setState(() {
      _currentStep = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: _currentStep == 0 ? _buildFirstStep(context) : _buildSecondStep(context),
      ),
    );
  }

  Widget _buildFirstStep(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 90,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Text(
                '¡Gracias por reinvertir\nen Finniu!',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Positioned(
                top: 40,
                right: 50,
                child: Image.asset(
                  'assets/reinvestment/clock_with_face.png',
                  height: 46,
                  width: 70,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            Image.asset(
              'assets/reinvestment/check_circle.png',
              height: 24,
              width: 24,
            ),
            SizedBox(width: 8.0),
            Flexible(
              child: Text(
                'Recuerda que las transferencias se confirmarán en un plazo de 24hr\nsi son directas',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 12.0, color: Colors.black),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/reinvestment/check_circle.png',
              height: 24,
              width: 24,
            ),
            SizedBox(width: 8.0),
            Flexible(
              child: Text(
                'En un plazo de máximo 72hr\nsi son interbancarios!',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 12.0, color: Colors.black),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24.0),
        TextButton(
          onPressed: _nextStep,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Siguiente'),
              SizedBox(width: 10),
              Icon(Icons.arrow_forward),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSecondStep(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/reinvestment/status_reinvestment.png',
          height: 144,
          width: 270,
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/reinvestment/check_circle.png',
              height: 24,
              width: 24,
            ),
            SizedBox(width: 8.0),
            Text(
              'Recuerda que puedes ver el\nestado de tu reinversión dentro\nde tus operaciones en proceso',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 14.0, color: Colors.black),
            ),
          ],
        ),
        const SizedBox(height: 24.0),
        TextButton(
          onPressed: () {
            // Acción al presionar el botón "Siguiente"
            Navigator.of(context).pop();
            //go to evaluation screen
            // Navigator.of(context).pushNamed('/evaluation');
            //GO TO HISTORY
            Navigator.of(context).pushNamed('/process_investment');
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
          ),
          child: const Text('Ir a mi historial'),
        ),
      ],
    );
  }
}

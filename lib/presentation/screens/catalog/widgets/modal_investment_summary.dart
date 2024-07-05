import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math' as math;

class ModalInvestmentSummary extends StatelessWidget {
  const ModalInvestmentSummary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonInvestment(
      text: 'Invierte',
      onPressed: () => showModalBottomSheet(
        context: context,
        builder: (context) => const BodyModalInvestment(),
      ),
    );
  }
}

class BodyModalInvestment extends ConsumerWidget {
  const BodyModalInvestment({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      width: 375,
      height: 529,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            CloseButton(),
            TitleModal(),
            IconFond(),
          ],
        ),
      ),
    );
  }
}

class IconFond extends StatelessWidget {
  const IconFond({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          width: 259,
          height: 30,
          padding: const EdgeInsets.only(right: 10),
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(aboutContainerBusinessColor),
          ),
          child: const Text(
            'Fondo préstamo empresarial ',
            textAlign: TextAlign.end,
            style: TextStyle(
              color: Color(aboutTextBusinessColor),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(aboutIconBusinessColor),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Image.asset(
              'assets/investment/business_loans_investment_icon.png',
            ),
          ),
        ),
      ],
    );
  }
}

class TitleModal extends StatelessWidget {
  const TitleModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Resumen de mi inversión",
          style: TextStyle(
            color: Color(0xff0D3A5C),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          width: 73,
          height: 26,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xff55B63D),
          ),
          child: const Center(
            child: Text(
              "En curso",
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CloseButton extends StatelessWidget {
  const CloseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Transform.rotate(
            angle: math.pi / 4,
            child: const Icon(
              Icons.add_circle_outline,
              size: 20,
              color: Color(0xff515151),
            ),
          ),
        ),
      ],
    );
  }
}

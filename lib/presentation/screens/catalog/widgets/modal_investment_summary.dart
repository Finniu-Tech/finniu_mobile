import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/screens/catalog/widgets/animated_number.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      width: MediaQuery.of(context).size.width,
      height: 529,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          children: [
            CloseButton(),
            SizedBox(height: 10),
            TitleModal(),
            SizedBox(height: 10),
            IconFond(),
            SizedBox(height: 10),
            InvestmentAmountCardsRow(),
            SizedBox(height: 10),
            TermProfitabilityRow(),
            SizedBox(height: 10),
            SelectedBank(),
            SizedBox(height: 10),
            InvestmentEnds(),
          ],
        ),
      ),
    );
  }
}

class InvestmentEnds extends StatelessWidget {
  const InvestmentEnds({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: const Color(0xff0D3A5C),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Icon(
                Icons.calendar_today_outlined,
                color: Color(
                  0xff0D3A5C,
                ),
                size: 23,
              ),
            ],
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Tu inversión finaliza ",
                style: TextStyle(
                  color: Color(0xff000000),
                  fontSize: 16,
                ),
              ),
              Text(
                "10/07/2025",
                style: TextStyle(
                  color: Color(0xff0D3A5C),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SelectedBank extends StatelessWidget {
  const SelectedBank({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xffF1FCFF),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 13),
          Image.asset(
            "assets/images/bankSelectImage.png",
            width: 45,
            height: 45,
          ),
          const SizedBox(width: 10),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Banco donde se transfiere",
                style: TextStyle(
                  color: Color(0xff000000),
                  fontSize: 14,
                ),
              ),
              Text(
                "BCP *************321",
                style: TextStyle(
                  color: Color(0xff000000),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TermProfitabilityRow extends StatelessWidget {
  const TermProfitabilityRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 66,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xffF1FCFF),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: Color(
                    0xff0D3A5C,
                  ),
                  size: 23,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "A un Plazo de",
                      style: TextStyle(
                        color: Color(0xff000000),
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "12 meses",
                      style: TextStyle(
                        color: Color(0xff000000),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            height: 66,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xffF1FCFF),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.stacked_line_chart_outlined,
                  color: Color(
                    0xff0D3A5C,
                  ),
                  size: 23,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Rentabilidad",
                      style: TextStyle(
                        color: Color(0xff000000),
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "16 %",
                      style: TextStyle(
                        color: Color(0xff000000),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class InvestmentAmountCardsRow extends StatelessWidget {
  const InvestmentAmountCardsRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Container(
                width: 4,
                height: 47,
                color: const Color(0xffA2E6FA),
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Monto invertido',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff000000),
                    ),
                  ),
                  AnimationNumber(
                    beginNumber: 8000,
                    endNumber: 10000,
                    duration: 2,
                    fontSize: 16,
                    colorText: 0xff0D3A5C,
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Container(
                width: 4,
                height: 47,
                color: const Color(0xff83BF4F),
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Rentabilidad Final',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff000000),
                    ),
                  ),
                  AnimationNumber(
                    endNumber: 12000,
                    beginNumber: 10000,
                    duration: 2,
                    fontSize: 16,
                    colorText: 0xff0D3A5C,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class IconFond extends StatelessWidget {
  const IconFond({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              width: 273,
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
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
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
    return SizedBox(
      height: 40,
      child: Row(
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
      ),
    );
  }
}

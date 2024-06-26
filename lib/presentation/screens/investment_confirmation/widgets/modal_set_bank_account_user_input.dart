import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/screens/investment_confirmation/widgets/creadit_card_wheel_investment.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> showBankAccountSetBankMutationModal(
  ctx,
  WidgetRef ref,
  String currency,
  bool isSender,
  String typeReInvestment,
  String preInvestmentUuid,
) async {
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
            CreditCardWheelInvestment(
              currency: currency,
              isSender: isSender,
              typeReInvestment: typeReInvestment,
              preInvestmentUuid: preInvestmentUuid,
            ),
          ],
        ),
      );
    },
  );
}

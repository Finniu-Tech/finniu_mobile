import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/reinvest_process/widgets/cards_widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void bankAccountModal(BuildContext ctx, WidgetRef ref, String currency) {
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
            const Text(
              textAlign: TextAlign.center,
              '¿A qué cuenta transferimos tu rentabilidad? 💸',
              style: TextStyle(
                fontSize: 20,
                color: Color(primaryDark),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CreditCardWheel(currency: currency),
          ],
        ),
      );
    },
  );
}

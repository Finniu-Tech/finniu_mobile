import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/investment_complete.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PaymentCard extends ConsumerWidget {
  final String dateEnds;
  final int amount;
  final String? paymentVoucherUrl;
  final bool isPaid;
  final bool isSoles;
  final bool isCapitalPayment;

  const PaymentCard({
    super.key,
    required this.dateEnds,
    required this.amount,
    required this.paymentVoucherUrl,
    required this.isPaid,
    required this.isSoles,
    required this.isCapitalPayment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    int backgroundDark = isCapitalPayment ? 0xff6749E2 : 0xff08273F;

    int backgroundLight = isCapitalPayment ? 0xffCFC3FF : 0xffD6F6FF;
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 95,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isDarkMode ? Color(backgroundDark) : Color(backgroundLight),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AmountInvestmentFinal(
                  amount: amount,
                  isSoles: isSoles,
                  isCapital: isCapitalPayment,
                ),
                const SizedBox(height: 1),
                Text(
                  isPaid ? "Finalizado el $dateEnds" : "Finaliza el $dateEnds",
                  style: TextStyle(
                    fontSize: 10,
                    fontFamily: "Poppins",
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        LabelStateFinal(
          label: isPaid ? "Depositado" : "Próximo",
          isCapital: isCapitalPayment,
        ),
      ],
    );
  }
}

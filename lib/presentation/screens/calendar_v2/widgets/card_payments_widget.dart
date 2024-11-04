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
  const PaymentCard({
    super.key,
    required this.dateEnds,
    required this.amount,
    required this.paymentVoucherUrl,
    required this.isPaid,
    required this.isSoles,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    int backgroundLight = 0xffD6F6FF;
    int backgroundDark = 0xff08273F;
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
                AmountInvestment(
                  amount: amount,
                  isSoles: isSoles,
                ),
                const SizedBox(height: 1),
                Text(
                  isPaid ? "Finalizado el $dateEnds" : "Finaliza el $dateEnds",
                  style: TextStyle(
                    fontSize: 10,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        LabelState(
          label: isPaid ? "Depositado" : "Próximo",
        ),
        if (isPaid)
          DownloadButton(
            voucherUrl: paymentVoucherUrl ?? "",
          ),
      ],
    );
  }
}

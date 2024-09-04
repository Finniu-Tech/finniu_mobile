import 'package:finniu/presentation/screens/calendar_v2/widgets/card_payments_widget.dart';
import 'package:finniu/presentation/screens/calendar_v2/widgets/tab_payments_widget.dart';
import 'package:finniu/presentation/screens/catalog/widgets/no_investment_case.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentListView extends StatelessWidget {
  final List<PaymentData> list;
  final bool isPaymentFinished;
  const PaymentListView({super.key, required this.list, required this.isPaymentFinished});

  @override
  Widget build(BuildContext context) {
    final titleEmptyCase = isPaymentFinished ? "Aún no tiene un historial de pagos" : "Aún no tienes pagos próximos";
    const textBodyEmptyCase =
        "Recuerda que vas a poder visualizar tus pagos debe haber un plazo de 72hs para poder verlos";
    return SizedBox(
      child: list.isEmpty
          ? NoInvestmentCase(
              title: titleEmptyCase,
              textBody: textBodyEmptyCase,
            )
          : ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                final payment = list[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: PaymentCard(
                    dateEnds: DateFormat('dd-MM-yyyy').format(payment.paymentDate),
                    amount: payment.amount.toInt(),
                    paymentVoucherUrl: payment.paymentVoucherUrl,
                    isPaid: isPaymentFinished,
                    isSoles: payment.currency == PaymentCurrency.soles ? true : false,
                  ),
                );
              },
            ),
    );
  }
}

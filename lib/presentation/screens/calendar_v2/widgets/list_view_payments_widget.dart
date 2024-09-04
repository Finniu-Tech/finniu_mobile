import 'package:finniu/presentation/screens/calendar_v2/widgets/card_payments_widget.dart';
import 'package:finniu/presentation/screens/calendar_v2/widgets/tab_payments_widget.dart';
import 'package:finniu/presentation/screens/catalog/widgets/no_investment_case.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentListView extends StatelessWidget {
  final List<PaymentData> list;
  final PaymentStatus status;
  const PaymentListView({super.key, required this.list, required this.status});

  @override
  Widget build(BuildContext context) {
    final titleEmptyCase = "Aún no tienes registros de pagos ${status.displayName.toLowerCase()}";
    final isPaymentFinished = status == PaymentStatus.past || status == PaymentStatus.recent;
    return SizedBox(
      child: list.isEmpty
          ? NoInvestmentCase(
              title: titleEmptyCase,
              textBody: '',
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

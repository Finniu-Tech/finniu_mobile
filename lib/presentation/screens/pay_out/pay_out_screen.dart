import 'package:finniu/domain/entities/pay_out_entity.dart';
import 'package:finniu/presentation/providers/pay_out_provider.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/pay_out/widgets/container_pay_out.dart';
import 'package:finniu/presentation/screens/pay_out/widgets/title_subtitle_pay.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PayOutScreen extends StatelessWidget {
  const PayOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      bottomNavigationBar: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 70,
        child: Column(
          children: [
            ButtonInvestment(
              text: 'Entendido',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height,
            child: const _PayOutColumn(),
          ),
        ),
      ),
    );
  }
}

class _PayOutColumn extends ConsumerWidget {
  const _PayOutColumn();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payOut = ref.watch(payOutProvider('1'));

    return payOut.when(
      loading: () => const Center(child: CircularLoader(width: 50, height: 50)),
      error: (error, stack) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const IconsRow(),
          const SizedBox(height: 10),
          const TitlePayOut(status: PayOutStatus.failed),
          const SizedBox(height: 10),
          const SubTitlePayOut(status: PayOutStatus.failed),
          const SizedBox(height: 10),
          getContainerStatus(
            PayOutStatus.failed,
            PayOutEntity(
              amount: 'S/ 0.00',
              currency: 'Cuenta soles',
              accountNumber: '----------',
              urlImageAccount: '',
              status: PayOutStatus.failed,
            ),
          ),
        ],
      ),
      data: (data) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const IconsRow(),
          const SizedBox(height: 10),
          TitlePayOut(status: data.status),
          const SizedBox(height: 10),
          SubTitlePayOut(status: data.status),
          const SizedBox(height: 10),
          getContainerStatus(data.status, data),
        ],
      ),
    );
  }
}

Widget getContainerStatus(PayOutStatus status, PayOutEntity payOut) {
  switch (status) {
    case PayOutStatus.failed:
      return ContainerPayOutInvalid(
        amount: payOut.amount,
        currency: payOut.currency,
        accountNumber: payOut.accountNumber,
        urlImageAccount: payOut.urlImageAccount,
      );
    case PayOutStatus.pending:
      return ContainerPayOutInProgress(
        amount: payOut.amount,
        currency: payOut.currency,
        accountNumber: payOut.accountNumber,
        urlImageAccount: payOut.urlImageAccount,
      );
    case PayOutStatus.success:
      return ContainerPayOutFilled(
        amount: payOut.amount,
        currency: payOut.currency,
        accountNumber: payOut.accountNumber,
        urlImageAccount: payOut.urlImageAccount,
      );
    default:
      return ContainerPayOutInvalid(
        amount: payOut.amount,
        currency: payOut.currency,
        accountNumber: payOut.accountNumber,
        urlImageAccount: payOut.urlImageAccount,
      );
  }
}

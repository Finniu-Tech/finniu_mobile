import 'package:finniu/domain/entities/pay_out_entity.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/pay_out/widgets/container_pay_out.dart';
import 'package:finniu/presentation/screens/pay_out/widgets/title_subtitle_pay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PayOutScreen extends StatelessWidget {
  const PayOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      floatingActionButton: ButtonInvestment(
        text: 'Entendido',
        onPressed: () => Navigator.of(context).pop(),
      ),
      body: const _BodyPayOut(),
    );
  }
}

class _BodyPayOut extends StatelessWidget {
  const _BodyPayOut();

  @override
  Widget build(BuildContext context) {
    final PayOutEntity payOut = PayOutEntity(
      amount: 'S/ 1,000.00',
      currency: 'Cuenta soles',
      accountNumber: '122009301103',
      urlImageAccount:
          'https://finniu-statics-qa.s3.amazonaws.com/finniu/images/bank/f484570d/pichincha.png',
      status: PayOutStatus.failed,
    );

    Widget getContainerStatus(PayOutStatus status) {
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

    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const IconsRow(),
              const SizedBox(
                height: 10,
              ),
              TitlePayOut(
                status: payOut.status,
              ),
              const SizedBox(
                height: 10,
              ),
              SubTitlePayOut(
                status: payOut.status,
              ),
              const SizedBox(
                height: 10,
              ),
              getContainerStatus(payOut.status),
            ],
          ),
        ),
      ),
    );
  }
}

class IconsRow extends ConsumerWidget {
  const IconsRow({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int iconDark = 0xffA2E6FA;
    const int iconLight = 0xff03253E;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/rextie_image_${isDarkMode ? "dark" : "light"}.png",
          width: 70,
          height: 45,
        ),
        const SizedBox(
          width: 10,
        ),
        SvgPicture.asset(
          "assets/svg_icons/refresh_icon.svg",
          width: 20,
          height: 20,
          color: isDarkMode ? const Color(iconDark) : const Color(iconLight),
        ),
        const SizedBox(
          width: 10,
        ),
        Image.asset(
          "assets/images/logo_finniu_${isDarkMode ? "dark" : "light"}.png",
          width: 70,
          height: 45,
        ),
      ],
    );
  }
}

import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/pay_out/widgets/container_pay_out.dart';
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
    const String amount = 'S/ 1,000.00';
    const String currency = 'Cuenta soles';
    const String accountNumber = '122009301103';
    const String urlImageAccount =
        'https://finniu-statics-qa.s3.amazonaws.com/finniu/images/bank/f484570d/pichincha.pnga';
    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconsRow(),
              SizedBox(
                height: 10,
              ),
              TitlePayOut(),
              SizedBox(
                height: 10,
              ),
              SubTitlePayOut(),
              SizedBox(
                height: 10,
              ),
              ContainerPayOutInProgress(
                amount: amount,
                currency: currency,
                accountNumber: accountNumber,
                urlImageAccount: urlImageAccount,
              ),
              SizedBox(
                height: 10,
              ),
              ContainerPayOutFilled(
                amount: amount,
                currency: currency,
                accountNumber: accountNumber,
                urlImageAccount: urlImageAccount,
              ),
              SizedBox(
                height: 10,
              ),
              ContainerPayOutInvalid(
                amount: amount,
                currency: currency,
                accountNumber: accountNumber,
                urlImageAccount: urlImageAccount,
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubTitlePayOut extends StatelessWidget {
  const SubTitlePayOut({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const TextPoppins(
      text:
          "Puedes seguir el progreso de tu transacción. Gracias a nuestra alianza con Rextie, lo procesamos de manera segura y automática.",
      fontSize: 14,
      lines: 4,
      align: TextAlign.center,
    );
  }
}

class TitlePayOut extends StatelessWidget {
  const TitlePayOut({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const int textDark = 0xffA2E6FA;
    return const TextPoppins(
      text: "¡Tu pago está en proceso!",
      fontSize: 20,
      fontWeight: FontWeight.w600,
      lines: 2,
      textDark: textDark,
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

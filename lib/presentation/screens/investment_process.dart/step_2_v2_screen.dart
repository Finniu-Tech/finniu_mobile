import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widgets/step_scaffolf.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/expansion_title_profile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StepTwoV2 extends StatelessWidget {
  const StepTwoV2({super.key});

  @override
  Widget build(BuildContext context) {
    return const StepScaffold(
      children: StepTwoBody(),
    );
  }
}

class StepTwoBody extends StatelessWidget {
  const StepTwoBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const int titleDark = 0xffA2E6FA;
    const int titleLight = 0xff0D3A5C;
    const int textDark = 0xffFFFFFF;
    const int textLight = 0xff0D3A5C;
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FundRowStep(),
            const SizedBox(
              height: 15,
            ),
            const TextPoppins(
              text: "Fondo prestamos\nempresariales",
              fontSize: 20,
              fontWeight: FontWeight.w600,
              lines: 2,
              align: TextAlign.start,
              textDark: titleDark,
              textLight: titleLight,
            ),
            const SizedBox(
              height: 15,
            ),
            const TextPoppins(
              text: "Agrega tus cuentas",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              align: TextAlign.start,
              textDark: textDark,
              textLight: textLight,
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 38,
              decoration: BoxDecoration(
                color: const Color(0xffBCF0FF),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 38,
              decoration: BoxDecoration(
                color: const Color(0xffBCF0FF),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const TextPoppins(
              text:
                  "Realiza tu transferencia de S/5,000 a la cuenta bancaria de Finniu:",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              lines: 2,
              align: TextAlign.start,
              textDark: textDark,
              textLight: textLight,
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 140,
              decoration: const BoxDecoration(
                color: Color(0xffFFEEDD),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const TextPoppins(
              text: "Adjunta tu constancia de transferencia:",
              fontSize: 14,
              align: TextAlign.start,
              textDark: textDark,
              textLight: textLight,
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 93,
              decoration: const BoxDecoration(
                color: Color(0xffB6EFFF),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CheckBoxWidget(
                  value: true,
                  onChanged: (value) {},
                ),
                const TextPoppins(
                  text: 'He leído y acepto el Contrato de Inversión de Finniu',
                  fontSize: 12,
                  lines: 2,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            ButtonInvestment(
              text: "Enviar constancia",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class FundRowStep extends ConsumerWidget {
  const FundRowStep({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int containerDark = 0xff0D3A5C;
    const int containerLight = 0xffA2E6FA;
    const int iconDark = 0xff08273F;
    const int iconLight = 0xffB4EEFF;
    const int dividerDark = 0xff00518E;
    const int dividerLight = 0xff0D3A5C;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              width: 150,
              height: 30,
              padding: const EdgeInsets.only(right: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isDarkMode
                    ? const Color(containerDark)
                    : const Color(containerLight),
              ),
              child: const Row(
                children: [
                  SizedBox(
                    width: 60,
                  ),
                  TextPoppins(
                    text: "Invierte",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    lines: 1,
                    align: TextAlign.center,
                  ),
                ],
              ),
            ),
            Positioned(
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? const Color(iconDark)
                      : const Color(iconLight),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Center(
                  child: TextPoppins(
                    text: "🏢",
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // child: Image.asset(
                //   urlIcon,
                // ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Container(
            height: 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isDarkMode
                  ? const Color(dividerDark)
                  : const Color(dividerLight),
            ),
          ),
        ),
      ],
    );
  }
}

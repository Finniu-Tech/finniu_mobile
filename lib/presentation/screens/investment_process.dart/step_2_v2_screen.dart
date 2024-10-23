import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widget_v2/add_image_step.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widget_v2/bank_tranfer_container.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widget_v2/finniu_account.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widget_v2/fund_row_step.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widget_v2/term_condittions_step.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widgets/step_scaffolf.dart';
import 'package:flutter/material.dart';

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
        height: MediaQuery.of(context).size.height - 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const FundRowStep(),
            const TextPoppins(
              text: "Fondo prestamos\nempresariales",
              fontSize: 20,
              fontWeight: FontWeight.w600,
              lines: 2,
              align: TextAlign.start,
              textDark: titleDark,
              textLight: titleLight,
            ),
            const TextPoppins(
              text: "Agrega tus cuentas",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              align: TextAlign.start,
              textDark: textDark,
              textLight: textLight,
            ),
            const BankTranferContainer(
              title: "Desde que banco nos transfieres",
            ),
            const BankTranferContainer(
              title: "A que banco te depositamos",
            ),
            const TextRickStep(),
            const FinniuAccount(),
            const TextPoppins(
              text: "Adjunta tu constancia de transferencia:",
              fontSize: 14,
              align: TextAlign.start,
              textDark: textDark,
              textLight: textLight,
            ),
            const ImageStep(),
            const TermConditionsStep(),
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

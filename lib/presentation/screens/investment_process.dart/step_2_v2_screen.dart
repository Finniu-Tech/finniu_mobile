import 'package:finniu/constants/colors/product_v4_colors.dart';
import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/providers/pre_investment_provider.dart';
import 'package:finniu/presentation/providers/re_investment_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/investment_process.dart/helpers/push_step_data.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widget_v2/add_image_step.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widget_v2/bank_tranfer_container.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widget_v2/finniu_account.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widget_v2/fund_row_step.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widget_v2/term_condittions_step.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widgets/step_scaffolf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

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
    final colors = ProductContainerStyles(
      backgroundContainerDark: 0xff1B1B1B,
      backgroundContainerLight: 0xffE9FAFF,
      imageProduct: "🏢",
      titleText: "Producto de inversión a Plazo Fijo",
      minimumText: "1.000",
      profitabilityText: "19",
      titleDark: 0xffFFFFFF,
      titleLight: 0xff0D3A5C,
      minimumDark: 0xff0D3A5C,
      minimumLight: 0xff0D3A5C,
      profitabilityDark: 0xffB5FF8A,
      profitabilityLight: 0xffD2FDBA,
      isSoles: true,
      uuid: "1",
      buttonBackDark: 0xffA2E6FA,
      buttonBackLight: 0xff0D3A5C,
      buttonTextDark: 0xff0D3A5C,
      buttonTextLight: 0xffFFFFFF,
      textDark: 0xff000000,
      textLight: 0xff000000,
      minimunTextColorDark: 0xffFFFFFF,
      minimumTextColorLight: 0xffFFFFFF,
      minimumLightSoles: 0xffBBF0FF,
      minimumTextColorLightSoles: 0xff000000,
    );
    const int titleDark = 0xffA2E6FA;
    const int titleLight = 0xff0D3A5C;
    const int textDark = 0xffFFFFFF;
    const int textLight = 0xff0D3A5C;
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height < 700
            ? 650
            : MediaQuery.of(context).size.height - 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FundRowStep(
              icon: colors.imageProduct,
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
            const TextPoppins(
              text: "Agrega tus cuentas",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              align: TextAlign.start,
              textDark: textDark,
              textLight: textLight,
            ),
            BankTranferContainer(
              title: "Desde que banco nos transfieres",
              providerWatch: selectedBankAccountSenderProvider,
              isSended: true,
            ),
            BankTranferContainer(
              title: "A que banco te depositamos",
              providerWatch: selectedBankAccountReceiverProvider,
              isSended: false,
            ),
            const TextRickStep(),
            const FinniuAccountProvider(),
            const TextPoppins(
              text: "Adjunta tu constancia de transferencia:",
              fontSize: 14,
              align: TextAlign.start,
              textDark: textDark,
              textLight: textLight,
            ),
            const ImageStep(),
            const ColumnPush(),
          ],
        ),
      ),
    );
  }
}

class ColumnPush extends HookConsumerWidget {
  const ColumnPush({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conditions = useState(false);
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    void pushData() {
      final voucherImageBase64 = ref.read(preInvestmentVoucherImagesProvider);
      final bankSender = ref.read(selectedBankAccountSenderProvider);
      final bankReceiver = ref.read(selectedBankAccountReceiverProvider);
      if (voucherImageBase64.isEmpty) {
        ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
          eventName: FirebaseAnalyticsEvents.pushDataError,
          parameters: {
            "screen": FirebaseScreen.investmentStep2V2,
            "event": "error_voucher",
          },
        );
        showSnackBarV2(
          context: context,
          title: "La constancia es requerida",
          message: 'Debe subir una imagen de la constancia de transferencia',
          snackType: SnackType.warning,
        );
        return;
      }
      if (conditions.value == false) {
        ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
          eventName: FirebaseAnalyticsEvents.pushDataError,
          parameters: {
            "screen": FirebaseScreen.investmentStep2V2,
            "event": "error_conditions",
          },
        );
        showSnackBarV2(
          context: context,
          title: "Debe aceptar y leer el contrato",
          message: 'Debe aceptar y leer el contrato',
          snackType: SnackType.warning,
        );
        return;
      }
      if (bankSender == null) {
        ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
          eventName: FirebaseAnalyticsEvents.pushDataError,
          parameters: {
            "screen": FirebaseScreen.investmentStep2V2,
            "event": "error_bank_sender",
          },
        );
        showSnackBarV2(
          context: context,
          title: "Seleccionar banco de origen",
          message: 'Por favor seleccione una cuenta para enviar',
          snackType: SnackType.warning,
        );
        return;
      }
      if (bankReceiver == null) {
        ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
          eventName: FirebaseAnalyticsEvents.pushDataError,
          parameters: {
            "screen": FirebaseScreen.investmentStep2V2,
            "event": "error_bank_receiver",
          },
        );
        showSnackBarV2(
          context: context,
          title: "Seleccionar banco de destino",
          message: 'Por favor seleccione una cuenta para recibir',
          snackType: SnackType.warning,
        );
        return;
      }
      context.loaderOverlay.show();
      FocusManager.instance.primaryFocus?.unfocus();
      stepTwoPushData(
        context,
        ref,
        PushStepData(
          preInvestmentUUID: args['preInvestmentUUID'],
          bankAccountSendedId: bankSender.id,
          bankAccountReceiverId: bankReceiver.id,
          readContract: conditions.value,
          base64Image: voucherImageBase64,
          isReInvestment: args['isReInvestment'] ?? false,
        ),
      );
      ref.read(preInvestmentVoucherImagesProvider.notifier).state = [];
      ref.read(preInvestmentVoucherImagesPreviewProvider.notifier).state = [];
      // Navigator.pushNamedAndRemoveUntil(
      //           context, '/home_v2', (route) => false);
    }

    return Column(
      children: [
        TermConditionsStep(
          conditions: conditions,
        ),
        ButtonInvestment(
          text: "Enviar constancia",
          onPressed: () => pushData(),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

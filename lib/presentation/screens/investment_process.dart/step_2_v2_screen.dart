import 'package:finniu/constants/colors/product_v4_colors.dart';
import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/providers/nabbar_provider.dart';
import 'package:finniu/presentation/providers/pre_investment_provider.dart';
import 'package:finniu/presentation/providers/re_investment_provider.dart';
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

class StepTwoV2 extends HookConsumerWidget {
  const StepTwoV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> pushData() async {
      final voucherImageBase64 = ref.read(preInvestmentVoucherImagesProvider);
      final bankSender = ref.read(selectedBankAccountSenderProvider);
      final bankReceiver = ref.read(selectedBankAccountReceiverProvider);
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      final conditions = ref.watch(userAcceptedTermsProvider);

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
      if (conditions == false) {
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

      final success = await stepTwoPushData(
        context,
        ref,
        PushStepData(
          preInvestmentUUID: args['preInvestmentUUID'],
          bankAccountSendedId: bankSender.id,
          bankAccountReceiverId: bankReceiver.id,
          readContract: conditions,
          base64Image: voucherImageBase64,
          isReInvestment: args['isReinvestment'] ?? false,
        ),
      );

      context.loaderOverlay.hide();

      if (success) {
        ref.read(userAcceptedTermsProvider.notifier).state = false;
        ref.read(preInvestmentVoucherImagesProvider.notifier).state = [];
        ref.read(preInvestmentVoucherImagesPreviewProvider.notifier).state = [];
      }
    }

    return Step2Scaffold(
      useDefaultLoading: false,
      onPressedButton: pushData,
      children: const StepTwoBody(),
    );
  }
}

class StepTwoBody extends StatelessWidget {
  const StepTwoBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final product = args['productData'] as ProductData;

    const int titleDark = 0xffA2E6FA;
    const int titleLight = 0xff0D3A5C;
    const int textDark = 0xffFFFFFF;
    const int textLight = 0xff0D3A5C;
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FundRowStep(
              icon: product.imageProduct,
            ),
            const SizedBox(height: 15),
            TextPoppins(
              text: product.titleText,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              lines: 2,
              align: TextAlign.start,
              textDark: titleDark,
              textLight: titleLight,
            ),
            const SizedBox(height: 15),
            const TextPoppins(
              text: "Agrega tus cuentas",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              align: TextAlign.start,
              textDark: textDark,
              textLight: textLight,
            ),
            const SizedBox(height: 15),
            BankTranferContainer(
              title: "Desde qué banco nos transfieres ",
              providerWatch: selectedBankAccountSenderProvider,
              isSended: true,
            ),
            const SizedBox(height: 15),
            BankTranferContainer(
              title: "A qué banco te depositamos",
              providerWatch: selectedBankAccountReceiverProvider,
              isSended: false,
            ),
            const SizedBox(height: 15),
            const TextRickStep(),
            const SizedBox(height: 15),
            const FinniuAccountProvider(),
            const SizedBox(height: 15),
            const TextPoppins(
              text: "Adjunta tu constancia de transferencia:",
              fontSize: 14,
              align: TextAlign.start,
              textDark: textDark,
              textLight: textLight,
            ),
            const SizedBox(height: 15),
            const ImageStep(),
            const SizedBox(height: 15),
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
    // final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // Future<void> pushData() async {
    //   final voucherImageBase64 = ref.read(preInvestmentVoucherImagesProvider);
    //   final bankSender = ref.read(selectedBankAccountSenderProvider);
    //   final bankReceiver = ref.read(selectedBankAccountReceiverProvider);
    //   if (voucherImageBase64.isEmpty) {
    //     ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
    //       eventName: FirebaseAnalyticsEvents.pushDataError,
    //       parameters: {
    //         "screen": FirebaseScreen.investmentStep2V2,
    //         "event": "error_voucher",
    //       },
    //     );
    //     showSnackBarV2(
    //       context: context,
    //       title: "La constancia es requerida",
    //       message: 'Debe subir una imagen de la constancia de transferencia',
    //       snackType: SnackType.warning,
    //     );
    //     return;
    //   }
    //   if (conditions.value == false) {
    //     ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
    //       eventName: FirebaseAnalyticsEvents.pushDataError,
    //       parameters: {
    //         "screen": FirebaseScreen.investmentStep2V2,
    //         "event": "error_conditions",
    //       },
    //     );
    //     showSnackBarV2(
    //       context: context,
    //       title: "Debe aceptar y leer el contrato",
    //       message: 'Debe aceptar y leer el contrato',
    //       snackType: SnackType.warning,
    //     );
    //     return;
    //   }
    //   if (bankSender == null) {
    //     ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
    //       eventName: FirebaseAnalyticsEvents.pushDataError,
    //       parameters: {
    //         "screen": FirebaseScreen.investmentStep2V2,
    //         "event": "error_bank_sender",
    //       },
    //     );
    //     showSnackBarV2(
    //       context: context,
    //       title: "Seleccionar banco de origen",
    //       message: 'Por favor seleccione una cuenta para enviar',
    //       snackType: SnackType.warning,
    //     );
    //     return;
    //   }
    //   if (bankReceiver == null) {
    //     ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
    //       eventName: FirebaseAnalyticsEvents.pushDataError,
    //       parameters: {
    //         "screen": FirebaseScreen.investmentStep2V2,
    //         "event": "error_bank_receiver",
    //       },
    //     );
    //     showSnackBarV2(
    //       context: context,
    //       title: "Seleccionar banco de destino",
    //       message: 'Por favor seleccione una cuenta para recibir',
    //       snackType: SnackType.warning,
    //     );
    //     return;
    //   }
    //   context.loaderOverlay.show();
    //   FocusManager.instance.primaryFocus?.unfocus();
    //   final success = await stepTwoPushData(
    //     context,
    //     ref,
    //     PushStepData(
    //       preInvestmentUUID: args['preInvestmentUUID'],
    //       bankAccountSendedId: bankSender.id,
    //       bankAccountReceiverId: bankReceiver.id,
    //       readContract: conditions.value,
    //       base64Image: voucherImageBase64,
    //       isReInvestment: args['isReinvestment'] ?? false,
    //     ),
    //   );

    //   context.loaderOverlay.hide();

    //   if (success) {
    //     ref.read(preInvestmentVoucherImagesProvider.notifier).state = [];
    //     ref.read(preInvestmentVoucherImagesPreviewProvider.notifier).state = [];
    //   }
    // }

    // useEffect(
    //   () {
    //     Future.microtask(() {
    //       ref.read(nabbarProvider.notifier).updateNabbar(
    //             NabbarProvider(title: "Enviar constancia", onTap: pushData),
    //           );
    //     });

    //     return null;
    //   },
    //   [],
    // );

    return Column(
      children: [
        TermConditionsStep(),
        const SizedBox(height: 15),
      ],
    );
  }
}

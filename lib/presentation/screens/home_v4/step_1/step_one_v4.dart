import 'package:finniu/constants/colors.dart';
import 'package:finniu/constants/colors/product_v4_colors.dart';
import 'package:finniu/constants/number_format.dart';
import 'package:finniu/domain/entities/calculate_investment.dart';
import 'package:finniu/infrastructure/models/calculate_investment.dart';
import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/infrastructure/models/fund/corporate_investment_models.dart';
import 'package:finniu/infrastructure/models/pre_investment_form.dart';
import 'package:finniu/infrastructure/models/re_investment/input_models.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/investment_simulation.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/helpers/validate_form.dart';
import 'package:finniu/presentation/screens/home_v4/step_1/helpers/coupon_push.dart';
import 'package:finniu/presentation/screens/home_v4/step_1/helpers/navigate_to_next.dart';
import 'package:finniu/presentation/screens/home_v4/step_1/helpers/push_cupon.dart';
import 'package:finniu/presentation/screens/home_v4/step_1/helpers/save_pre_invest.dart';
import 'package:finniu/presentation/screens/home_v4/step_1/widgets/input_invest_v4.dart';
import 'package:finniu/presentation/screens/home_v4/step_1/widgets/select_invest_v4.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widget_v2/fund_row_step.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widgets/step_scaffolf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class StepOneV4 extends StatelessWidget {
  const StepOneV4({super.key});

  @override
  Widget build(BuildContext context) {
    return const StepScaffold(
      useDefaultLoading: true,
      children: StepOneBody(),
    );
  }
}

class StepOneBody extends StatelessWidget {
  const StepOneBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ProductContainerStyles;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    const String fundUUID = "cbeff767-93f6-493f-9a55-faf5c380b0f9";
    const int titleDark = 0xffA2E6FA;
    const int titleLight = 0xff0D3A5C;
    const int textDark = 0xffFFFFFF;
    const int textLight = 0xff0D3A5C;

    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height < 700
            ? 650
            : MediaQuery.of(context).size.height - 80,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FundRowStep(
              icon: args.imageProduct,
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextPoppins(
                text: args.titleText,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                lines: 2,
                align: TextAlign.start,
                textDark: titleDark,
                textLight: titleLight,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const TextPoppins(
              text: "Completa los siguientes datos",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              align: TextAlign.start,
              textDark: textDark,
              textLight: textLight,
            ),
            FormStepOne(
              formKey: formKey,
              fundUuid: fundUUID,
            ),
          ],
        ),
      ),
    );
  }
}

class FormStepOne extends HookConsumerWidget {
  const FormStepOne({
    super.key,
    required this.formKey,
    required this.fundUuid,
  });
  final GlobalKey<FormState> formKey;
  final String fundUuid;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSoles = ref.watch(isSolesStateProvider);

    final timeController = useTextEditingController();
    final originController = useTextEditingController();
    final originOtherController = useTextEditingController();
    final amountController = useTextEditingController();
    final couponController = useTextEditingController();
    final ValueNotifier<bool> timeError = useState(false);
    final ValueNotifier<bool> originError = useState(false);
    final ValueNotifier<bool> amountError = useState(false);
    final ValueNotifier<bool> couponError = useState(false);
    final ValueNotifier<bool> originOtherError = useState(false);
    final planSimulation = useState<PlanSimulation?>(null);

    const List<String> optionsTime = ["6 meses", "12 meses", "24 meses"];
    const List<String> optionsOrigin = [
      "Salario",
      "Ahorros",
      'Venta Bienes',
      'Inversiones',
      'Herencia',
      'Préstamos',
      'Otros',
    ];

    const buttonBack = 0xffA2E6FA;
    const buttonText = 0xff0D3A5C;
    const buttonBorder = 0xff0D3A5C;

    void onPressCupon() async {
      FocusManager.instance.primaryFocus?.unfocus();
      if (!formKey.currentState!.validate()) {
        ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
          eventName: FirebaseAnalyticsEvents.formValidateError,
          parameters: {
            "screen": FirebaseScreen.formPersonalDataV2,
            "error": "input_form",
          },
        );
        showSnackBarV2(
          context: context,
          title: "Datos obligatorios incompletos",
          message: "Por favor, completa todos los campos.",
          snackType: SnackType.warning,
        );

        return;
      } else {
        if (amountError.value) return;
        if (timeError.value) return;
        if (couponError.value) return;
        context.loaderOverlay.show();
        final inputCalculator = CalculatorInput(
          amount: int.parse(amountController.text),
          months: int.parse(
            timeController.text.split(' ')[0],
          ),
          currency: isSoles ? currencyNuevoSol : currencyDollar,
          coupon: couponController.text,
        );
        planSimulation.value = await pushCupon(
          inputCalculator: inputCalculator,
          context: context,
          ref: ref,
        );
        couponFinish(
          context: context,
          plan: planSimulation.value,
          ref: ref,
          coupon: couponController.text,
          couponController: couponController,
        );
      }

      context.loaderOverlay.hide();
    }

    void onPressSimulator() {
      if (!formKey.currentState!.validate()) {
        ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
          eventName: FirebaseAnalyticsEvents.formValidateError,
          parameters: {
            "screen": FirebaseScreen.formPersonalDataV2,
            "error": "input_form",
          },
        );
        showSnackBarV2(
          context: context,
          title: "Datos obligatorios incompletos",
          message: "Por favor, completa todos los campos.",
          snackType: SnackType.warning,
        );
        return;
      } else {
        if (amountError.value) return;
        if (timeError.value) return;
        if (couponError.value) return;
        if (originError.value) return;
        if (originOtherError.value) return;

        investmentSimulationModal(
          context,
          startingAmount: int.parse(amountController.text),
          finalAmount: int.parse(amountController.text),
          mouthInvestment: int.parse(timeController.text.split(' ')[0]),
          coupon: couponController.text,
          toInvestPressed: () async {
            context.loaderOverlay.show();
            Navigator.pop(context);
            final response = await savePreInvestment(
              context,
              ref,
              SaveCorporateInvestmentInput(
                amount: amountController.text,
                months: timeController.text.split(' ')[0],
                coupon: couponController.text,
                currency: isSoles ? currencyNuevoSol : currencyDollar,
                originFunds: OriginFunds(
                  originFundsEnum: OriginFoundsUtil.fromReadableName(
                    originController.text,
                  ),
                  otherText: originOtherController.text,
                ),
                fundUUID: fundUuid,
              ),
            );
            context.loaderOverlay.hide();
            navigateToNext(
              success: response.success,
              ref: ref,
              context: context,
              uuid: response.preInvestmentUUID ?? '',
              amount: amountController.text,
            );
          },
          recalculatePressed: () => {
            Navigator.pop(context),
          },
        );
      }
    }

    return Form(
      autovalidateMode: AutovalidateMode.disabled,
      key: formKey,
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 250,
        child: Column(
          children: [
            const SizedBox(height: 25),
            ValueListenableBuilder<bool>(
              valueListenable: amountError,
              builder: (context, isError, child) {
                return InputTextFileInvest(
                  title: "  Monto  ",
                  isNumeric: true,
                  controller: amountController,
                  isError: isError,
                  onError: () => amountError.value = false,
                  hintText: "Ingrese su monto de inversión",
                  validator: (value) {
                    validateNumberMin(
                      value: value,
                      field: "Monto",
                      context: context,
                      boolNotifier: amountError,
                      minValue: 1000,
                    );

                    return null;
                  },
                );
              },
            ),
            const SizedBox(height: 25),
            ValueListenableBuilder<bool>(
              valueListenable: timeError,
              builder: (context, isError, child) {
                return SelecDropdownInvest(
                  isError: isError,
                  onError: () => timeError.value = false,
                  itemSelectedValue: timeController.text,
                  title: "  Plazo  ",
                  hintText: "Seleccione su plazo de inversión",
                  selectController: timeController,
                  options: optionsTime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      showSnackBarV2(
                        context: context,
                        title: "Plazo obligatorio",
                        message: "Por favor, completa el Plazo.",
                        snackType: SnackType.warning,
                      );
                      timeError.value = true;
                      return null;
                    }
                    return null;
                  },
                );
              },
            ),
            const SizedBox(height: 25),
            ValueListenableBuilder<bool>(
              valueListenable: originError,
              builder: (context, isError, child) {
                return SelecDropdownInvest(
                  isError: isError,
                  onError: () => originError.value = false,
                  itemSelectedValue: originController.text,
                  title: "  Origen de procedencia  ",
                  hintText: "Seleccione origen",
                  selectController: originController,
                  options: optionsOrigin,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      showSnackBarV2(
                        context: context,
                        title: "Origen obligatorio",
                        message: "Por favor, completa el Origen.",
                        snackType: SnackType.warning,
                      );
                      originError.value = true;
                      return null;
                    }
                    return null;
                  },
                );
              },
            ),
            originController.text == "Otros"
                ? const SizedBox(height: 25)
                : const SizedBox(),
            originController.text == "Otros"
                ? ValueListenableBuilder<bool>(
                    valueListenable: originOtherError,
                    builder: (context, isError, child) {
                      return InputTextFileInvest(
                        title: " Otro origen  ",
                        controller: originOtherController,
                        isError: isError,
                        onError: () => originOtherError.value = false,
                        hintText: "Ingrese su origen",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            showSnackBarV2(
                              context: context,
                              title: "Origen obligatorio",
                              message: "Por favor, completa el Origen.",
                              snackType: SnackType.warning,
                            );
                            originError.value = true;
                            return null;
                          }
                          return null;
                        },
                      );
                    },
                  )
                : const SizedBox(),
            const SizedBox(height: 25),
            Stack(
              children: [
                ValueListenableBuilder<bool>(
                  valueListenable: couponError,
                  builder: (context, isError, child) {
                    return InputTextFileInvest(
                      title: "  Si es que tienes un cupón  ",
                      isNumeric: true,
                      controller: couponController,
                      isError: isError,
                      onError: () => couponError.value = false,
                      hintText: "Ingresa tu cupón",
                      validator: (p0) {
                        return null;
                      },
                    );
                  },
                ),
                Positioned(
                  right: 0,
                  child: GestureDetector(
                    onTap: onPressCupon,
                    child: Center(
                      child: Container(
                        width: 100,
                        height: 48,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(buttonBorder),
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                          color: const Color(buttonBack),
                        ),
                        child: const TextPoppins(
                          text: "Aplicarlo",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          textDark: buttonText,
                          textLight: buttonText,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            if (planSimulation.value != null)
              CuponApliyRow(
                planSimulation: planSimulation,
                isSoles: isSoles,
              )
            else
              const SizedBox(),
            ButtonInvestment(
              text: "Simular",
              onPressed: onPressSimulator,
            ),
          ],
        ),
      ),
    );
  }
}

class CuponApliyRow extends StatelessWidget {
  const CuponApliyRow({
    super.key,
    required this.planSimulation,
    required this.isSoles,
  });

  final ValueNotifier<PlanSimulation?> planSimulation;
  final bool isSoles;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(primaryLight),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 0,
                  blurRadius: 2,
                  offset: const Offset(
                    0,
                    3,
                  ),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextPoppins(
                  text:
                      '${planSimulation.value?.finalRentability?.toString() ?? 0}% ',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  textDark: primaryDark,
                  textLight: primaryDark,
                ),
                const TextPoppins(
                  text: '% de retorno',
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  textDark: primaryDark,
                  textLight: primaryDark,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(secondary),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 0,
                  blurRadius: 2,
                  offset: const Offset(
                    0,
                    3,
                  ),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextPoppins(
                  text: isSoles
                      ? formatterSoles
                          .format(planSimulation.value?.profitability)
                      : formatterUSD
                          .format(planSimulation.value?.profitability),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  textDark: primaryDark,
                  textLight: primaryDark,
                ),
                TextPoppins(
                  text: 'En ${planSimulation.value?.months} meses tendrías',
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  textDark: primaryDark,
                  textLight: primaryDark,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
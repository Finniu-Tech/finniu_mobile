import 'package:finniu/domain/entities/calculate_investment.dart';
import 'package:finniu/infrastructure/models/calculate_investment.dart';
import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/infrastructure/models/fund/corporate_investment_models.dart';
import 'package:finniu/infrastructure/models/pre_investment_form.dart';
import 'package:finniu/infrastructure/models/re_investment/input_models.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/investment_simulation.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/form_personal_data_v2/helpers/validate_form.dart';
import 'package:finniu/presentation/screens/home_v4/step_1/helpers/coupon_push.dart';
import 'package:finniu/presentation/screens/home_v4/step_1/helpers/navigate_to_next.dart';
import 'package:finniu/presentation/screens/home_v4/step_1/helpers/push_cupon.dart';
import 'package:finniu/presentation/screens/home_v4/step_1/helpers/save_pre_invest.dart';
import 'package:finniu/presentation/screens/home_v4/step_1/step_one_v4.dart';
import 'package:finniu/presentation/screens/home_v4/step_1/widgets/input_invest_v4.dart';
import 'package:finniu/presentation/screens/home_v4/step_1/widgets/select_invest_v4.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class FormStepOneV2 extends ConsumerStatefulWidget {
  const FormStepOneV2({
    super.key,
    required this.formKey,
    required this.fundUuid,
  });

  final GlobalKey<FormState> formKey;
  final String fundUuid;

  @override
  FormStepOneState createState() => FormStepOneState();
}

class FormStepOneState extends ConsumerState<FormStepOneV2> {
  late TextEditingController timeController;
  late TextEditingController originController;
  late TextEditingController originOtherController;
  late TextEditingController amountController;
  late TextEditingController couponController;

  late bool isSoles;
  late bool isDarkMode;
  ValueNotifier<bool> timeError = ValueNotifier(false);
  ValueNotifier<bool> originError = ValueNotifier(false);
  ValueNotifier<bool> amountError = ValueNotifier(false);
  ValueNotifier<bool> couponError = ValueNotifier(false);
  ValueNotifier<bool> originOtherError = ValueNotifier(false);
  ValueNotifier<PlanSimulation?> planSimulation = ValueNotifier(null);

  static const List<String> optionsTime = ["6 meses", "12 meses", "24 meses"];
  static const List<String> optionsOrigin = [
    "Salario",
    "Ahorros",
    'Venta Bienes',
    'Inversiones',
    'Herencia',
    'Préstamos',
    'Otros',
  ];

  static const buttonBack = 0xffA2E6FA;
  static const buttonText = 0xff0D3A5C;
  static const buttonBorder = 0xff0D3A5C;

  @override
  void initState() {
    super.initState();

    isSoles = ref.read(isSolesStateProvider);
    isDarkMode = ref.read(settingsNotifierProvider).isDarkMode;
    timeController = TextEditingController();
    originController = TextEditingController();
    originOtherController = TextEditingController();
    amountController = TextEditingController();
    couponController = TextEditingController();
  }

  @override
  void dispose() {
    timeController.dispose();
    originController.dispose();
    originOtherController.dispose();
    amountController.dispose();
    couponController.dispose();
    timeError.dispose();
    originError.dispose();
    amountError.dispose();
    couponError.dispose();
    originOtherError.dispose();
    planSimulation.dispose();
    super.dispose();
  }

  void onPressCupon() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!widget.formKey.currentState!.validate()) {
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
    }

    if (amountError.value || timeError.value || couponError.value) return;

    context.loaderOverlay.show();
    final inputCalculator = CalculatorInput(
      amount: int.parse(amountController.text),
      months: int.parse(timeController.text.split(' ')[0]),
      currency: isSoles ? currencyNuevoSol : currencyDollar,
      coupon: couponController.text,
      fundUuid: widget.fundUuid,
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
    context.loaderOverlay.hide();
  }

  void onPressSimulator() {
    if (!widget.formKey.currentState!.validate()) {
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
    }

    if (amountError.value ||
        timeError.value ||
        couponError.value ||
        originError.value ||
        originOtherError.value) {
      return;
    }

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
            fundUUID: widget.fundUuid,
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
      recalculatePressed: () => Navigator.pop(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.disabled,
      key: widget.formKey,
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 250,
        child: Stack(
          children: [
            Column(
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
                      isDarkMode: isDarkMode,
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
                      isDarkMode: isDarkMode,
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
                  CouponApplyRow(
                    planSimulation: planSimulation,
                    isSoles: isSoles,
                  )
                else
                  const SizedBox(),
              ],
            ),
            Positioned(
              bottom: 10,
              child: ButtonInvestment(
                text: "Simular",
                onPressed: onPressSimulator,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

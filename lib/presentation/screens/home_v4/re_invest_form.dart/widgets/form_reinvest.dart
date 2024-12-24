import 'package:finniu/constants/colors/product_v4_colors.dart';
import 'package:finniu/domain/entities/calculate_investment.dart';
import 'package:finniu/domain/entities/re_invest_dto.dart';
import 'package:finniu/infrastructure/models/calculate_investment.dart';
import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/infrastructure/models/fund/corporate_investment_models.dart';
import 'package:finniu/infrastructure/models/pre_investment_form.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class FormStepOneReinvest extends HookConsumerWidget {
  final ProductContainerStyles product;
  final ReInvestDtoV4 data;
  final bool isDarkMode;
  final bool isSoles;
  final bool addAmount;
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  const FormStepOneReinvest({
    super.key,
    required this.product,
    required this.data,
    required this.isDarkMode,
    required this.isSoles,
    required this.addAmount,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeController = useTextEditingController();
    final amountAddController = useTextEditingController();
    final couponController = useTextEditingController();
    final ValueNotifier<bool> timeError = useState(false);
    final ValueNotifier<bool> originError = useState(false);
    final ValueNotifier<bool> amountError = useState(false);
    final ValueNotifier<bool> couponError = useState(false);

    final planSimulation = useState<PlanSimulation?>(null);

    final List<String> optionsTime =
        product.titleText == "Producto de inversión a Plazo Fijo"
            ? ["6 meses", "12 meses", "24 meses"]
            : ["12 meses", "24 meses", "36 meses"];

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
          amount: int.parse(amountAddController.text),
          months: int.parse(
            timeController.text.split(' ')[0],
          ),
          currency: isSoles ? currencyNuevoSol : currencyDollar,
          coupon: couponController.text,
          fundUuid: product.uuid,
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

        investmentSimulationModal(
          context,
          startingAmount: int.parse(amountAddController.text),
          finalAmount: int.parse(amountAddController.text),
          mouthInvestment: int.parse(timeController.text.split(' ')[0]),
          coupon: couponController.text,
          toInvestPressed: () async {
            context.loaderOverlay.show();
            Navigator.pop(context);
            final response = await savePreInvestment(
              context,
              ref,
              SaveCorporateInvestmentInput(
                amount: amountAddController.text,
                months: timeController.text.split(' ')[0],
                coupon: couponController.text,
                currency: isSoles ? currencyNuevoSol : currencyDollar,
                originFunds: data.originFunds,
                fundUUID: product.uuid,
              ),
            );
            context.loaderOverlay.hide();
            navigateToNext(
              success: response.success,
              ref: ref,
              context: context,
              uuid: response.preInvestmentUUID ?? '',
              amount: amountAddController.text,
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
        child: Column(
          children: [
            const SizedBox(height: 25),
            ValueListenableBuilder<bool>(
              valueListenable: amountError,
              builder: (context, isError, child) {
                return InputTextFileInvest(
                  isDisable: addAmount,
                  title: "  Monto adicional ",
                  isNumeric: true,
                  controller: amountAddController,
                  isError: isError,
                  onError: () => amountError.value = false,
                  hintText: "Ingrese su monto de inversión",
                  validator: (value) {
                    validateNumberMin(
                      isSoles: isSoles,
                      value: value,
                      field: "Monto",
                      context: context,
                      boolNotifier: amountError,
                      minValue: product.titleText ==
                              "Producto de inversión a Plazo Fijo"
                          ? 1000
                          : 50000,
                    );

                    return null;
                  },
                );
              },
            ),
            const SizedBox(height: 25),
            FinalAmountContainer(
              isDarkMode: isDarkMode,
              finalAmount: data.amount,
              isSoles: isSoles,
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
            Stack(
              children: [
                ValueListenableBuilder<bool>(
                  valueListenable: couponError,
                  builder: (context, isError, child) {
                    return InputTextFileInvest(
                      title: "  Si es que tienes un cupón  ",
                      isNumeric: false,
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
            ButtonInvestment(
              text: "Simular",
              onPressed: onPressSimulator,
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}

class FinalAmountContainer extends StatelessWidget {
  const FinalAmountContainer({
    super.key,
    required this.finalAmount,
    required this.isDarkMode,
    required this.isSoles,
  });
  final bool isSoles;
  final double finalAmount;
  final bool isDarkMode;
  @override
  Widget build(BuildContext context) {
    const int containerDark = 0xff0D3A5C;
    const int containerLight = 0xffC7F3FF;
    const int iconDark = 0xffA2E6FA;
    const int iconLight = 0xff0D3A5C;
    const int textDark = 0xffFFFFFF;
    const int textLight = 0xff0D3A5C;
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 60,
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(containerDark)
            : const Color(containerLight),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Icon(
                  Icons.monetization_on_outlined,
                  size: 14,
                  color: isDarkMode
                      ? const Color(iconDark)
                      : const Color(iconLight),
                ),
              ),
            ],
          ),
          const SizedBox(width: 5),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextPoppins(
                text: "Monto final",
                fontSize: 12,
                fontWeight: FontWeight.w600,
                textDark: textDark,
                textLight: textLight,
              ),
              TextPoppins(
                text: "(Capital de la operación en curso )",
                fontSize: 3,
                textDark: textDark,
                textLight: textLight,
              ),
            ],
          ),
          const Spacer(),
          TextPoppins(
            text: " ${isSoles ? "s/" : "\$"} ${finalAmount.toStringAsFixed(0)}",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            textDark: textDark,
            textLight: textLight,
          ),
        ],
      ),
    );
  }
}

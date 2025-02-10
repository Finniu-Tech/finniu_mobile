import 'dart:ffi';

import 'package:finniu/constants/colors/product_v4_colors.dart';
import 'package:finniu/domain/entities/calculate_investment.dart';
import 'package:finniu/domain/entities/dead_line.dart';
import 'package:finniu/domain/entities/re_invest_dto.dart';
import 'package:finniu/infrastructure/models/calculate_investment.dart';
import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/infrastructure/models/pre_investment_form.dart';
import 'package:finniu/infrastructure/models/re_investment/input_models.dart';
import 'package:finniu/presentation/providers/dead_line_provider.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/providers/nabbar_provider.dart';
import 'package:finniu/presentation/providers/re_investment_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/investment_simulation.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v4/re_invest_form.dart/widgets/final_amount_container.dart';
import 'package:finniu/presentation/screens/home_v4/step_1/helpers/coupon_push.dart';
import 'package:finniu/presentation/screens/home_v4/step_1/helpers/navigate_to_next.dart';
import 'package:finniu/presentation/screens/home_v4/step_1/helpers/push_cupon.dart';
import 'package:finniu/presentation/screens/home_v4/step_1/widgets/input_invest_v4.dart';
import 'package:finniu/presentation/screens/home_v4/step_1/widgets/select_invest_v4.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widget_v2/bank_tranfer_container.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widget_v2/term_condittions_step.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widgets/modals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class FormStepOneReinvest extends HookConsumerWidget {
  final ProductData product;
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

  int parseMoneyString(String? moneyString) {
    if (moneyString == null || moneyString.isEmpty) return 0;

    // Remover todos los caracteres no numéricos excepto punto y coma
    String cleanString = moneyString.replaceAll(RegExp(r'[^0-9.,]'), '');

    // Remover comas
    cleanString = cleanString.replaceAll(',', '');

    // Si hay punto decimal, tomar solo la parte entera
    if (cleanString.contains('.')) {
      cleanString = cleanString.split('.')[0];
    }

    // Convertir a entero
    return int.tryParse(cleanString) ?? 0;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const buttonBack = 0xffA2E6FA;
    const buttonText = 0xff0D3A5C;
    const buttonBorder = 0xff0D3A5C;
    final timeController = useTextEditingController();
    final amountAddController = useTextEditingController();
    final couponController = useTextEditingController();
    final originController = useTextEditingController();
    final originOtherController = useTextEditingController();
    final ValueNotifier<bool> timeError = useState(false);
    final ValueNotifier<bool> originError = useState(false);
    final ValueNotifier<bool> amountError = useState(false);
    final ValueNotifier<bool> couponError = useState(false);
    final ValueNotifier<bool> conditions = useState(false);
    final ValueNotifier<bool> originOtherError = useState(false);
    final ValueNotifier<double> finalAmount = useState(data.amount);
    final loader = useState(false);
    final planSimulation = useState<PlanSimulation?>(null);

    final List<String> optionsTime = product.slug == "fondo_inversiones_empresariales"
        ? ["6 meses", "12 meses", "24 meses"]
        : ["12 meses", "24 meses", "36 meses"];

    const List<String> optionsOrigin = [
      "Salario",
      "Ahorros",
      'Venta Bienes',
      'Inversiones',
      'Herencia',
      'Préstamos',
      'Otros',
    ];

    useEffect(
      () {
        loader.value ? context.loaderOverlay.show() : context.loaderOverlay.hide();

        return null;
      },
      [loader.value],
    );

    useEffect(
      () {
        void listener() {
          try {
            if (amountAddController.text.trim().isEmpty) {
              finalAmount.value = data.amount;
              return;
            }

            final double parsedAmount = double.parse(
              amountAddController.text.isEmpty ? "0" : amountAddController.text,
            );

            finalAmount.value = data.amount + parsedAmount;
          } catch (e) {
            showSnackBarV2(
              context: context,
              title: "Formato incorrecto",
              message: "Por favor, el monto debe ser un número válido.",
              snackType: SnackType.warning,
            );
          }
        }

        amountAddController.addListener(listener);
        return () => amountAddController.removeListener(listener);
      },
      [amountAddController],
    );

    void onPressCoupon() async {
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
        if (couponController.text.isEmpty) {
          showSnackBarV2(
            context: context,
            title: "Error al aplicar cupón",
            message: "Debes ingresar el cupón",
            snackType: SnackType.warning,
          );
          return;
        }
        final timeList = ref.watch(deadLineFutureProvider);
        final time = timeList.asData!.value.firstWhere((element) => element.name == timeController.text);
        context.loaderOverlay.show();
        final inputCalculator = CalculatorInput(
          amount: finalAmount.value.toInt(),
          months: time.value,
          currency: isSoles ? currencyNuevoSol : currencyDollar,
          coupon: couponController.text.trim(), //strip blank spaces
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
          coupon: couponController.text.trim(),
          couponController: couponController,
        );
      }

      context.loaderOverlay.hide();
    }

    void onPressSimulator() {
      FocusManager.instance.primaryFocus?.unfocus();
      final int minAmountToSimulate =
          isSoles ? parseMoneyString(product.minimumTextPEN) : parseMoneyString(product.minimumTextUSD);
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

        if (finalAmount.value.toInt() < minAmountToSimulate) {
          showSnackBarV2(
            context: context,
            title: "Monto insuficiente",
            message:
                "El monto mínimo para invertir es de ${isSoles ? product.minimumTextPEN : product.minimumTextUSD}",
            snackType: SnackType.warning,
          );
          return;
        }

        final timeList = ref.watch(deadLineFutureProvider);
        final time = timeList.asData!.value.firstWhere((element) => element.name == timeController.text);

        investmentSimulationModal(
          context,
          startingAmount: finalAmount.value.toInt(),
          finalAmount: finalAmount.value.toInt(),
          mouthInvestment: time.value,
          fundUUID: product.uuid,
          coupon: couponController.text,
          toInvestPressed: () async {
            Navigator.pop(context);
            loader.value = true;
            final input = CreateReInvestmentParams(
              preInvestmentUUID: data.uuid,
              finalAmount: finalAmount.value.toInt().toString(),
              currency: isSoles ? currencyNuevoSol : currencyDollar,
              deadlineUUID: time.uuid,
              originFounds: OriginFunds(
                originFundsEnum: OriginFoundsUtil.fromReadableName(
                  originController.text,
                ),
                otherText: originOtherController.text,
              ),
              coupon: couponController.text == "" ? null : couponController.text,
              typeReinvestment: "CAPITAL_ADITIONAL",
            );
            final response = await ref.read(createReInvestmentProvider(input).future);
            if (response.success == false || response.success == null) {
              ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
                eventName: FirebaseAnalyticsEvents.pushDataError,
                parameters: {
                  "screen": FirebaseScreen.investmentStep1V2,
                  "event": "save_re_investment_error",
                },
              );
              showSnackBarV2(
                context: context,
                title: "Error interno",
                message:
                    response.messages?[0].message ?? 'Hubo un problema, asegúrate de haber completado todos los campos',
                snackType: SnackType.error,
              );
              loader.value = false;
              return;
            }
            navigateToNext(
              success: response.success!,
              ref: ref,
              context: context,
              uuid: response.reInvestmentUuid!,
              amount: finalAmount.value.toStringAsFixed(2),
              productData: product,
              isReinvestment: true,
            );
            loader.value = false;
          },
          recalculatePressed: () => Navigator.pop(context),
        );
      }
    }

    void finalReinvest() async {
      if (!formKey.currentState!.validate()) {
        showSnackBarV2(
          context: context,
          title: "Datos obligatorios incompletos",
          message: "Por favor, completa todos los campos.",
          snackType: SnackType.warning,
        );
        return;
      }

      try {
        // Validaciones iniciales
        if (timeError.value || couponError.value) return;
        if (!conditions.value) {
          showSnackBarV2(
            context: context,
            title: "Datos obligatorios incompletos",
            message: "Por favor, acepta los términos y condiciones",
            snackType: SnackType.warning,
          );
          return;
        }

        // Validar monto mínimo
        final int minAmountToSimulate =
            isSoles ? parseMoneyString(product.minimumTextPEN) : parseMoneyString(product.minimumTextUSD);

        if (finalAmount.value.toInt() < minAmountToSimulate) {
          showSnackBarV2(
            context: context,
            title: "Monto insuficiente",
            message: "El monto mínimo para invertir es de ${isSoles ? product.minimumTextPEN : product.minimumTextUSD}",
            snackType: SnackType.warning,
          );
          return;
        }

        // Validar banco receptor
        final bankReceiver = ref.read(selectedBankAccountReceiverProvider);
        if (bankReceiver == null) {
          showSnackBarV2(
            context: context,
            title: "Datos obligatorios incompletos",
            message: "Por favor, selecciona un banco.",
            snackType: SnackType.warning,
          );
          return;
        }

        loader.value = true;

        // Obtener y validar deadline
        final timeList = await ref.watch(deadLineFutureProvider.future);
        if (timeList.isEmpty) {
          showSnackBarV2(
            context: context,
            title: "Error",
            message: "No se pudieron cargar los plazos disponibles",
            snackType: SnackType.error,
          );
          loader.value = false;
          return;
        }

        // Buscar el deadline por nombre
        final DeadLineEntity? time;
        try {
          time = timeList.asMap().values.firstWhere((element) => element.name == timeController.text);
        } catch (e) {
          showSnackBarV2(
            context: context,
            title: "Error",
            message: "Por favor, selecciona un plazo válido",
            snackType: SnackType.warning,
          );
          loader.value = false;
          return;
        }

        final deadLineUUID = await DeadLineEntity.getUuidByName(timeController.text, timeList);

        if (deadLineUUID == null) {
          showSnackBarV2(
            context: context,
            title: "Error",
            message: "No se pudo obtener el plazo seleccionado",
            snackType: SnackType.error,
          );
          loader.value = false;
          return;
        }

        // Mostrar modal de simulación
        investmentSimulationModal(
          context,
          startingAmount: finalAmount.value.toInt(),
          finalAmount: finalAmount.value.toInt(),
          mouthInvestment: time.value,
          coupon: couponController.text,
          buttonText: "Finalizar Reinversión",
          fundUUID: data.fundUUID!,
          toInvestPressed: () async {
            try {
              Navigator.pop(context);
              loader.value = true;

              final input = CreateReInvestmentParams(
                preInvestmentUUID: data.uuid,
                finalAmount: finalAmount.value.toInt().toString(),
                currency: isSoles ? currencyNuevoSol : currencyDollar,
                deadlineUUID: deadLineUUID,
                originFounds: data.originFunds,
                coupon: couponController.text,
                typeReinvestment: "CAPITAL_ONLY",
                bankAccountReceiver: bankReceiver.id,
              );

              final response = await ref.read(createReInvestmentProvider(input).future);

              if (!response.success!) {
                showSnackBarV2(
                  context: context,
                  title: "Error interno",
                  message: response.messages?[0].message ?? 'Error al procesar la reinversión',
                  snackType: SnackType.error,
                );
                return;
              }

              showThanksForInvestingModal(
                context,
                () => Navigator.pushReplacementNamed(context, '/v4/experience'),
                true,
              );
            } catch (e) {
              showSnackBarV2(
                context: context,
                title: "Error",
                message: "Ocurrió un error al procesar la reinversión",
                snackType: SnackType.error,
              );
            } finally {
              loader.value = false;
            }
          },
          recalculatePressed: () => Navigator.pop(context),
        );
      } catch (e) {
        showSnackBarV2(
          context: context,
          title: "Error",
          message: "Ocurrió un error inesperado",
          snackType: SnackType.error,
        );
      } finally {
        loader.value = false;
      }
    }

    useEffect(
      () {
        Future.microtask(() {
          ref.read(nabbarProvider.notifier).updateNabbar(
                NabbarProvider(
                  // title: addAmount ? "Simular" : "Finalizar mi proceso",
                  title: 'Simular',
                  onTap: addAmount ? onPressSimulator : finalReinvest,
                ),
              );
        });

        return null;
      },
      [],
    );

    return Form(
      autovalidateMode: AutovalidateMode.disabled,
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
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
                    if (!addAmount) return null;
                    // validateNumberMin(
                    //   isSoles: isSoles,
                    //   value: value,
                    //   field: "Monto",
                    //   context: context,
                    //   boolNotifier: amountError,
                    //   minValue: product.titleText ==
                    //           "Producto de inversión a Plazo Fijo"
                    //       ? 1000
                    //       : 50000,
                    // );

                    return null;
                  },
                );
              },
            ),
            const SizedBox(height: 15),
            FinalAmountContainer(
              isDarkMode: isDarkMode,
              finalAmount: finalAmount.value,
              isSoles: isSoles,
            ),
            const SizedBox(height: 15),
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
            // product.slug == "fondo_inversiones_empresariales"
            //     ? ValueListenableBuilder<bool>(
            //         valueListenable: timeError,
            //         builder: (context, isError, child) {
            //           return ProviderSelectableDropdownInvest(
            //             isError: isError,
            //             onError: () => timeError.value = false,
            //             itemSelectedValue: timeController.text,
            //             selectController: timeController,
            //             validator: (value) {
            //               if (value == null || value.isEmpty) {
            //                 showSnackBarV2(
            //                   context: context,
            //                   title: "Plazo obligatorio",
            //                   message: "Por favor, completa el Plazo.",
            //                   snackType: SnackType.warning,
            //                 );
            //                 timeError.value = true;
            //                 return null;
            //               }
            //               return null;
            //             },
            //           );
            //         },
            //       )
            //     : ValueListenableBuilder<bool>(
            //         valueListenable: timeError,
            //         builder: (context, isError, child) {
            //           return SelecDropdownInvest(
            //             isDarkMode: isDarkMode,
            //             isError: isError,
            //             onError: () => timeError.value = false,
            //             itemSelectedValue: timeController.text,
            //             title: "  Plazo  ",
            //             hintText: "Seleccione su plazo de inversión",
            //             selectController: timeController,
            //             options: optionsTime,
            //             validator: (value) {
            //               if (value == null || value.isEmpty) {
            //                 showSnackBarV2(
            //                   context: context,
            //                   title: "Plazo obligatorio",
            //                   message: "Por favor, completa el Plazo.",
            //                   snackType: SnackType.warning,
            //                 );
            //                 timeError.value = true;
            //                 return null;
            //               }
            //               return null;
            //             },
            //           );
            //         },
            //       ),
            addAmount ? const SizedBox(height: 15) : const SizedBox(),
            addAmount
                ? ValueListenableBuilder<bool>(
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
                  )
                : const SizedBox(),
            originController.text == "Otros" ? const SizedBox(height: 15) : const SizedBox(),
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
            const SizedBox(height: 15),
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
                    onTap: onPressCoupon,
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
                          text: "Aplicarlo ",
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
            const SizedBox(height: 15),
            !addAmount
                ? BankTranferContainer(
                    title: "A qué banco te depositamos",
                    providerWatch: selectedBankAccountReceiverProvider,
                    isSended: false,
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 15),
            !addAmount
                ? TermConditionsStepReinvest(
                    conditions: conditions,
                    uuid: data.uuid,
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

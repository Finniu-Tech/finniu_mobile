import 'dart:async';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/constants/number_format.dart';
import 'package:finniu/domain/entities/bank_entity.dart';
import 'package:finniu/domain/entities/calculate_investment.dart';
import 'package:finniu/domain/entities/fund_entity.dart';
import 'package:finniu/domain/entities/user_bank_account_entity.dart';
import 'package:finniu/infrastructure/models/calculate_investment.dart';
import 'package:finniu/infrastructure/models/fund/corporate_investment_models.dart';
import 'package:finniu/infrastructure/models/pre_investment_form.dart';
import 'package:finniu/infrastructure/models/re_investment/input_models.dart';
import 'package:finniu/presentation/providers/calculate_investment_provider.dart';
import 'package:finniu/presentation/providers/dead_line_provider.dart';
import 'package:finniu/presentation/providers/funds_provider.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/investment_simulation.dart';
import 'package:finniu/presentation/screens/home/widgets/modals.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widgets/header.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widgets/scafold.dart';
import 'package:finniu/widgets/custom_select_button.dart';
import 'package:finniu/widgets/snackbar.dart';
import 'package:finniu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class InvestmentProcessStep1Screen extends ConsumerWidget {
  final FundEntity fund;
  final int? amount;
  final String? deadLine;
  const InvestmentProcessStep1Screen({
    super.key,
    required this.fund,
    this.amount,
    this.deadLine,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);

    return CustomLoaderOverlay(
      child: ScaffoldInvestment(
        isDarkMode: currentTheme.isDarkMode,
        backgroundColor: currentTheme.isDarkMode
            ? Color(
                fund.getHexDetailColorDark(),
              )
            : Color(fund.getHexDetailColorLight()),
        body: Step1Body(fund: fund, isDarkMode: currentTheme.isDarkMode, amount: amount, deadLine: deadLine),
      ),
    );
  }
}

class Step1Body extends HookConsumerWidget {
  final FundEntity fund;
  final bool isDarkMode;
  final int? amount;
  final String? deadLine;
  const Step1Body({
    super.key,
    required this.fund,
    required this.isDarkMode,
    this.amount,
    this.deadLine,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    final amountController = useTextEditingController(text: amount == null ? '' : amount.toString());
    final couponController = useTextEditingController();
    final deadLineController = useTextEditingController(text: deadLine == null ? '' : deadLine);
    // final bankController = useTextEditingController();
    final originFundsController = useTextEditingController();
    final otherFundOriginController = useTextEditingController();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            width: MediaQuery.of(context).size.width * 0.85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                HeaderWidget(
                  containerColor:
                      isDarkMode ? fund.getHexDetailColorSecondaryDark() : fund.getHexDetailColorSecondaryLight(),
                  textColor: aboutTextBusinessColor,
                  iconColor:
                      isDarkMode ? fund.getHexDetailColorSecondaryDark() : fund.getHexDetailColorSecondaryLight(),
                  urlIcon: fund.iconUrl!,
                  labelText: 'Acerca de',
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  fund.name,
                  style: TextStyle(color: Color(primaryDark), fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Completa los siguientes datos',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(primaryDark),
                    // color: Colors.blue,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                FormStep1(
                  amountController: amountController,
                  couponController: couponController,
                  deadLineController: deadLineController,
                  // bankController: bankController,
                  originFundsController: originFundsController,
                  otherFundOriginController: otherFundOriginController,
                  fund: fund,
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FormStep1 extends StatefulHookConsumerWidget {
  final TextEditingController amountController;
  final TextEditingController couponController;
  final TextEditingController deadLineController;
  // final TextEditingController bankController;
  final TextEditingController originFundsController;
  final TextEditingController otherFundOriginController;
  final FundEntity fund;

  const FormStep1({
    super.key,
    required this.amountController,
    required this.couponController,
    required this.deadLineController,
    required this.originFundsController,
    required this.otherFundOriginController,
    required this.fund,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FormStep1State();
}

class _FormStep1State extends ConsumerState<FormStep1> {
  // final currentTheme = ref.watch(settingsNotifierProvider);

  late Future deadLineFuture;
  late Future bankFuture;
  late double? profitability;
  late bool showInvestmentBoxes = false;
  PlanSimulation? resultCalculator;
  BankEntity? selectedBank;
  BankAccount? selectedBankAccount;

  Future<void> _savePreInvestment(BuildContext context, WidgetRef ref, SaveCorporateInvestmentInput input) async {
    Navigator.pop(context);
    context.loaderOverlay.show();
    final response = await ref.read(saveCorporateInvestmentFutureProvider(input).future);

    if (!response.success) {
      context.loaderOverlay.hide();

      CustomSnackbar.show(
        context,
        response.messages?[0].message ?? 'Hubo un problema, asegúrate de haber completado todos los campos',
        'error',
      );
      return;
    }

    context.loaderOverlay.hide();

    Navigator.pushNamed(
      context,
      '/v2/investment/step-2',
      arguments: {
        'fund': widget.fund,
        'preInvestmentUUID': response.preInvestmentUUID,
        'amount': input.amount,
      },
    );
  }

  bool validateForm() {
    if (widget.amountController.text.isEmpty ||
        widget.deadLineController.text.isEmpty ||
        // widget.bankController.text.isEmpty ||
        widget.originFundsController.text.isEmpty) {
      CustomSnackbar.show(
        context,
        'Hubo un problema, asegúrate de haber completado los campos anteriores',
        'error',
      );

      return false;
    }

    if (widget.originFundsController.text == 'Otros' && widget.otherFundOriginController.text.isEmpty) {
      CustomSnackbar.show(
        context,
        'Debe de ingresar el origen de los fondos',
        'error',
      );
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final deadLineFuture = ref.watch(deadLineFutureProvider.future);

    final isSoles = ref.watch(isSolesStateProvider);
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final userProfile = ref.watch(userProfileNotifierProvider);

    useEffect(
      () {
        if (userProfile.hasRequiredData() == false) {
          completeProfileDialog(context, ref);
        }

        return null;
      },
      [userProfile],
    );

    return Center(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            constraints: const BoxConstraints(
              minWidth: 263,
              maxWidth: 400,
              maxHeight: 45,
              minHeight: 45,
            ),
            child: TextFormField(
              controller: widget.amountController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Este dato es requerido';
                }
                return null;
              },
              onChanged: (value) {},
              decoration: const InputDecoration(
                hintText: 'Escriba su monto de inversion',
                hintStyle: TextStyle(color: Color(grayText), fontSize: 11),
                label: Text("Monto"),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'^[0-9]*$'),
                ), // Solo permite números
              ],
              keyboardType: TextInputType.number,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            constraints: const BoxConstraints(
              minWidth: 263,
              maxWidth: 400,
              maxHeight: 45,
              minHeight: 45,
            ),
            child: CustomSelectButton(
              asyncItems: (String filter) async {
                final response = await deadLineFuture;
                return response.map((e) => e.name).toList();
              },
              callbackOnChange: (value) async {
                widget.deadLineController.text = value;
              },
              textEditingController: widget.deadLineController,
              labelText: "Plazo",
              hintText: "Seleccione su plazo de inversión",
              // enabledFillColor: isDarkMode ? Color(scaffoldBlackBackground) : Color(scaffoldSkyBlueBackground),
              enabledFillColor:
                  isDarkMode ? Color(widget.fund.getHexDetailColorDark()) : Color(widget.fund.getHexDetailColorLight()),
              unselectedItemColor: isDarkMode
                  ? Color(widget.fund.getHexDetailColorSecondaryDark())
                  : Color(widget.fund.getHexDetailColorSecondaryLight()),
              dropdownBackgroundColor: isDarkMode
                  ? Color(widget.fund.getHexDetailColorDark())
                  : Color(
                      widget.fund.getHexDetailColorLight(),
                    ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            constraints: const BoxConstraints(
              minWidth: 263,
              maxWidth: 400,
              maxHeight: 45,
              minHeight: 45,
            ),
            child: CustomSelectButton(
              asyncItems: (String filter) async {
                return OriginFoundsUtil.getReadableNames();
              },
              callbackOnChange: (value) async {
                setState(() {
                  widget.originFundsController.text = value;
                  if (value != 'Otros') {
                    widget.otherFundOriginController.clear();
                  }
                });
              },
              textEditingController: widget.originFundsController,
              labelText: "Origen de procedencia del dinero",
              hintText: "Seleccione el origen",
              enabledFillColor:
                  isDarkMode ? Color(widget.fund.getHexDetailColorDark()) : Color(widget.fund.getHexDetailColorLight()),
              unselectedItemColor: isDarkMode
                  ? Color(widget.fund.getHexDetailColorSecondaryDark())
                  : Color(widget.fund.getHexDetailColorSecondaryLight()),
              dropdownBackgroundColor: isDarkMode
                  ? Color(widget.fund.getHexDetailColorDark())
                  : Color(
                      widget.fund.getHexDetailColorLight(),
                    ),
            ),
          ),
          if (widget.originFundsController.text == 'Otros') ...[
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              constraints: const BoxConstraints(
                minWidth: 263,
                maxWidth: 400,
                maxHeight: 45,
                minHeight: 45,
              ),
              child: TextFormField(
                controller: widget.otherFundOriginController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Este dato es requerido';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Escriba el origen de los fondos',
                  hintStyle: TextStyle(color: Color(grayText), fontSize: 11),
                  label: Text("Origen de los fondos"),
                ),
              ),
            ),
          ],
          const SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            constraints: const BoxConstraints(
              minWidth: 263,
              maxWidth: 400,
              maxHeight: 45,
              minHeight: 45,
            ),
            child: TextFormField(
              controller: widget.couponController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Este dato es requerido';
                }
                return null;
              },
              onChanged: (value) {},
              decoration: InputDecoration(
                suffixIconConstraints: const BoxConstraints(
                  maxHeight: 50,
                  maxWidth: 150,
                ),
                suffixIcon: Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // minimumSize: Size(80, 30),
                      side: const BorderSide(
                        width: 0.5,
                        color: Color(primaryDark),
                      ),
                      backgroundColor: const Color(primaryLight),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 12, bottom: 10),
                      child: Text(
                        "Aplicarlo",
                        style: TextStyle(
                          color: Color(primaryDark),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      if (widget.amountController.text.isEmpty || widget.deadLineController.text.isEmpty) {
                        CustomSnackbar.show(
                          context,
                          'Debes ingresar el monto y el plazo para aplicar el cupón',
                          'error',
                        );
                        return; // Sale de la función para evitar que continúe el proceso
                      }
                      if (widget.couponController.text.isEmpty) {
                        CustomSnackbar.show(
                          context,
                          'Debes ingresar el cupón',
                          'error',
                        );
                        return;
                      }
                      context.loaderOverlay.show();
                      final inputCalculator = CalculatorInput(
                        amount: int.parse(widget.amountController.text),
                        months: int.parse(
                          widget.deadLineController.text.split(' ')[0],
                        ),
                        currency: isSoles ? currencyNuevoSol : currencyDollar,
                        coupon: widget.couponController.text,
                      );

                      resultCalculator = await ref.watch(
                        calculateInvestmentFutureProvider(
                          inputCalculator,
                        ).future,
                      );
                      setState(() {
                        if (resultCalculator?.plan != null) {
                          // selectedPlan = resultCalculator!.plan!;
                          profitability = resultCalculator!.profitability;
                          showInvestmentBoxes = true;
                        }
                      });

                      context.loaderOverlay.hide();
                      if (resultCalculator?.error == null) {
                        CustomSnackbar.show(
                          context,
                          'Cupón aplicado correctamente',
                          'success',
                        );
                      } else {
                        widget.couponController.clear();
                        CustomSnackbar.show(
                          context,
                          resultCalculator?.error ?? 'Hubo un problema, intenta nuevamente',
                          'error',
                        );
                      }
                    },
                  ),
                ),
                hintText: 'Ingresa tu código',
                hintStyle: const TextStyle(color: Color(grayText), fontSize: 11),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                ),
                label: const Text(
                  "Ingresa tu códigos promocional,si tienes uno",
                ),
              ),
            ),
          ),
          if (showInvestmentBoxes) ...[
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 136,
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
                          ), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${resultCalculator?.finalRentability?.toString() ?? 0}% ',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(primaryDark),
                          ),
                        ),
                        const Text(
                          '% de retorno',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(blackText),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 17),
                  Container(
                    width: 136,
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
                          ), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isSoles ? formatterSoles.format(profitability) : formatterUSD.format(profitability),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(primaryDark),
                          ),
                        ),
                        Text(
                          'En ${resultCalculator?.months} meses tendrías',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color(blackText),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ] else ...[
            const SizedBox(
              height: 80,
            ),
          ],
          SizedBox(
            width: 224,
            height: 50,
            child: TextButton(
              onPressed: () async {
                if (userProfile.hasRequiredData() == false) {
                  completeProfileDialog(context, ref);
                  return;
                }
                if (validateForm() == false) {
                  return;
                }
                investmentSimulationModal(
                  context,
                  startingAmount: int.parse(widget.amountController.text),
                  finalAmount: int.parse(widget.amountController.text),
                  mouthInvestment: int.parse(widget.deadLineController.text.split(' ')[0]),
                  toInvestPressed: () {
                    _savePreInvestment(
                      context,
                      ref,
                      SaveCorporateInvestmentInput(
                        amount: widget.amountController.text,
                        months: widget.deadLineController.text.split(' ')[0],
                        coupon: widget.couponController.text,
                        currency: isSoles ? currencyNuevoSol : currencyDollar,
                        originFunds: OriginFunds(
                          originFundsEnum: OriginFoundsUtil.fromReadableName(widget.originFundsController.text),
                          otherText: widget.otherFundOriginController.text,
                        ),
                        fundUUID: widget.fund.uuid,
                      ),
                    );
                  },
                  recalculatePressed: () {
                    Navigator.pop(context);
                  },
                );
              },
              child: const Text(
                'Continuar',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

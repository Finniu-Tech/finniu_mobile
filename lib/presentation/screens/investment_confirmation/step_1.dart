import 'dart:async';

import 'package:finniu/constants/colors.dart';
import 'package:finniu/constants/number_format.dart';
import 'package:finniu/domain/entities/bank_entity.dart';
import 'package:finniu/domain/entities/calculate_investment.dart';
import 'package:finniu/domain/entities/dead_line.dart';
import 'package:finniu/domain/entities/plan_entities.dart';
import 'package:finniu/domain/entities/re_investment_entity.dart';
import 'package:finniu/domain/entities/user_bank_account_entity.dart';
import 'package:finniu/infrastructure/models/pre_investment_form.dart';
import 'package:finniu/infrastructure/models/re_investment/input_models.dart';
import 'package:finniu/presentation/providers/bank_provider.dart';
import 'package:finniu/presentation/providers/calculate_investment_provider.dart';
import 'package:finniu/presentation/providers/dead_line_provider.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/plan_provider.dart';
import 'package:finniu/presentation/providers/pre_investment_provider.dart';
import 'package:finniu/presentation/providers/re_investment_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/home/widgets/modals.dart';
import 'package:finniu/presentation/screens/investment_confirmation/step_2.dart';
import 'package:finniu/presentation/screens/investment_confirmation/utils.dart';
import 'package:finniu/presentation/screens/reinvest_process/widgets/modal_widgets.dart';
import 'package:finniu/widgets/custom_select_button.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:finniu/widgets/snackbar.dart';
import 'package:finniu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../infrastructure/models/calculate_investment.dart';

class Step1 extends HookConsumerWidget {
  const Step1({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    final amountController = useTextEditingController();
    final couponController = useTextEditingController();
    final deadLineController = useTextEditingController();
    final bankController = useTextEditingController();
    final originFundsController = useTextEditingController();
    final otherFundOriginController = useTextEditingController();

    final uuidPlan = (ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>)['planUuid'];
    final isSoles = ref.watch(isSolesStateProvider);

    return CustomLoaderOverlay(
      child: CustomScaffoldReturnLogo(
        hideReturnButton: false,
        hideNavBar: true,
        body: HookBuilder(
          builder: (context) {
            final planList = ref.watch(planListFutureProvider);
            return planList.when(
              data: (plans) {
                final _plans = isSoles ? plans.soles : plans.dolar;
                return Step1Body(
                  currentTheme: currentTheme,
                  amountController: amountController,
                  deadLineController: deadLineController,
                  bankTypeController: bankController,
                  couponController: couponController,
                  originFundsController: originFundsController,
                  otherFundOriginController: otherFundOriginController,
                  bankController: bankController,
                  isSoles: isSoles,
                  // bankNumberController: bankNumberController,
                  plan: _plans.firstWhere((element) => element.uuid == uuidPlan),
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stack) => Center(
                child: Text(error.toString()),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Step1Body extends StatefulHookConsumerWidget {
  const Step1Body({
    super.key,
    required this.currentTheme,
    required this.amountController,
    required this.deadLineController,
    required this.bankTypeController,
    required this.couponController,
    required this.isSoles,
    required this.originFundsController,
    required this.otherFundOriginController,
    required this.bankController,
    // required this.bankNumberController,
    required this.plan,
  });

  final SettingsProviderState currentTheme;
  final TextEditingController amountController;
  final TextEditingController deadLineController;
  final TextEditingController bankTypeController;
  // final TextEditingController bankNumberController;
  final TextEditingController couponController;
  final TextEditingController originFundsController;
  final TextEditingController otherFundOriginController;
  final TextEditingController bankController;
  final bool isSoles;

  final PlanEntity plan;

  @override
  _Step1BodyState createState() => _Step1BodyState();
}

class _Step1BodyState extends ConsumerState<Step1Body> {
  late Future deadLineFuture;
  late Future bankFuture;
  late double? profitability;
  late bool showInvestmentBoxes = false;
  PlanSimulation? resultCalculator;
  late PlanEntity? selectedPlan;
  BankEntity? selectedBank;
  BankAccount? selectedBankAccount;

  Future<void> _updateBankAccount() async {
    final _selectedBankAccount = ref.read(selectedBankAccountSenderProvider);
    if (_selectedBankAccount != null) {
      widget.bankController.text = BankAccount.getSafeBankAccountNumber(
        _selectedBankAccount.bankAccount,
      );
      final banks = await ref.read(bankFutureProvider.future);
      final _selectedBank = BankEntity.getBankByName(_selectedBankAccount.bankName, banks);
      setState(() {
        selectedBank = _selectedBank;
        selectedBankAccount = _selectedBankAccount;
      });
    } else {
      widget.bankController.text = '';
    }
  }

  bool validate() {
    if (widget.amountController.text.isEmpty ||
        widget.deadLineController.text.isEmpty ||
        widget.bankController.text.isEmpty ||
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

  Future<void> calculateInvestment(BuildContext context, WidgetRef ref) async {
    if (widget.amountController.text.isNotEmpty) {
      context.loaderOverlay.show();
      final inputCalculator = CalculatorInput(
        amount: int.parse(widget.amountController.text),
        months: int.parse(widget.deadLineController.text.split(' ')[0]),
        coupon: widget.couponController.text,
        currency: widget.isSoles ? currencyNuevoSol : currencyDollar,
      );

      try {
        resultCalculator = await ref.watch(
          calculateInvestmentFutureProvider(inputCalculator).future,
        );

        setState(() {
          if (resultCalculator?.plan != null) {
            selectedPlan = resultCalculator!.plan!;
            profitability = resultCalculator!.profitability;
            showInvestmentBoxes = true;
          }
        });
        context.loaderOverlay.hide();
      } catch (e) {
        context.loaderOverlay.hide();
        CustomSnackbar.show(
          context,
          'Hubo un problema, intenta nuevamente',
          'error',
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(selectedBankAccountSenderProvider.notifier).state = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deadLineFuture = ref.watch(deadLineFutureProvider.future);
    final userProfile = ref.watch(userProfileNotifierProvider);
    final isSoles = ref.watch(isSolesStateProvider);
    final debouncer = Debouncer(milliseconds: 3000);
    final currency = widget.isSoles ? currencyEnum.PEN : currencyEnum.USD;

    useEffect(
      () {
        selectedPlan = widget.plan;
        if (userProfile.hasRequiredData() == false) {
          completeProfileDialog(context, ref);
        }

        _updateBankAccount();

        calculateInvestment(context, ref);
        return null;
      },
      [userProfile],
    );
    ref.listen<BankAccount?>(selectedBankAccountSenderProvider, (previous, next) {
      _updateBankAccount();
    });

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const StepBar(
              step: 1,
            ),
            const SizedBox(height: 40),
            SizedBox(
              // width: 200,
              child: Stack(
                children: <Widget>[
                  Text(
                    'Tu plan seleccionado',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(Theme.of(context).colorScheme.secondary.value),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // alignment: Alignment.topRight,
              width: MediaQuery.of(context).size.width * 0.63,
              constraints: const BoxConstraints(minWidth: 263, maxWidth: 263),
              height: 99,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(
                top: 30,
              ),
              decoration: BoxDecoration(
                color: const Color(cardBackgroundColorLight),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    spreadRadius: 0,
                    blurRadius: 2,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    width: 90,
                    height: 100,
                    color: Colors.transparent,
                    child: SizedBox(
                      width: 80,
                      height: 90,
                      child: selectedPlan?.imageUrl != null
                          ? Image.network(
                              selectedPlan!.imageUrl!,
                              width: 80,
                              height: 90,
                            )
                          : const Image(
                              image: AssetImage('assets/result/money.png'),
                              fit: BoxFit.contain,
                            ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // 'test',
                        selectedPlan!.name,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Color(primaryDark),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Image(
                            image: AssetImage('assets/icons/dollar.png'),
                            width: 12,
                            height: 12,
                            color: Color(
                              primaryDark,
                            ),
                          ),
                          Text(
                            'Desde ${isSoles ? formatterSoles.format(selectedPlan!.minAmount) : formatterUSD.format(selectedPlan!.minAmount)}',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: Color(primaryDark),
                              fontSize: 10,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Image(
                            image: AssetImage('assets/icons/double_dollar.png'),
                            width: 21, // ancho deseado de la imagen
                            height: 21, // alto deseado de la imagen
                            color: Color(
                              primaryDark,
                            ), // color de la imagen si es necesario
                          ),
                          Text(
                            '${selectedPlan!.twelveMonthsReturn.toString()}% anual',
                            // plan.twelveMonthsReturn.toString(),
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: Color(primaryDark),
                              fontSize: 10,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Completa los siguientes datos',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: widget.currentTheme.isDarkMode ? const Color(whiteText) : const Color(primaryDark),
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(
              height: 10,
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
                controller: widget.amountController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Este dato es requerido';
                  }
                  return null;
                },
                onChanged: (value) {
                  debouncer.run(() {
                    if (widget.amountController.text.isNotEmpty && widget.deadLineController.text.isNotEmpty) {
                      calculateInvestment(context, ref);
                    }
                  });
                },
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
            const SizedBox(height: 15),
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
                  if (widget.amountController.text.isNotEmpty && widget.deadLineController.text.isNotEmpty) {
                    calculateInvestment(context, ref);
                  }
                },
                textEditingController: widget.deadLineController,
                labelText: "Plazo",
                hintText: "Seleccione su plazo de inversión",
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              constraints: const BoxConstraints(
                minWidth: 263,
                maxWidth: 400,
                maxHeight: 45,
                minHeight: 45,
              ),
              child: InkWell(
                onTap: () async {
                  // show accounts modal
                  showBankAccountModal(
                    context,
                    ref,
                    currency,
                    true,
                    "",
                  );
                },
                child: IgnorePointer(
                  child: TextFormField(
                    controller: widget.bankController,
                    readOnly: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Este dato es requerido';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: widget.bankController.text.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(right: 8.0, left: 20.0),
                              child: selectedBank != null
                                  ? selectedBank!.logoUrl!.isNotEmpty
                                      ? Image.network(
                                          selectedBank?.logoUrl ?? '',
                                          width: 13,
                                          height: 13,
                                          fit: BoxFit.contain,
                                        )
                                      : const Icon(
                                          Icons.account_balance,
                                          color: Colors.grey,
                                          size: 13,
                                        )
                                  : null,
                            )
                          : null,
                      suffixIconConstraints: const BoxConstraints(
                        maxHeight: 39,
                        maxWidth: 39,
                      ),
                      suffixIcon: const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.grey,
                        ),
                      ),
                      hintText: 'Nombre del banco',
                      hintStyle: const TextStyle(color: Color(grayText), fontSize: 11),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      labelText: "Desde qué banco realizas la transferencia",
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              constraints: const BoxConstraints(
                minWidth: 263,
                maxWidth: 400,
                maxHeight: 45,
                minHeight: 45,
              ),
              child: CustomSelectButton(
                asyncItems: (String filter) async {
                  // return OriginFoundsEnum.values.map((e) => OriginFoundsUtil.toReadableName(e)).toList();
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
            const SizedBox(
              height: 15,
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
                            selectedPlan = resultCalculator!.plan!;
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 136,
                      height: 81,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(primaryLightAlternative),
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
                            // '${(() {
                            //   if (widget.resultCalculator?.months == 6) {
                            //     return widget.plan.sixMonthsReturn;
                            //   } else {
                            //     return widget.plan.twelveMonthsReturn;
                            //   }
                            // })()}%',
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
                      height: 81,
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
            ],
            const SizedBox(
              height: 20,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 30, left: 42),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: const [
            //       Text(
            //         // textAlign: TextAlign.start,
            //         "Moneda",
            //         style: TextStyle(fontSize: 13),
            //       ),
            //       Spacer(),
            //       SwitchMoney(
            //         switchHeight: 34,
            //         switchWidth: 67,
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              width: 224,
              height: 50,
              child: TextButton(
                onPressed: () async {
                  if (userProfile.hasRequiredData() == false) {
                    completeProfileDialog(context, ref);
                    return;
                  }
                  if (validate() == false) {
                    return;
                  }

                  final deadLineUuid = DeadLineEntity.getUuidByName(
                    widget.deadLineController.text,
                    await deadLineFuture,
                  );

                  final originFund = widget.originFundsController.text;

                  final preInvestment = PreInvestmentForm(
                    amount: int.parse(widget.amountController.text),
                    deadLineUuid: deadLineUuid,
                    coupon: widget.couponController.text,
                    planUuid: widget.plan.uuid,
                    currency: isSoles ? currencyNuevoSol : currencyDollar,
                    bankAccountNumber: selectedBankAccount!.id,
                    originFunds: OriginFunds(
                      originFundsEnum: OriginFoundsUtil.fromReadableName(originFund),
                      otherText: widget.otherFundOriginController.text,
                    )
                    // bankAccountNumber: widget.bankNumberController.text,
                    ,
                  );
                  context.loaderOverlay.show();
                  final preInvestmentEntityResponse = await ref.watch(preInvestmentSaveProvider(preInvestment).future);

                  if (preInvestmentEntityResponse?.success == false) {
                    context.loaderOverlay.hide();
                    // CHECK HERE
                    CustomSnackbar.show(
                      context,
                      preInvestmentEntityResponse?.error ?? 'Hubo un problema, intenta nuevamente',
                      'error',
                    );
                    return;
                  } else {
                    context.loaderOverlay.hide();
                    ref
                        .read(
                          preInvestmentVoucherImagesPreviewProvider.notifier,
                        )
                        .state = [];
                    ref.read(preInvestmentVoucherImagesProvider.notifier).state = [];
                    Navigator.pushNamed(
                      context,
                      '/investment_step2',
                      arguments: PreInvestmentStep2Arguments(
                        plan: selectedPlan!,
                        preInvestment: preInvestmentEntityResponse!.preInvestment!,
                        resultCalculator: resultCalculator!,
                      ),
                    );
                  }
                },
                child: const Text(
                  'Continuar',
                ),
              ),
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

class StepBar extends ConsumerStatefulWidget {
  final int step;

  const StepBar({
    Key? key,
    required this.step,
  });

  @override
  _StepBarState createState() => _StepBarState();
}

class _StepBarState extends ConsumerState<StepBar> {
  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    final Color activeBackgroundColor = currentTheme.isDarkMode ? const Color(secondary) : const Color(primaryLight);
    final Color inactiveBackgroundColor = currentTheme.isDarkMode ? Colors.transparent : Colors.transparent;

    final Color inactiveBorderColor = currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark);
    const Color activeBorderColor = Colors.transparent;
    final Color activeIconColor = currentTheme.isDarkMode ? const Color(primaryDark) : const Color(primaryDark);
    final Color inactiveIconColor = currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark);

    // Color backgroundColor = currentTheme.isDarkMode
    //     ? const Color(secondary)
    //     : const Color(primaryLight);
    // Color containerColor = inactiveColor; // Color por defecto

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 13,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 55,
              decoration: BoxDecoration(
                color: widget.step == 1 ? activeBackgroundColor : inactiveBackgroundColor,
                border: Border.all(
                  color: widget.step == 1 ? activeBorderColor : inactiveBorderColor,
                  width: 2,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Image.asset(
                  'assets/icons/dollar.png',
                  color: widget.step == 1 ? activeIconColor : inactiveIconColor,

                  // fit:BoxFit.scaleDown,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            SizedBox(
              width: 38,
              child: Column(
                children: [
                  Divider(
                    color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
                    thickness: 1,
                  ),
                ],
              ),
            ),
            Container(
              height: 40,
              width: 55,
              decoration: BoxDecoration(
                color: widget.step == 2 ? activeBackgroundColor : inactiveBackgroundColor,
                border: Border.all(
                  color: widget.step == 2 ? activeBorderColor : inactiveBorderColor,
                  width: 2,
                ),
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  'assets/icons/paper.png',
                  color: widget.step == 2 ? activeIconColor : inactiveIconColor,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            SizedBox(
              width: 38,
              child: Column(
                children: [
                  Divider(
                    color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
                    thickness: 1,
                  ),
                ],
              ),
            ),
            Container(
              height: 40,
              width: 55,
              decoration: BoxDecoration(
                color: widget.step == 3 ? activeBackgroundColor : inactiveBackgroundColor,
                border: Border.all(
                  color: widget.step == 3 ? activeBorderColor : inactiveBorderColor,
                  width: 2,
                ),
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  'assets/icons/square2.png',
                  color: widget.step == 3 ? activeIconColor : inactiveIconColor,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

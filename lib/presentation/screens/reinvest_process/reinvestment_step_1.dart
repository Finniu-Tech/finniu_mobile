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
import 'package:finniu/presentation/providers/re_investment_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/investment_confirmation/utils.dart';
import 'package:finniu/presentation/screens/reinvest_process/widgets/cards_widgets.dart';
import 'package:finniu/presentation/screens/reinvest_process/widgets/modal_widgets.dart';
import 'package:finniu/presentation/screens/reinvest_process/widgets/step_bar.dart';
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

class ReinvestmentStep1 extends HookConsumerWidget {
  const ReinvestmentStep1({
    super.key,
    required this.preInvestmentUUID,
    required this.preInvestmentAmount,
    required this.currency,
    required this.reInvestmentType,
  });
  final String preInvestmentUUID;
  final double preInvestmentAmount;
  final String currency;
  final String reInvestmentType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    final mountController = useTextEditingController();
    final couponController = useTextEditingController();
    final deadLineController = useTextEditingController();
    final bankController = useTextEditingController();
    final originFundsController = useTextEditingController();
    final otherOriginFundsController = useTextEditingController();

    return CustomLoaderOverlay(
      child: CustomScaffoldReturnLogo(
        hideReturnButton: false,
        hideNavBar: true,
        body: ReinvestmentStep1Body(
          currentTheme: currentTheme,
          mountController: mountController,
          deadLineController: deadLineController,
          bankController: bankController,
          couponController: couponController,
          isSoles: currency == 'PEN' || currency == currencyEnum.PEN,
          originFundsController: originFundsController,
          preInvestmentUUID: preInvestmentUUID,
          preInvestmentAmount: preInvestmentAmount,
          otherFundOriginController: otherOriginFundsController,
          reInvestmentType: reInvestmentType,
        ),
      ),
    );
  }
}

class ReinvestmentStep1Body extends StatefulHookConsumerWidget {
  const ReinvestmentStep1Body({
    super.key,
    required this.currentTheme,
    required this.mountController,
    required this.deadLineController,
    required this.bankController,
    required this.couponController,
    required this.isSoles,
    required this.originFundsController,
    required this.preInvestmentUUID,
    required this.preInvestmentAmount,
    required this.otherFundOriginController,
    required this.reInvestmentType,
  });

  final SettingsProviderState currentTheme;
  final TextEditingController mountController;
  final TextEditingController deadLineController;
  final TextEditingController bankController;
  final TextEditingController couponController;
  final TextEditingController originFundsController;
  final TextEditingController otherFundOriginController;
  final String preInvestmentUUID;
  final double preInvestmentAmount;
  final bool isSoles;
  final String reInvestmentType;

  @override
  _Step1BodyState createState() => _Step1BodyState();
}

class _Step1BodyState extends ConsumerState<ReinvestmentStep1Body> {
  late Future deadLineFuture;
  late Future bankFuture;
  late double? profitability;
  late bool showInvestmentBoxes = false;
  late BankEntity? selectedBank;
  BankAccount? selectedBankAccount;
  PlanEntity? plan;
  late PlanSimulation? resultCalculator;
  final amountFocusNode = FocusNode();

  // late PlanEntity? selectedPlan;

  Future<void> calculateInvestment(BuildContext context, WidgetRef ref) async {
    if (widget.mountController.text.isNotEmpty) {
      context.loaderOverlay.show();
      final extraAmount = num.tryParse(widget.mountController.text)?.toInt() ?? 0;
      final finalAmount = extraAmount + widget.preInvestmentAmount;

      final inputCalculator = CalculatorInput(
        amount: finalAmount.toInt(),
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
            plan = resultCalculator!.plan!;
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
    if (widget.mountController.text.isEmpty ||
        widget.deadLineController.text.isEmpty ||
        widget.bankController.text.isEmpty) {
      CustomSnackbar.show(
        context,
        'Hubo un problema, asegúrate de haber completado los campos anteriores',
        'error',
      );
      return false;
    }
    if (widget.reInvestmentType == typeReinvestmentEnum.CAPITAL_ADITIONAL &&
        widget.originFundsController.text.isEmpty) {
      CustomSnackbar.show(
        context,
        'Hubo un problema, asegúrate de haber completado los campos anteriores',
        'error',
      );
      return false;
    }
    if (widget.reInvestmentType == typeReinvestmentEnum.CAPITAL_ADITIONAL && widget.mountController.text.isEmpty) {
      CustomSnackbar.show(
        context,
        'Debe de ingresar un monto adicional',
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(selectedBankAccountSenderProvider.notifier).state = null;
      _updateBankAccount();
      widget.mountController.text = '0';
      widget.deadLineController.text = '12 meses';
      calculateInvestment(context, ref);
    });
  }

  @override
  void dispose() {
    amountFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deadLineFuture = ref.watch(deadLineFutureProvider.future);

    final currency = widget.isSoles ? currencyEnum.PEN : currencyEnum.USD;
    final theme = ref.watch(settingsNotifierProvider);
    final moneySymbol = widget.isSoles ? "S/" : "\$";
    final _debouncer = Debouncer(milliseconds: 2500);
    final finalAmountState = useState(widget.preInvestmentAmount);

    ref.listen<BankAccount?>(selectedBankAccountSenderProvider, (previous, next) {
      _updateBankAccount();
    });

    return GestureDetector(
      onTap: () {
        print('onTap focusss');
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const StepBarReInvestment(
              step: 1,
            ),
            const SizedBox(height: 20),
            plan == null
                ? const SizedBox()
                : SizedBox(
                    // width: 200,
                    child: Text(
                      'Tu plan Seleccionado',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(
                          Theme.of(context).colorScheme.secondary.value,
                        ),
                      ),
                    ),
                  ),

            if (plan != null) ...[
              PlanCardWidget(
                theme: theme,
                isSoles: widget.isSoles,
                plan: plan!,
              ),
            ],
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                'Completa los siguientes datos',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: widget.currentTheme.isDarkMode ? const Color(whiteText) : const Color(primaryDark),
                  fontSize: 14,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              constraints: const BoxConstraints(minWidth: 263, maxWidth: 400),
              child: TextFormField(
                controller: widget.mountController,
                enabled: widget.reInvestmentType == typeReinvestmentEnum.CAPITAL_ONLY ? false : true,

                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Este dato es requerido';
                  }
                  return null;
                },
                onChanged: (value) {
                  _debouncer.run(() {
                    if (widget.mountController.text.isEmpty) {
                      widget.mountController.text = '0';
                    }
                    if (widget.mountController.text.isNotEmpty && widget.deadLineController.text.isNotEmpty) {
                      final aditionalAmount = num.tryParse(widget.mountController.text)?.toInt() ?? 0;
                      finalAmountState.value = aditionalAmount + widget.preInvestmentAmount;
                      calculateInvestment(context, ref);
                    }
                  });
                },
                // focusNode: amountFocusNode,
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                decoration: InputDecoration(
                  hintText: 'Escriba su monto de inversion',
                  hintStyle: const TextStyle(color: Color(grayText), fontSize: 11),
                  labelStyle: TextStyle(
                    color: widget.reInvestmentType == typeReinvestmentEnum.CAPITAL_ADITIONAL
                        ? theme.isDarkMode
                            ? const Color(primaryLight)
                            : const Color(primaryDark)
                        : const Color(grayText),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                  label: const Text("Monto Adicional"),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^[0-9]*$'),
                  ),
                ],
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 57,
              child: FinalAmountWidget(
                amount: finalAmountState.value,
                isSoles: true,
                isActive: widget.reInvestmentType == typeReinvestmentEnum.CAPITAL_ONLY ? false : true,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              constraints: const BoxConstraints(minWidth: 263, maxWidth: 400),
              child: CustomSelectButton(
                asyncItems: (String filter) async {
                  final response = await deadLineFuture;
                  return response.map((e) => e.name).toList();
                },
                callbackOnChange: (value) async {
                  widget.deadLineController.text = value;
                  if (widget.mountController.text.isNotEmpty && widget.deadLineController.text.isNotEmpty) {
                    calculateInvestment(context, ref);
                  }
                  //ONFOCUS
                  FocusScope.of(context).unfocus();
                },
                textEditingController: widget.deadLineController,
                labelText: "Plazo",
                hintText: "Seleccione su plazo de inversión",
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              constraints: const BoxConstraints(
                minWidth: 263,
                maxWidth: 400,
                maxHeight: 39,
                minHeight: 39,
              ),
              child: InkWell(
                onTap: () async {
                  // show accounts modal
                  showBankAccountModal(
                    context,
                    ref,
                    currency,
                    true,
                    widget.reInvestmentType,
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
                              child: selectedBank!.logoUrl!.isNotEmpty
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
                                    ),
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
              height: 20,
            ),

            //add select to origin of founds

            if (widget.reInvestmentType == typeReinvestmentEnum.CAPITAL_ADITIONAL) ...[
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                constraints: const BoxConstraints(
                  minWidth: 263,
                  maxWidth: 400,
                  maxHeight: 39,
                  minHeight: 39,
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
                    maxHeight: 39,
                    minHeight: 39,
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
                height: 20,
              ),
            ],

            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              constraints: const BoxConstraints(
                minWidth: 263,
                maxWidth: 400,
                maxHeight: 39,
                minHeight: 39,
              ),
              child: TextFormField(
                controller: widget.couponController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Este dato es requerido';
                  }
                  return null;
                },
                onChanged: (value) {
                  // nickNameController.text = value.toString();
                },
                decoration: InputDecoration(
                  suffixIconConstraints: const BoxConstraints(
                    maxHeight: 39,
                    maxWidth: 150,
                  ),
                  suffixIcon: Container(
                    margin: const EdgeInsets.all(0),
                    padding: const EdgeInsets.all(1),
                    // padding: const EdgeInsets.only(right: 10, left: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        // minimumSize: Size(80, 30),
                        side: const BorderSide(
                          width: 0.2,
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
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Aplicarlo",
                          style: TextStyle(
                            color: Color(primaryDark),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        if (widget.mountController.text.isEmpty || widget.deadLineController.text.isEmpty) {
                          CustomSnackbar.show(
                            context,
                            'Debes ingresar el monto y el plazo para aplicar el cupón',
                            'error',
                          );
                          return;
                        }
                        if (widget.couponController.text.isEmpty) {
                          CustomSnackbar.show(
                            context,
                            'Debes ingresar un cupón',
                            'error',
                          );
                          return;
                        }
                        context.loaderOverlay.show();
                        final inputCalculator = CalculatorInput(
                          // amount: int.parse(widget.mountController.text),
                          amount: (num.tryParse(widget.mountController.text)?.toInt() ?? 0) +
                              widget.preInvestmentAmount.toInt(),
                          months: int.parse(
                            widget.deadLineController.text.split(' ')[0],
                          ),
                          currency: widget.isSoles ? currencyNuevoSol : currencyDollar,
                          coupon: widget.couponController.text,
                        );

                        resultCalculator = await ref.watch(
                          calculateInvestmentFutureProvider(
                            inputCalculator,
                          ).future,
                        );
                        setState(() {
                          if (resultCalculator?.plan != null) {
                            plan = resultCalculator!.plan!;
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
                  label: const Text("Ingresa tu código promocional,si tienes uno"),
                ),
              ),
            ),

            if (showInvestmentBoxes) ...[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 136,
                          height: 70,
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
                          height: 70,
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
                                widget.isSoles
                                    ? formatterSoles.format(
                                        resultCalculator?.profitability ?? 0,
                                      )
                                    : formatterUSD.format(
                                        resultCalculator?.profitability ?? 0,
                                      ),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(primaryDark),
                                ),
                              ),
                              Text(
                                // 'En 12 meses tendrías',
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
                    const SizedBox(
                      height: 15,
                    ),
                    InvestmentDateRangeWidget(
                      endDate: resultCalculator!.getEndDateInSpanish(),
                      startDate: resultCalculator!.getStartDateInSpanish(),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(
              height: 20,
            ),

            SizedBox(
              width: 224,
              height: 50,
              child: TextButton(
                onPressed: () async {
                  if (!validate()) {
                    return;
                  }

                  final finalAmount = finalAmountState.value;
                  final deadLineUuid = DeadLineEntity.getUuidByName(
                    widget.deadLineController.text,
                    await deadLineFuture,
                  );
                  final originFound = widget.originFundsController.text;

                  final reInvestmentParams = CreateReInvestmentParams(
                    preInvestmentUUID: widget.preInvestmentUUID,
                    finalAmount: finalAmount.toString(),
                    currency: currency,
                    deadlineUUID: deadLineUuid,
                    bankAccountSender: selectedBankAccount!.id,
                    originFounds: OriginFunds(
                      originFundsEnum: OriginFoundsUtil.fromReadableName(originFound),
                      otherText: widget.otherFundOriginController.text,
                    ),
                    typeReinvestment: widget.reInvestmentType,
                  );
                  context.loaderOverlay.show();

                  final createReInvestmentResponse = await ref.watch(
                    createReInvestmentProvider(reInvestmentParams).future,
                  );
                  print(
                    'createReInvestmentResponse: $createReInvestmentResponse',
                  );
                  if (createReInvestmentResponse.success == false) {
                    context.loaderOverlay.hide();
                    // CHECK HERE
                    CustomSnackbar.show(
                      context,
                      createReInvestmentResponse.messages?[0].message ?? 'Hubo un problema, intenta nuevamente',
                      'error',
                    );
                    return; // Sale de la función para evitar que continúe el proceso
                  } else {
                    context.loaderOverlay.hide();

                    if (widget.reInvestmentType == typeReinvestmentEnum.CAPITAL_ADITIONAL &&
                        widget.mountController.text != '0') {
                      final aditionalAmount = num.tryParse(widget.mountController.text)?.toInt() ?? 0;
                      final finalAmount = aditionalAmount + widget.preInvestmentAmount;
                      Navigator.pushNamed(
                        context,
                        '/reinvestment_step_2',
                        arguments: {
                          'plan': plan,
                          'reInvestment': ReInvestmentEntity(
                            id: createReInvestmentResponse.reInvestmentUuid!,
                            contractURL: createReInvestmentResponse.reInvestmentContractUrl!,
                            finalAmount: finalAmount.toInt(),
                            currency: currency,
                            deadlineUUID: deadLineUuid,
                            bankAccountSenderUUID: selectedBank!.uuid,
                            typeReinvestment: typeReinvestmentEnum.CAPITAL_ADITIONAL,
                            originFounds: OriginFoundsUtil.fromReadableName(originFound).toString().split('.').last,
                            otherOriginFounds: widget.otherFundOriginController.text,
                            coupon: widget.couponController.text,
                          ),
                          'resultCalculator': resultCalculator,
                        },
                      );
                    } else {
                      showBankAccountModal(context, ref, currency, false, typeReinvestmentEnum.CAPITAL_ONLY);
                    }
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

class PlanCardWidget extends StatelessWidget {
  const PlanCardWidget({
    super.key,
    required this.theme,
    required this.isSoles,
    required this.plan,
  });

  final SettingsProviderState theme;
  final bool isSoles;
  final PlanEntity plan;

  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.topRight,
      width: MediaQuery.of(context).size.width * 0.63,
      constraints: const BoxConstraints(minWidth: 263, maxWidth: 263),
      height: 99,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(
        top: 20,
      ),
      decoration: BoxDecoration(
        color: theme.isDarkMode ? const Color(cardBackgroundColorDark) : const Color(cardBackgroundColorLight),
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
              child: plan.imageUrl != null
                  ? Image.network(
                      plan.imageUrl!,
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // selectedPlan!.name,
                plan.name,
                // 'test plan',
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Color(primaryDark),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
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
                    'Desde ${isSoles ? formatterSoles.format(plan.minAmount) : formatterUSD.format(plan.minAmount)}',
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
                    '${plan.twelveMonthsReturn.toString()}% anual',
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
    );
  }
}

//TODO move tu widget  folde
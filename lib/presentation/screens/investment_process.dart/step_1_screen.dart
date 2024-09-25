import 'dart:async';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/constants/number_format.dart';
import 'package:finniu/domain/entities/bank_entity.dart';
import 'package:finniu/domain/entities/calculate_investment.dart';
import 'package:finniu/domain/entities/dead_line.dart';
import 'package:finniu/domain/entities/fund_entity.dart';
import 'package:finniu/domain/entities/re_investment_entity.dart';
import 'package:finniu/domain/entities/user_bank_account_entity.dart';
import 'package:finniu/infrastructure/datasources/contract_datasource_imp.dart';
import 'package:finniu/infrastructure/models/calculate_investment.dart';
import 'package:finniu/infrastructure/models/fund/corporate_investment_models.dart';
import 'package:finniu/infrastructure/models/pre_investment_form.dart';
import 'package:finniu/infrastructure/models/re_investment/input_models.dart';
import 'package:finniu/infrastructure/models/re_investment/responde_models.dart';
import 'package:finniu/presentation/providers/calculate_investment_provider.dart';
import 'package:finniu/presentation/providers/dead_line_provider.dart';
import 'package:finniu/presentation/providers/event_tracker_provider.dart';
import 'package:finniu/presentation/providers/funds_provider.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/pre_investment_provider.dart';
import 'package:finniu/presentation/providers/re_investment_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/investment_simulation.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/verify_identity.dart';
import 'package:finniu/presentation/screens/investment_confirmation/utils.dart';
import 'package:finniu/presentation/screens/investment_confirmation/widgets/accept_tems.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widgets/buttons.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widgets/header.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widgets/modals.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widgets/scafold.dart';
import 'package:finniu/presentation/screens/reinvest_process/widgets/modal_widgets.dart';
import 'package:finniu/widgets/analytics.dart';
import 'package:finniu/widgets/custom_select_button.dart';
import 'package:finniu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:auto_size_text/auto_size_text.dart';

String formatDeadLine(String? deadLine) {
  //if  deadline doesn;t ends with the worc "meses" we add it
  if (deadLine != null) {
    if (deadLine.endsWith('meses')) {
      return deadLine;
    } else {
      return '$deadLine meses';
    }
  } else {
    return '';
  }
}

class InvestmentProcessStep1Screen extends ConsumerWidget {
  final FundEntity fund;
  final int? amount;
  final String? deadLine;
  final String? currency;
  final bool? isReInvestment;
  final String? reInvestmentType;
  final String? preInvestmentUUID; //USED FOR REINVESTMENT
  final int? originInvestmentRentability;
  const InvestmentProcessStep1Screen({
    super.key,
    required this.fund,
    this.amount,
    this.deadLine,
    this.currency,
    this.isReInvestment,
    this.reInvestmentType,
    this.preInvestmentUUID,
    this.originInvestmentRentability,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    bool isSoles;

    if (currency == null || currency == '') {
      isSoles = ref.watch(isSolesStateProvider);
    } else {
      isSoles = currency == 'nuevo sol' ? true : false;
    }
    return AnalyticsAwareWidget(
      screenName: 'Enterprise Step 1 Investment Screen',
      child: CustomLoaderOverlay(
        child: ScaffoldInvestment(
          isDarkMode: currentTheme.isDarkMode,
          backgroundColor: currentTheme.isDarkMode
              ? Color(
                  fund.getHexDetailColorDark(),
                )
              : Color(fund.getHexDetailColorLight()),
          body: Step1Body(
            fund: fund,
            isDarkMode: currentTheme.isDarkMode,
            amount: amount,
            deadLine: deadLine,
            isReInvestment: isReInvestment,
            reInvestmentType: reInvestmentType,
            preInvestmentUUID: preInvestmentUUID,
            isSoles: isSoles,
            originInvestmentRentability: originInvestmentRentability,
          ),
        ),
      ),
    );
  }
}

class Step1Body extends HookConsumerWidget {
  final FundEntity fund;
  final bool isDarkMode;
  final int? amount;
  final String? deadLine;
  final bool? isReInvestment;
  final String? reInvestmentType;
  final String? preInvestmentUUID;
  final bool isSoles;
  final int? originInvestmentRentability;
  const Step1Body({
    super.key,
    required this.fund,
    required this.isDarkMode,
    this.amount,
    this.deadLine,
    this.isReInvestment,
    this.reInvestmentType,
    this.preInvestmentUUID,
    this.originInvestmentRentability,
    required this.isSoles,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    final amountController =
        useTextEditingController(text: amount == null ? '' : amount.toString());
    final additionalAmountController = useTextEditingController(text: '0');

    final couponController = useTextEditingController();
    final deadLineController =
        useTextEditingController(text: formatDeadLine(deadLine));
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
                  containerColor: isDarkMode
                      ? fund.getHexDetailColorSecondaryDark()
                      : fund.getHexDetailColorSecondaryLight(),
                  textColor: aboutTextBusinessColor,
                  iconColor: isDarkMode
                      ? fund.getHexDetailColorSecondaryDark()
                      : fund.getHexDetailColorSecondaryLight(),
                  urlIcon: fund.iconUrl!,
                  labelText: isReInvestment == true ? 'Invierte' : 'Acerca de',
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  isReInvestment == true ? 'Tu operación en curso' : fund.name,
                  style: const TextStyle(
                    color: Color(primaryDark),
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (isReInvestment == true) ...[
                  ReinvestmentRentabilityCard(
                    rentability: originInvestmentRentability?.toDouble() ?? 0.0,
                    amount: amount?.toDouble() ?? 0.0,
                    isSoles: isSoles,
                    deadline: int.parse(deadLine ?? '0'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
                Text(
                  'Completa los siguientes datos',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: currentTheme.isDarkMode
                        ? const Color(whiteText)
                        : const Color(primaryDark),
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
                  additionalAmountController: additionalAmountController,
                  fund: fund,
                  isReInvestment: isReInvestment ?? false,
                  reInvestmentType: reInvestmentType,
                  preInvestmentUUID: preInvestmentUUID,
                  isSoles: isSoles,
                  reinvestmentOriginAmount: amount,
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
  final TextEditingController additionalAmountController;
  final TextEditingController couponController;
  final TextEditingController deadLineController;
  // final TextEditingController bankController;
  final TextEditingController originFundsController;
  final TextEditingController otherFundOriginController;
  final FundEntity fund;
  final bool isReInvestment;
  final String? reInvestmentType;
  final String? preInvestmentUUID;
  final bool? isSoles;
  final int? reinvestmentOriginAmount;

  const FormStep1({
    super.key,
    required this.amountController,
    required this.couponController,
    required this.deadLineController,
    required this.originFundsController,
    required this.otherFundOriginController,
    required this.additionalAmountController,
    required this.fund,
    required this.isReInvestment,
    this.reInvestmentType,
    this.preInvestmentUUID,
    this.reinvestmentOriginAmount,
    this.isSoles,
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

  Future<void> _savePreInvestment(
    BuildContext context,
    WidgetRef ref,
    SaveCorporateInvestmentInput input,
  ) async {
    Navigator.pop(context);
    context.loaderOverlay.show();
    final response =
        await ref.read(saveCorporateInvestmentFutureProvider(input).future);

    if (!response.success) {
      context.loaderOverlay.hide();
      showSnackBarV2(
        context: context,
        title: "Error interno",
        message: response.messages?[0].message ??
            'Hubo un problema, asegúrate de haber completado todos los campos',
        snackType: SnackType.error,
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

  //save ReInvestment
  Future<void> _saveReInvestment(
    BuildContext context,
    WidgetRef ref,
    CreateReInvestmentParams input,
  ) async {
    Navigator.pop(context);
    context.loaderOverlay.show();
    final CreateReInvestmentResponse response =
        await ref.read(createReInvestmentProvider(input).future);
    if (response.success == false) {
      context.loaderOverlay.hide();
      showSnackBarV2(
        context: context,
        title: "Error interno",
        message: response.messages?[0].message ??
            'Hubo un problema, asegúrate de haber completado todos los campos',
        snackType: SnackType.error,
      );

      return;
    }

    context.loaderOverlay.hide();
    if (widget.reInvestmentType == typeReinvestmentEnum.CAPITAL_ADITIONAL) {
      Navigator.pushNamed(
        context,
        '/v2/investment/step-2',
        arguments: {
          'fund': widget.fund,
          'preInvestmentUUID': response.reInvestmentUuid,
          'amount':
              (int.parse(input.finalAmount) - widget.reinvestmentOriginAmount!)
                  .toString(),
          'isReInvestment': true,
        },
      );
    } else {
      showThanksForInvestingModal(
        context,
        () {
          Navigator.pushReplacementNamed(
            context,
            '/v2/investment',
          );
        },
        true,
      );
    }
  }

  bool validateForm() {
    if (widget.amountController.text.isEmpty ||
        widget.deadLineController.text.isEmpty ||
        // widget.bankController.text.isEmpty ||
        widget.originFundsController.text.isEmpty) {
      showSnackBarV2(
        context: context,
        title: "Error al completar datos",
        message:
            'Hubo un problema, asegúrate de haber completado los campos anteriores',
        snackType: SnackType.warning,
      );

      return false;
    }

    //validate amount mayor than 1000
    if (double.parse(widget.amountController.text) < 1000) {
      showSnackBarV2(
        context: context,
        title: "Error al completar el monto",
        message:
            "El monto ingresado debe ser mayor a ${widget.isSoles! ? 'S/.' : '\$/'}1 000",
        snackType: SnackType.warning,
      );

      return false;
    }

    if (widget.originFundsController.text == 'Otros' &&
        widget.otherFundOriginController.text.isEmpty) {
      showSnackBarV2(
        context: context,
        title: "Error al completar origen de  fondos",
        message: 'Debe de ingresar el origen de los fondos',
        snackType: SnackType.warning,
      );

      return false;
    }

    return true;
  }

  bool validateReinvestmentForm(
    bool userAcceptedTerms,
    CreateReInvestmentParams reinvestmentParams,
    BankAccount? receiverBankAccount,
    String? aditionalAmount,
  ) {
    if (reinvestmentParams.typeReinvestment ==
        typeReinvestmentEnum.CAPITAL_ONLY) {
      if (!userAcceptedTerms) {
        showSnackBarV2(
          context: context,
          title: "Error al aceptar el contrato",
          message: 'Debe de leer y aceptar el contrato',
          snackType: SnackType.warning,
        );

        return false;
      }
      if (receiverBankAccount == null) {
        showSnackBarV2(
          context: context,
          title: "Error cuenta de destino",
          message: 'Debe de seleccionar una cuenta de destino',
          snackType: SnackType.warning,
        );

        return false;
      }
    }
    if (reinvestmentParams.typeReinvestment ==
        typeReinvestmentEnum.CAPITAL_ADITIONAL) {
      if (aditionalAmount == '' || aditionalAmount == '0') {
        showSnackBarV2(
          context: context,
          title: "Error al completar el monto",
          message: 'Debe de ingresar un monto',
          snackType: SnackType.warning,
        );

        return false;
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final deadLineFuture = ref.watch(deadLineFutureProvider.future);
    final isSoles = ref.watch(isSolesStateProvider);
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final userProfile = ref.watch(userProfileNotifierProvider);
    final debouncer = Debouncer(milliseconds: 3000);
    final finalReinvestmentAmount =
        useState(widget.reinvestmentOriginAmount ?? 0);
    final userReadContract = useState(false);
    final trackerService = ref.watch(eventTrackerServiceProvider);
    bool userAcceptedTerms = ref.watch(userAcceptedTermsProvider);
    ValueNotifier<BankAccount?> receiverBankAccountState = useState(null);
    CreateReInvestmentParams? reinvestmentParams;

    useEffect(
      () {
        if (userProfile.completeToInvestData() < 1.0) {
          showVerifyIdentity(context);
        }

        return null;
      },
      [userProfile],
    );
    //on init change the userAcceptedTermsProvider provider to false
    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          ref.read(userAcceptedTermsProvider.notifier).state = false;
        });
        return null;
      },
      [],
    );

    ref.listen<BankAccount?>(selectedBankAccountReceiverProvider,
        (previous, next) {
      receiverBankAccountState.value = next;
    });
    return Center(
      child: Column(
        children: [
          if (widget.isReInvestment == false) ...[
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
                  hintText: 'Escriba su monto de inversión',
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
          ],
          if (widget.isReInvestment == true) ...[
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              constraints: const BoxConstraints(
                minWidth: 263,
                maxWidth: 400,
                maxHeight: 45,
                minHeight: 45,
              ),
              child: TextFormField(
                controller: widget.additionalAmountController,
                enabled:
                    widget.reInvestmentType == typeReinvestmentEnum.CAPITAL_ONLY
                        ? false
                        : true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Este dato es requerido';
                  }
                  return null;
                },
                onChanged: (value) {
                  debouncer.run(() {
                    finalReinvestmentAmount.value =
                        int.parse(widget.additionalAmountController.text) +
                            (widget.reinvestmentOriginAmount ?? 0);
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Ingresa tu monto adicional',
                  hintStyle: TextStyle(color: Color(grayText), fontSize: 11),
                  label: Text("Monto adicional"),
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
            FinalAmountWidget(
              amount: finalReinvestmentAmount.value.toDouble(),
              isSoles: isSoles,
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
              enabledFillColor: isDarkMode
                  ? Color(widget.fund.getHexDetailColorDark())
                  : Color(widget.fund.getHexDetailColorLight()),
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
              enabledFillColor: isDarkMode
                  ? Color(widget.fund.getHexDetailColorDark())
                  : Color(widget.fund.getHexDetailColorLight()),
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
                suffixIcon: ElevatedButton(
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
                    if (widget.amountController.text.isEmpty ||
                        widget.deadLineController.text.isEmpty) {
                      showSnackBarV2(
                        context: context,
                        title: "Error al aplicar cupón",
                        message:
                            'Debes ingresar el monto y el plazo para aplicar el cupón',
                        snackType: SnackType.warning,
                      );

                      return;
                    }
                    if (widget.couponController.text.isEmpty) {
                      showSnackBarV2(
                        context: context,
                        title: "Error al aplicar cupón",
                        message: 'Debes ingresar el cupón',
                        snackType: SnackType.warning,
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
                      showSnackBarV2(
                        context: context,
                        title: "Cupón aplicado",
                        message: 'Cupón aplicado correctamente',
                        snackType: SnackType.success,
                      );
                    } else {
                      widget.couponController.clear();
                      showSnackBarV2(
                        context: context,
                        title: "Error al aplicar cupón",
                        message: resultCalculator?.error ??
                            'Hubo un problema, intenta nuevamente',
                        snackType: SnackType.error,
                      );
                    }
                  },
                ),
                hintText: 'Ingresa tu código(opcional)',
                hintStyle:
                    const TextStyle(color: Color(grayText), fontSize: 11),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                ),
                label: const Text(
                  "Ingresa tu código promocional",
                ),
              ),
            ),
          ),
          if (widget.isReInvestment &&
              widget.reInvestmentType == typeReinvestmentEnum.CAPITAL_ONLY) ...[
            const SizedBox(
              height: 15,
            ),
            SelectBankAccountButtonWidget(
              isDarkMode: isDarkMode,
              onPressed: () {
                showBankAccountModal(
                  context,
                  ref,
                  isSoles ? CurrencyEnum.PEN : CurrencyEnum.USD,
                  false,
                  "",
                );
              },
              textButton: receiverBankAccountState.value == null
                  ? 'A qué banco te depositamos'
                  : receiverBankAccountState.value!.bankAccount,
              svgPath: 'assets/svg_icons/card-receive.svg',
              backgroundColor: isDarkMode
                  ? Color(widget.fund.getHexDetailColorSecondaryDark())
                  : Color(widget.fund.getHexDetailColorSecondaryLight()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 25,
                  child: AcceptedTermCheckBox(),
                ),
                Text(
                  'He leido y acepto el ',
                  style: TextStyle(
                    fontSize: 10,
                    color: isDarkMode
                        ? const Color(whiteText)
                        : const Color(blackText),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    String contractURL =
                        await ContractDataSourceImp().getContract(
                      uuid: widget.preInvestmentUUID!,
                      client: ref.watch(gqlClientProvider).value!,
                    );

                    if (contractURL.isNotEmpty) {
                      userReadContract.value = true;

                      Navigator.pushNamed(
                        context,
                        '/contract_view',
                        arguments: {
                          'contractURL': contractURL,
                        },
                      );
                    }
                  },
                  child: Text(
                    ' Contrato de Inversión de Finniu ',
                    style: TextStyle(
                      color: isDarkMode
                          ? const Color(primaryLight)
                          : const Color(primaryDark),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
          if (showInvestmentBoxes) ...[
            const SizedBox(
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
                          isSoles
                              ? formatterSoles.format(profitability)
                              : formatterUSD.format(profitability),
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
              height: 30,
            ),
          ],
          SizedBox(
            width: 224,
            height: 50,
            child: TextButton(
              onPressed: () async {
                await trackerService
                    .logButtonClick('step-1-enterprise-continue-button');
                String amount = widget.amountController.text;
                if (widget.isReInvestment == true &&
                    widget.reInvestmentType ==
                        typeReinvestmentEnum.CAPITAL_ADITIONAL) {
                  final originAmount = widget.reinvestmentOriginAmount;
                  final additionalAmount =
                      widget.additionalAmountController.text;
                  amount = '${originAmount! + int.parse(additionalAmount)}';
                } else if (widget.isReInvestment == true &&
                    widget.reInvestmentType ==
                        typeReinvestmentEnum.CAPITAL_ONLY) {
                  amount = widget.reinvestmentOriginAmount.toString();
                }

                if (userProfile.completeToInvestData() < 1.0) {
                  showVerifyIdentity(context);
                  return;
                }
                if (validateForm() == false) {
                  return;
                }
                if (widget.isReInvestment == true) {
                  final deadLineUuid = DeadLineEntity.getUuidByName(
                    widget.deadLineController.text,
                    await deadLineFuture,
                  );
                  reinvestmentParams = CreateReInvestmentParams(
                    preInvestmentUUID: widget.preInvestmentUUID!,
                    finalAmount: amount,
                    deadlineUUID: deadLineUuid,
                    currency: isSoles ? currencyEnum.PEN : currencyEnum.USD,
                    coupon: widget.couponController.text,
                    originFounds: OriginFunds(
                      originFundsEnum: OriginFoundsUtil.fromReadableName(
                        widget.originFundsController.text,
                      ),
                      otherText: widget.otherFundOriginController.text,
                    ),
                    typeReinvestment: widget.reInvestmentType!,
                  );
                  bool isValidReinvestment = validateReinvestmentForm(
                    userAcceptedTerms,
                    reinvestmentParams!,
                    receiverBankAccountState.value,
                    widget.additionalAmountController.text,
                  );
                  if (isValidReinvestment == false) {
                    return;
                  }
                }
                investmentSimulationModal(
                  context,
                  startingAmount: int.parse(amount),
                  finalAmount: int.parse(widget.amountController.text),
                  // startingAmount: int.parse(widget.amountController.text),
                  // finalAmount: int.parse(amount),
                  mouthInvestment:
                      int.parse(widget.deadLineController.text.split(' ')[0]),
                  coupon: widget.couponController.text,
                  toInvestPressed: () async {
                    if (widget.isReInvestment == true) {
                      _saveReInvestment(
                        context,
                        ref,
                        reinvestmentParams!,
                      );
                    } else {
                      _savePreInvestment(
                        context,
                        ref,
                        SaveCorporateInvestmentInput(
                          amount: amount,
                          months: widget.deadLineController.text.split(' ')[0],
                          coupon: widget.couponController.text,
                          currency: isSoles ? currencyNuevoSol : currencyDollar,
                          originFunds: OriginFunds(
                            originFundsEnum: OriginFoundsUtil.fromReadableName(
                              widget.originFundsController.text,
                            ),
                            otherText: widget.otherFundOriginController.text,
                          ),
                          fundUUID: widget.fund.uuid,
                        ),
                      );
                    }
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

class ReinvestmentRentabilityCard extends HookConsumerWidget {
  const ReinvestmentRentabilityCard({
    super.key,
    required this.rentability,
    required this.amount,
    required this.isSoles,
    required this.deadline,
  });

  final double rentability;
  final double amount;
  final bool isSoles;
  final int deadline;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final Color backgroundColor =
        isDarkMode ? const Color(0xff08273F) : const Color(0xffF2FCFF);
    final Color verticalLineColor =
        isDarkMode ? const Color(0xff0D3A5C) : const Color(0xffA8DFEF);
    final Color rentabilityBackgroundColor =
        isDarkMode ? const Color(0xffB4EEFF) : const Color(0xffB4EEFF);

    return Center(
      child: Container(
        width: 297,
        height: 65,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backgroundColor,
        ),
        child: Row(
          children: [
            Container(
              height: double.infinity,
              width: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: verticalLineColor,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        isDarkMode
                            ? const Color(whiteText)
                            : const Color(primaryDark),
                        BlendMode.srcIn,
                      ),
                      child: Image.asset(
                        'assets/investment/dollar-circle.png',
                        height: 14,
                        width: 14,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      isSoles
                          ? formatterSoles.format(amount)
                          : formatterUSD.format(amount),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode
                            ? const Color(whiteText)
                            : const Color(primaryDark),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Capital a reinvertir',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    color: isDarkMode
                        ? const Color(whiteText)
                        : const Color(blackText),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 30,
                  decoration: BoxDecoration(
                    color: rentabilityBackgroundColor,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          isDarkMode
                              ? const Color(primaryLight)
                              : const Color(primaryDark),
                          BlendMode.srcIn,
                        ),
                        child: Image.asset(
                          'assets/icons/double_dollar.png',
                          height: 20,
                          width: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        '$rentability% x $deadline meses',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(primaryDark),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FinalAmountWidget extends HookConsumerWidget {
  final double amount;
  final bool isSoles;

  const FinalAmountWidget({
    super.key,
    required this.amount,
    required this.isSoles,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const activeTextColor = Color(primaryDark);
    const backgroundColor = Color(0xFFC7F3FF);

    return Container(
      width: 300,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
              BlendMode.srcIn,
            ),
            child: Image.asset(
              'assets/investment/dollar-circle.png',
              height: 14,
              width: 14,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Monto final',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w800,
                    color: activeTextColor,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  '(Capital de la operación en curso + monto adicional)',
                  style: TextStyle(
                    fontSize: 7.0,
                    fontWeight: FontWeight.w600,
                    color: activeTextColor.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          AutoSizeText(
            isSoles
                ? formatterSoles.format(amount)
                : formatterUSD.format(amount),
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w800,
              color: activeTextColor,
            ),
            maxLines: 1,
            minFontSize: 8,
          ),
        ],
      ),
    );
  }
}

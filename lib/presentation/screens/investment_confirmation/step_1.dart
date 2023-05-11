import 'package:finniu/constants/colors.dart';
import 'package:finniu/domain/entities/bank_entity.dart';
import 'package:finniu/domain/entities/calculate_investment.dart';
import 'package:finniu/domain/entities/dead_line.dart';
import 'package:finniu/domain/entities/plan_entities.dart';
import 'package:finniu/domain/entities/pre_investment.dart';
import 'package:finniu/infrastructure/models/pre_investment_form.dart';
import 'package:finniu/presentation/providers/bank_provider.dart';
import 'package:finniu/presentation/providers/calculate_investment_provider.dart';
import 'package:finniu/presentation/providers/dead_line_provider.dart';
import 'package:finniu/presentation/providers/plan_provider.dart';
import 'package:finniu/presentation/providers/pre_investment_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/investment_confirmation/step_2.dart';
import 'package:finniu/widgets/custom_select_button.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:finniu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../infrastructure/models/calculate_investment.dart';

class Step1 extends HookConsumerWidget {
  // String planUuid;
  const Step1({
    super.key,
    // required this.planUuid,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    final mountController = useTextEditingController();
    final couponController = useTextEditingController();
    final deadLineController = useTextEditingController();
    final bankController = useTextEditingController();
    final bankNumberController = useTextEditingController();
    print(ModalRoute.of(context)!.settings.arguments);
    final uuidPlan = (ModalRoute.of(context)!.settings.arguments
        as Map<String, dynamic>)['planUuid'];
    print(uuidPlan);

    return CustomLoaderOverlay(
      child: CustomScaffoldReturnLogo(body: HookBuilder(
        builder: (context) {
          final planList = ref.watch(planListFutureProvider);
          return planList.when(
            data: (plans) {
              return Step1Body(
                currentTheme: currentTheme,
                mountController: mountController,
                deadLineController: deadLineController,
                bankTypeController: bankController,
                couponController: couponController,
                bankNumberController: bankNumberController,
                plan: plans.firstWhere((element) => element.uuid == uuidPlan),
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
      )
          // body: Step1Body(
          //   currentTheme: currentTheme,
          //   mountController: mountController,
          //   termController: termController,
          // ),
          ),
    );
  }
}

class Step1Body extends StatefulHookConsumerWidget {
  Step1Body({
    Key? key,
    required this.currentTheme,
    required this.mountController,
    required this.deadLineController,
    required this.bankTypeController,
    required this.couponController,
    required this.bankNumberController,
    required this.plan,
  }) : super(key: key);

  final SettingsProviderState currentTheme;
  final TextEditingController mountController;
  final TextEditingController deadLineController;
  final TextEditingController bankTypeController;
  final TextEditingController bankNumberController;
  final TextEditingController couponController;

  PlanEntity plan;
  double? profitability;
  bool showInvestmentBoxes = false;
  PlanSimulation? resultCalculator;

  @override
  _Step1BodyState createState() => _Step1BodyState();
}

class _Step1BodyState extends ConsumerState<Step1Body> {
  late Future deadLineFuture;
  late Future bankFuture;

  // @override
  // void initState() {
  //   super.initState();
  //   deadLineFuture = context.read(deadLineFutureProvider.future);
  //   bankFuture = context.read(bankFutureProvider.future);
  // }

  @override
  Widget build(BuildContext context) {
    final deadLineFuture = ref.watch(deadLineFutureProvider.future);
    final bankFuture = ref.watch(bankFutureProvider.future);
    final themProvider = ref.watch(settingsNotifierProvider);

    return SingleChildScrollView(
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
                // width: MediaQuery.of(context).size.width * 0.9,
                // height: 90,
                // padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
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
                  width: 100,
                  height: 100,
                  color: Colors.transparent,
                  child: const SizedBox(
                    width: 80,
                    height: 90,
                    child: Image(
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
                      widget.plan.name,
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
                        Image(
                          image: AssetImage('assets/icons/dollar.png'),
                          width: 12,
                          height: 12,
                          color: Color(
                            primaryDark,
                          ),
                        ),
                        Text(
                          'Desde S/. ${widget.plan.minAmount.toString()}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
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
                        Image(
                          image: AssetImage('assets/icons/double_dollar.png'),
                          width: 21, // ancho deseado de la imagen
                          height: 21, // alto deseado de la imagen
                          color: Color(
                            primaryDark,
                          ), // color de la imagen si es necesario
                        ),
                        Text(
                          '${widget.plan.twelveMonthsReturn.toString()}% anual',
                          // plan.twelveMonthsReturn.toString(),
                          textAlign: TextAlign.left,
                          style: TextStyle(
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
              color: widget.currentTheme.isDarkMode
                  ? const Color(whiteText)
                  : const Color(primaryDark),
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            constraints: const BoxConstraints(minWidth: 263, maxWidth: 400),
            child: TextFormField(
              controller: widget.mountController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Este dato es requerido';
                }
                return null;
              },
              onChanged: (value) {
                // nickNameController.text = value.toString();
              },
              decoration: const InputDecoration(
                hintText: 'Escriba su monto de inversion',
                hintStyle: TextStyle(color: Color(grayText), fontSize: 11),
                label: Text("Monto"),
              ),
            ),
          ),
          const SizedBox(height: 15),
          CustomSelectButton(
            asyncItems: (String filter) async {
              final response = await deadLineFuture;
              return response.map((e) => e.name).toList();
            },
            callbackOnChange: (value) async {
              widget.deadLineController.text = value;
              context.loaderOverlay.show();
              final inputCalculator = CalculatorInput(
                amount: int.parse(widget.mountController.text),
                months: int.parse(widget.deadLineController.text.split(' ')[0]),
                coupon: widget.couponController.text,
              );

              final resultCalculator = await ref.watch(
                calculateInvestmentFutureProvider(
                  inputCalculator,
                ).future,
              );

              setState(() {
                if (resultCalculator!.plan != null) {
                  widget.plan = resultCalculator!.plan!;
                  widget.profitability = resultCalculator!.profitability;
                  widget.showInvestmentBoxes = true;
                  widget.resultCalculator = resultCalculator;
                }
              });
              print('results Provider!!');
              print(resultCalculator);

              context.loaderOverlay.hide();
            },
            textEditingController: widget.deadLineController,
            labelText: "Plazo",
            hintText: "Seleccione su plazo de inversión",
            width: MediaQuery.of(context).size.width * 0.8,
          ),
          const SizedBox(
            height: 15,
          ),
          CustomSelectButton(
            textEditingController: widget.bankTypeController,
            asyncItems: (String filter) async {
              final response = await bankFuture;
              return response.map((e) => e.name).toList();
            },
            callbackOnChange: (value) {
              widget.bankTypeController.text = value;
            },
            labelText: "Desde que banco realizas la transferencia",
            hintText: "Seleccione su banco",
            width: MediaQuery.of(context).size.width * 0.8,
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            constraints: const BoxConstraints(minWidth: 263, maxWidth: 400),
            child: TextFormField(
              controller: widget.bankNumberController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Este dato es requerido';
                }
                return null;
              },
              onChanged: (value) {
                // nickNameController.text = value.toString();
              },
              decoration: const InputDecoration(
                hintText: 'Escriba su número de cuenta',
                hintStyle: TextStyle(color: Color(grayText), fontSize: 11),
                label: Text("Número de cuenta"),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            constraints: const BoxConstraints(
                minWidth: 263, maxWidth: 400, maxHeight: 39, minHeight: 39),
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
                      primary: Color(primaryLight),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.only(
                        topRight: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      )),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Aplicarlo",
                        style: TextStyle(
                          color: Color(primaryDark),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      context.loaderOverlay.show();
                      final inputCalculator = CalculatorInput(
                        amount: int.parse(widget.mountController.text),
                        months: int.parse(
                          widget.deadLineController.text.split(' ')[0],
                        ),
                        coupon: widget.couponController.text,
                      );

                      final resultCalculator = await ref.watch(
                        calculateInvestmentFutureProvider(
                          inputCalculator,
                        ).future,
                      );

                      setState(() {
                        if (resultCalculator!.plan != null) {
                          widget.plan = resultCalculator!.plan!;
                          widget.profitability =
                              resultCalculator!.profitability;
                          widget.showInvestmentBoxes = true;
                          widget.resultCalculator = resultCalculator;
                        }
                      });
                      print('results Provider!!');
                      print(resultCalculator);

                      context.loaderOverlay.hide();
                    },
                  ),
                ),
                hintText: 'Ingresa tu codigo',
                hintStyle: TextStyle(color: Color(grayText), fontSize: 11),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                ),
                label: Text("Ingresa tu codigo promocional,si tienes uno"),
              ),
            ),
          ),
          if (widget.showInvestmentBoxes) ...[
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
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${widget.plan.sixMonthsReturn}%',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(primaryDark),
                          ),
                        ),
                        Text(
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
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'S/${widget.profitability}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(primaryDark),
                          ),
                        ),
                        Text(
                          'En 6 meses tendrias',
                          textAlign: TextAlign.right,
                          style: TextStyle(
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
          SizedBox(
            width: 224,
            height: 50,
            child: TextButton(
              onPressed: () async {
                final deadLineUuid = DeadLineEntity.getUuidByName(
                    widget.deadLineController.text, await deadLineFuture);
                print('dead line uuid');
                print(deadLineUuid);
                final bankUuid = BankEntity.getUuidByName(
                    widget.bankTypeController.text, await bankFuture);
                print('bank uuid');
                print(bankUuid);
                final preInvestment = PreInvestmentForm(
                  amount: int.parse(widget.mountController.text),
                  deadLineUuid: deadLineUuid,
                  coupon: widget.couponController.text,
                  planUuid: widget.plan.uuid,
                  bankAccountTypeUuid: bankUuid,
                  bankAccountNumber: widget.bankNumberController.text,
                );

                final preInvestmentEntity = await ref
                    .watch(preInvestmentSaveProvider(preInvestment).future);
                print('pre investment entity');
                print(widget.resultCalculator);
                Navigator.pushNamed(
                  context,
                  '/investment_step2',
                  arguments: PreInvestmentStep2Arguments(
                    plan: widget.plan,
                    preInvestment: preInvestmentEntity,
                    resultCalculator: widget.resultCalculator!,
                  ),
                );
              },
              style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(2),
                shadowColor: MaterialStateProperty.all<Color>(Colors.grey),
              ),
              child: const Text(
                'Continuar',
              ),
            ),
          )
        ],
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
    final Color activeBackgroundColor = currentTheme.isDarkMode
        ? const Color(secondary)
        : const Color(primaryLight);
    final Color inactiveBackgroundColor =
        currentTheme.isDarkMode ? Colors.transparent : Colors.transparent;

    final Color inactiveBorderColor = currentTheme.isDarkMode
        ? const Color(primaryLight)
        : const Color(primaryDark);
    final Color activeBorderColor = Colors.transparent;
    final Color activeIconColor = currentTheme.isDarkMode
        ? const Color(primaryDark)
        : const Color(primaryDark);
    final Color inactiveIconColor = currentTheme.isDarkMode
        ? const Color(primaryLight)
        : const Color(primaryDark);

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
                color: widget.step == 1
                    ? activeBackgroundColor
                    : inactiveBackgroundColor,
                border: Border.all(
                  color: widget.step == 1
                      ? activeBorderColor
                      : inactiveBorderColor,
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
                    color: currentTheme.isDarkMode
                        ? const Color(primaryLight)
                        : const Color(primaryDark),
                    thickness: 1,
                  ),
                ],
              ),
            ),
            Container(
              height: 40,
              width: 55,
              decoration: BoxDecoration(
                color: widget.step == 2
                    ? activeBackgroundColor
                    : inactiveBackgroundColor,
                border: Border.all(
                  color: widget.step == 2
                      ? activeBorderColor
                      : inactiveBorderColor,
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
                    color: currentTheme.isDarkMode
                        ? const Color(primaryLight)
                        : const Color(primaryDark),
                    thickness: 1,
                  ),
                ],
              ),
            ),
            Container(
              height: 40,
              width: 55,
              decoration: BoxDecoration(
                color: widget.step == 3
                    ? activeBackgroundColor
                    : inactiveBackgroundColor,
                border: Border.all(
                  color: widget.step == 3
                      ? activeBorderColor
                      : inactiveBorderColor,
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

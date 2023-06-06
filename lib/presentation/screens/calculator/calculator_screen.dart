import 'package:dropdown_search/dropdown_search.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/domain/entities/calculate_investment.dart';
import 'package:finniu/infrastructure/models/calculate_investment.dart';
import 'package:finniu/presentation/providers/calculate_investment_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/calculator/result_calculator_screen.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Calculator extends StatefulHookConsumerWidget {
  const Calculator({super.key});

  @override
  ConsumerState<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends ConsumerState<Calculator> {
  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    final monthsController = useTextEditingController();
    final amountController = useTextEditingController();
    // PlanSimulation? planSimulation;

    List<Color> dayColors = [
      const Color(gradient_primary),
      const Color(gradient_secondary)
    ];
    List<Color> nightColors = [
      const Color(primaryDark),
      const Color(primaryDark),
      const Color(primaryDark),
    ];

    return CustomScaffoldReturnDirect(
      body: Container(
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: currentTheme.isDarkMode ? nightColors : dayColors)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  child: Image.asset(
                    'assets/images/logo_small.png',
                    width: 70,
                    height: 70,
                    color: currentTheme.isDarkMode
                        ? const Color(whiteText)
                        : const Color(blackText),
                  ),
                ),
              ),
              SizedBox(
                child: Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      textAlign: TextAlign.center,
                      'Simula tu inversión de manera rápida y sencilla',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: currentTheme.isDarkMode
                            ? const Color(primaryLight)
                            : const Color(primaryDark),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 190,
                constraints: const BoxConstraints(
                  maxWidth: 450,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      child: Image.asset(
                        alignment: Alignment.center,
                        'assets/images/money.png',
                        width: 141,
                        height: 143,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 10,
                      child: SizedBox(
                        child: Image.asset(
                          alignment: Alignment.center,
                          'assets/images/arm.png',
                          width: 202,
                          height: 164,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 224,
                // height: 38,
                child: TextFormField(
                  key: const Key('monto'),
                  controller: amountController,
                  onChanged: (value) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Este dato es requerido';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Ingrese su monto de inversion',
                    hintStyle: TextStyle(
                      fontSize: 10,
                      color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(grayText1),
                    ),
                    suffixIconConstraints: const BoxConstraints(
                      maxHeight: 38,
                      minWidth: 38,
                    ),
                    label: const Text(
                      "Monto",
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  '',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.5,
                    color: currentTheme.isDarkMode
                        ? const Color(whiteText)
                        : const Color(blackText),
                  ),
                ),
              ),
              CustomSelectButton(
                textEditingController: monthsController,
                items: const ['6 meses', '12 meses'],
                labelText: "Plazo",
                hintText: 'Seleccione su plazo de inversion',
                callbackOnChange: (value) {
                  monthsController.text = value;
                },
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  '',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.5,
                    color: currentTheme.isDarkMode
                        ? const Color(whiteText)
                        : const Color(blackText),
                  ),
                ),
              ),
              // if (planSimulation != null) ...[
              //   Container(
              //     width: 224,
              //     height: 67,
              //     decoration: BoxDecoration(
              //       color: const Color(primaryLightAlternative),
              //       borderRadius: BorderRadius.circular(
              //         15.0,
              //       ), // Cambia el valor para ajustar el radio
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.all(10.0),
              //       child: Column(
              //         children: const [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     const SizedBox(width: 5),
              //     const Text(
              //       'Tu plan recomendado es',
              //       textAlign: TextAlign.center,
              //       style: TextStyle(
              //         fontSize: 12,
              //         color: Color(blackText),
              //       ),
              //     ),
              //     const SizedBox(
              //       width: 5,
              //     ),
              //     InkWell(
              //       onTap: () => showDialog<String>(
              //         barrierColor: Colors.transparent,
              //         context: context,
              //         builder: (BuildContext context) =>
              //             ConstrainedBox(
              //           constraints: const BoxConstraints(
              //             maxWidth: 100.0,
              //             maxHeight: 250.0,
              //           ),
              //           child: AlertDialog(
              //             backgroundColor: const Color(primaryDark),
              //             shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(15.0),
              //             ),
              //             content: SizedBox(
              //               height: 300,
              //               width: 350,
              //               child: Column(
              //                 children: [
              //                   Align(
              //                     alignment: Alignment.topRight,
              //                     child: IconButton(
              //                       alignment: Alignment.topRight,
              //                       icon: const Icon(Icons.close),
              //                       color: const Color(whiteText),
              //                       onPressed: () {
              //                         Navigator.of(context).pop();
              //                       },
              //                     ),
              //                   ),
              //                   Center(
              //                     child: Image.asset(
              //                       'assets/result/money.png',
              //                       width: 70,
              //                       height: 70,
              //                     ),
              //                   ),
              //                   Text(
              //                     planSimulation?.plan.name
              //                             .toUpperCase() ??
              //                         '',
              //                     textAlign: TextAlign.justify,
              //                     style: TextStyle(
              //                       fontSize: 16,
              //                       fontWeight: FontWeight.bold,
              //                       color: Color(primaryLight),
              //                       height: 1.5,
              //                     ),
              //                   ),
              //                   const SizedBox(
              //                     height: 10,
              //                   ),
              //                   const Padding(
              //                     padding: EdgeInsets.all(10.0),
              //                     child: Text(
              //                         textAlign: TextAlign.justify,
              //                         'Esta inversion prioriza la estabilidad generando una rentabilidad moderada.Si recien empiezas a invertir, este plan es perfecto para ti.',
              //                         style: TextStyle(
              //                           fontSize: 12,
              //                           color: Color(whiteText),
              //                           height: 1.5,
              //                         )),
              //                   )
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //       child: const ImageIcon(
              //         AssetImage('assets/icons/questions.png'),
              //         color: Color(primaryDark),
              //       ),
              //     ),
              //   ],
              // ),
              //           Text(
              //             'Plan Origen',
              //             textAlign: TextAlign.center,
              //             style: TextStyle(
              //               fontSize: 12,
              //               fontWeight: FontWeight.bold,
              //               color: Color(primaryDark),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ],
              // SizedBox(
              //   width: 200,
              //   child: Text(
              //     '*Recuerda que puedes retirar tus intereses desde el 1er mes',
              //     textAlign: TextAlign.justify,
              //     style: TextStyle(
              //       fontSize: 10,
              //       color: currentTheme.isDarkMode
              //           ? const Color(whiteText)
              //           : const Color(blackText),
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 30,
              // ),
              Container(
                width: 224,
                height: 50,
                margin: const EdgeInsets.only(top: 10),
                child: TextButton(
                  onPressed: () async {
                    // planSimulation = await ref
                    //     .read(calculateInvestmentFutureProvider.future);
                    print('amountController.text: ${amountController.text}');
                    print('monthsController.text: ${monthsController.text}');

                    Navigator.pushNamed(
                      context,
                      '/calculator_result',
                      arguments: CalculatorInput(
                        amount: int.parse(amountController.text),
                        months: int.parse(monthsController.text.split(' ')[0]),
                      ),
                    );
                    setState(() {});
                  },
                  child: const Text(
                    'Continuar',
                  ),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(
                        4), // Altura de la sombra

                    shadowColor: MaterialStateProperty.all<Color>(Colors.grey),

                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              )
            ],
          ),
        ),
      ),
    );
  }
}

// void _calculatePercentage(String s) {}

class CustomSelectButton extends HookConsumerWidget {
  final TextEditingController textEditingController;
  final callbackOnChange;
  final List<String>? items;
  final Future<List<String>> Function(String)? asyncItems;
  final String labelText;
  final String? hintText;
  final String? identifier;
  final bool? enabled;
  double? width = 224;
  double? height = 39;
  CustomSelectButton({
    super.key,
    required this.textEditingController,
    this.items,
    this.callbackOnChange,
    required this.labelText,
    this.hintText,
    this.asyncItems,
    this.identifier,
    this.width = 224,
    this.height = 39,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const disabledColor = 0xffF4F4F4;
    // required this.currentStep,
    if (items == null && asyncItems == null) {
      throw ArgumentError("At least one of item and async must be provided.");
    }
    final themeProvider = ref.watch(settingsNotifierProvider);
    return SizedBox(
      width: width,
      height: height,
      child: DropdownSearch<String>(
        enabled: enabled ?? false,
        selectedItem: textEditingController.text,
        key: Key(identifier ?? ''),
        onChanged: (value) => callbackOnChange(value),
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
          ),
        ),
        items: items ?? [],
        asyncItems: asyncItems,
        popupProps: PopupProps.menu(
          showSelectedItems: true,
          itemBuilder: (context, item, isSelected) => Container(
            decoration: BoxDecoration(
              color: Color(
                isSelected
                    ? (themeProvider.isDarkMode
                        ? primaryLight
                        : primaryDarkAlternative)
                    : (themeProvider.isDarkMode
                        ? primaryDarkAlternative
                        : primaryLight),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              border: Border.all(
                width: 2,
                color: themeProvider.isDarkMode
                    ? const Color(primaryDarkAlternative)
                    : const Color(
                        primaryLight,
                      ), // Aquí especificas el color de borde deseado
              ),
            ),
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(
              top: 5,
              bottom: 5,
              right: 15,
              left: 15,
            ),
            child: Text(
              item.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(
                  isSelected
                      ? (themeProvider.isDarkMode
                          ? primaryDark
                          : Colors.white.value)
                      : (themeProvider.isDarkMode
                          ? Colors.white.value
                          : primaryDark),
                ),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          menuProps: MenuProps(
            backgroundColor: Color(
              themeProvider.isDarkMode ? primaryDark : primaryLightAlternative,
            ),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Color(
                  themeProvider.isDarkMode ? primaryLight : primaryDark,
                ),
                width: 1.0,
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
          ),
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).backgroundColor,
              suffixIcon: Icon(Icons.search),
              label: Text('Buscar'),
            ),
          ),
        ),
        dropdownButtonProps: DropdownButtonProps(
          color: Color(
            themeProvider.isDarkMode ? primaryLight : primaryDark,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}

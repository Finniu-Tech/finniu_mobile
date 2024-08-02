import 'package:dropdown_search/dropdown_search.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/infrastructure/models/calculate_investment.dart';
import 'package:finniu/infrastructure/models/pre_investment_form.dart';
import 'package:finniu/presentation/providers/dead_line_provider.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
// import 'package:finniu/widgets/custom_select_button.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:finniu/widgets/snackbar.dart';
import 'package:finniu/widgets/switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Calculator extends StatefulHookConsumerWidget {
  const Calculator({super.key});

  @override
  ConsumerState<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends ConsumerState<Calculator> {
  final amountFocusNode = FocusNode();

  @override
  void dispose() {
    amountFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(settingsNotifierProvider);

    final deadLineController = useTextEditingController();
    final amountController = useTextEditingController();
    final isSoles = ref.watch(isSolesStateProvider);
    final deadLineFuture = ref.watch(deadLineFutureProvider.future);

    List<Color> dayColors = [const Color(gradient_primary), const Color(gradient_secondary)];
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
            colors: currentTheme.isDarkMode ? nightColors : dayColors,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
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
                      color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(blackText),
                    ),
                  ),
                ),
                SizedBox(
                  child: Container(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        textAlign: TextAlign.center,
                        'Simula tu inversión de manera rápida y sencilla',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
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
                    focusNode: amountFocusNode,
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
                        color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(grayText1),
                      ),
                      suffixIconConstraints: const BoxConstraints(
                        maxHeight: 38,
                        minWidth: 38,
                      ),
                      label: const Text(
                        "Monto",
                      ),
                    ),
                    keyboardType: TextInputType.number,
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
                      color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(blackText),
                    ),
                  ),
                ),
                CustomSelectButtonCalculator(
                  asyncItems: (String filter) async {
                    final response = await deadLineFuture;
                    return response.map((e) => e.name).toList();
                  },
                  callbackOnChange: (value) async {
                    deadLineController.text = value;
                    FocusScope.of(context).unfocus();
                  },
                  textEditingController: deadLineController,
                  labelText: "Plazo",
                  hintText: "Seleccione su plazo de inversión",
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
                      color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(blackText),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 77, left: 85),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        // textAlign: TextAlign.start,
                        "Moneda",
                        style: TextStyle(fontSize: 13),
                      ),
                      Spacer(),
                      SwitchMoney(
                        switchHeight: 34,
                        switchWidth: 67,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 224,
                  height: 55,
                  margin: const EdgeInsets.only(top: 10),
                  child: TextButton(
                    onPressed: () async {
                      if (amountController.text.isEmpty || deadLineController.text.isEmpty) {
                        CustomSnackbar.show(
                          context,
                          'Recuerda que todos los campos son requeridos',
                          'error',
                        );
                      } else if (int.parse(amountController.text) < 500) {
                        CustomSnackbar.show(
                          context,
                          'Recuerda que el monto mínimo de inversión es de S/500 y el máximo es de S/100000',
                          'error',
                        );
                      } else {
                        Navigator.pushNamed(
                          context,
                          '/calculator_result',
                          arguments: CalculatorInput(
                            amount: int.parse(amountController.text),
                            months: int.parse(deadLineController.text.split(' ')[0]),
                            currency: isSoles ? currencyNuevoSol : currencyDollar,
                          ),
                        );
                      }
                      setState(() {});
                    },
                    style: ButtonStyle(
                      elevation: WidgetStateProperty.all<double>(4), // Altura de la sombra

                      shadowColor: WidgetStateProperty.all<Color>(Colors.grey),

                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 10,
                        ),
                      ),
                    ),
                    child: const Text(
                      'Continuar',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// void _calculatePercentage(String s) {}

class CustomSelectButtonCalculator extends HookConsumerWidget {
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
  CustomSelectButtonCalculator({
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
                    ? (themeProvider.isDarkMode ? primaryLight : primaryDarkAlternative)
                    : (themeProvider.isDarkMode ? primaryDarkAlternative : primaryLight),
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
                      ? (themeProvider.isDarkMode ? primaryDark : Colors.white.value)
                      : (themeProvider.isDarkMode ? Colors.white.value : primaryDark),
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
              fillColor: Theme.of(context).colorScheme.surface,
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

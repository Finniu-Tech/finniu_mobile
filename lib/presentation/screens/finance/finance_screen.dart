import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/home/widgets/navigation_bar.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/custom_select_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FinanceScreen extends HookConsumerWidget {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(settingsNotifierProvider);
    final currentTheme = ref.watch(settingsNotifierProvider);
    final amountController = useTextEditingController();
    final incomeController = useTextEditingController();

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode
          ? const Color(backgroundColorDark)
          : const Color(whiteText),
      bottomNavigationBar: const NavigationBarHome(),
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkMode
            ? const Color(backgroundColorDark)
            : const Color(whiteText),
        elevation: 0,
        leading: themeProvider.isDarkMode
            ? const CustomReturnButton(
                colorBoxdecoration: primaryDark,
                colorIcon: primaryDark,
              )
            : const CustomReturnButton(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14.0),
            child: SizedBox(
              width: 70,
              height: 70,
              child: themeProvider.isDarkMode
                  ? Image.asset('assets/images/logo_small_dark.png')
                  : Image.asset('assets/images/logo_small.png'),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('assets/images/finance.png'),
                width:
                    40, // ajusta el tamaño de la imagen según tus necesidades
                height: 40,
              ),
              Text(
                'Mis finanzas',
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1.5,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: themeProvider.isDarkMode
                      ? const Color(primaryLight)
                      : const Color(primaryDark),
                ),
              ),
            ],
          ),
          Text(
            'Ingresa tu ingreso mensual',
            textAlign: TextAlign.center,
            style: TextStyle(
              height: 1.5,
              fontSize: 14,
              color: themeProvider.isDarkMode
                  ? const Color(whiteText)
                  : const Color(blackText),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 224,
            child: TextFormField(
              controller: amountController,
              key: const Key('amount'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Este dato es requerido';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Ingrese el monto de sus ingreos',
                label: Text("Monto"),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 185,
            child: Text(
              'Elige cuanto de tus ingreso destinarias para invertir',
              textAlign: TextAlign.justify,
              style: TextStyle(
                height: 1.4,
                fontSize: 14,
                color: themeProvider.isDarkMode
                    ? const Color(whiteText)
                    : const Color(blackText),
              ),
            ),
          ),
          Text(
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
          CustomSelectButton(
            textEditingController: incomeController,
            items: const ['De 10% a 15%', 'Entre 20% a 30%'],
            labelText: "Seleccione su % de ingres",
          ),
          const SizedBox(height: 16),
          Container(
            width: 300,
            height: 150,
            // padding: const EdgeInsets.all(20),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: 220,
                  height: 135,
                  decoration: BoxDecoration(
                    color: currentTheme.isDarkMode
                        ? const Color(primaryLightAlternative)
                        : const Color(secondary),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color(secondary),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(35.0),
                    child: Text(
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.2,
                        color: Color(blackText),
                        fontWeight: FontWeight.w500,
                      ),
                      "En instantes te mostraremos el gráfico de tus ingresos y algunos tips.",
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 0,
                  child: Container(
                      height: 80,
                      width: 60,
                      child: Image.asset(
                        "assets/images/finance_2.png",
                        height: 66,
                        width: 66,
                      )),
                ),
                Positioned(
                  top: 9,
                  child: Image.asset(
                    'assets/images/clock.png',
                    height: 40,
                    width: 40,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            width: 320,
            height: 130,
            decoration: BoxDecoration(
              color: themeProvider.isDarkMode
                  ? const Color(primaryDark)
                  : const Color(primaryLightAlternative),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    width: 118,
                    height: 112,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/hand.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 180,
                      child: Text(
                        textAlign: TextAlign.justify,
                        'Multiplica tu dinero desde hoy',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: themeProvider.isDarkMode
                              ? const Color(whiteText)
                              : const Color(primaryDark),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 161,
                      height: 38,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/finance_screen2');
                        },
                        child: const Text(
                          'Ver planes',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

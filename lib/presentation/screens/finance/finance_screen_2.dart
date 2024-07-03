import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/home/widgets/navigation_bar.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/custom_select_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Finance_Screen_2 extends HookConsumerWidget {
  final fieldValues = <String, dynamic>{};

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(settingsNotifierProvider);
    final currentTheme = ref.watch(settingsNotifierProvider);
    final userProfile = ref.watch(userProfileNotifierProvider);
    final namesController = useTextEditingController();
    final amountController = useTextEditingController();
    final incomeController = useTextEditingController();

    String mapControllerKey(String key) {
      if (key == 'names') {
        return namesController.text;
      } else if (key == 'docNumber') {
        return amountController.text;
      } else if (key == 'department') {
        return incomeController.text;
      } else {
        return '';
      }
    }

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 25,
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
                Column(
                  children: [
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
                  ],
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
                Column(
                  children: [
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
                  ],
                ),
                const SizedBox(
                  height: 2,
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
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 240),
                  child: Container(
                    alignment: Alignment.centerRight,
                    width: 80,
                    height: 28.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: currentTheme.isDarkMode
                          ? const Color(primaryDark)
                          : const Color(
                              primaryLight,
                            ), // borde negro para el contenedor
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          size: 14,
                          color: currentTheme.isDarkMode
                              ? const Color(primaryLight)
                              : const Color(primaryDark),
                        ),
                        Center(
                          child: Text(
                            style: TextStyle(
                              fontSize: 11,
                              color: currentTheme.isDarkMode
                                  ? const Color(primaryLight)
                                  : const Color(primaryDark),
                              fontWeight: FontWeight.bold,
                            ),
                            '10%',
                            textAlign:
                                TextAlign.center, // alinear texto al centro
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: currentTheme.isDarkMode
                              ? const Color(primaryLight)
                              : const Color(primaryDark),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const CircularFinanceSimulation(),
                    Positioned(
                      right: 110,
                      bottom: 150,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 110,
                          height: 50,
                          // padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(primaryLightAlternative),
                            border: Border.all(
                              width: 2,
                              color: currentTheme.isDarkMode
                                  ? const Color(primaryLight)
                                  : const Color(primaryDark),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          // color: Color(primaryDark),

                          child: const Column(
                            children: [
                              Center(
                                child: Text(
                                  textAlign: TextAlign.center,
                                  'Si inviertes el 11% de tu monto',
                                  style: TextStyle(
                                    color: Color(blackText),
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                'S/400',
                                style: TextStyle(
                                  color: Color(primaryDark),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 13,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 22,
                      height: 16,
                      decoration: BoxDecoration(
                        color: const Color(
                          primaryLight,
                        ), // color de fondo del contenedor
                        borderRadius:
                            BorderRadius.circular(10), // borde redondeado
                      ),
                    ),
                    const SizedBox(
                      width: 8, // espacio entre el contenedor y el texto
                    ),
                    Text(
                      'Ingresos',
                      style: TextStyle(
                        fontSize: 10,
                        color: currentTheme.isDarkMode
                            ? const Color(whiteText)
                            : const Color(blackText),
                        fontWeight: FontWeight.bold // estilo del texto
                        ,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Container(
                      width: 22,
                      height: 16,
                      decoration: BoxDecoration(
                        color: const Color(
                          primaryDark,
                        ), // color de fondo del contenedor
                        borderRadius:
                            BorderRadius.circular(10), // borde redondeado
                      ),
                    ),
                    const SizedBox(
                      width: 8, // espacio entre el contenedor y el texto
                    ),
                    Text(
                      '% de ingresos a invertir',
                      style: TextStyle(
                        fontSize: 10,
                        color: currentTheme.isDarkMode
                            ? const Color(whiteText)
                            : const Color(blackText),
                        fontWeight: FontWeight.bold // estilo del texto
                        ,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 300,
                  height: 150,
                  // padding: const EdgeInsets.all(20),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        width: 233,
                        height: 165,
                        decoration: BoxDecoration(
                          color: currentTheme.isDarkMode
                              ? const Color(primaryLightAlternative)
                              : const Color(secondary),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: const Color(secondary),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // alinear los textos a la izquierda
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(23.0),
                              child: Text(
                                "Hola ${userProfile.nickName}, separar entre un 10 a 15% de tus ingresos mensuales es una buena forma de empezar a invertir tu dinero para cumplir tus metas.¿Deseas guardar tu presupuesto?",
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                  fontSize: 10,
                                  height: 1.4,
                                  color: Color(blackText),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 35),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(5),
                                        topLeft: Radius.circular(5),
                                        bottomLeft: Radius.circular(3),
                                        bottomRight: Radius.circular(3),
                                      ),
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text(
                                    "Quiero guardar mi presupuesto",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 8,
                                      height: 1.3,
                                      color: Color(grayText1),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 40,
                        left: 0,
                        child: SizedBox(
                          height: 80,
                          width: 60,
                          child: Image.asset(
                            "assets/images/finance_2.png",
                            height: 66,
                            width: 66,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                          SizedBox(
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
                                Navigator.pushNamed(
                                    context, '/finance_screen2');
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
          ),
        ),
      ),
    );
  }
}

class CircularFinanceSimulation extends ConsumerWidget {
  const CircularFinanceSimulation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final themeProvider = ref.watch(settingsNotifierProvider);
    return Container(
      margin: const EdgeInsets.only(right: 20.0),
      child: CircularPercentIndicator(
        circularStrokeCap: CircularStrokeCap.round,
        radius: 90.0,
        lineWidth: 15.0,
        percent: 0.5,
        center: CircleAvatar(
          radius: 50,
          backgroundColor: themeProvider.isDarkMode
              ? const Color(backgroundColorDark)
              : Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              Text(
                "S/4000",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: themeProvider.isDarkMode
                      ? const Color(whiteText)
                      : const Color(blackText),
                ),
              ),
              Text(
                "Total de ingresos",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: themeProvider.isDarkMode
                      ? const Color(whiteText)
                      : const Color(blackText),
                ),
              ),
            ],
          ),
        ),
        progressColor:
            Color(themeProvider.isDarkMode ? primaryLight : primaryDark),
        backgroundColor:
            Color(themeProvider.isDarkMode ? primaryDark : primaryLight),
        fillColor: themeProvider.isDarkMode
            ? const Color(backgroundColorDark)
            : Colors.white,
      ),
    );
  }
}

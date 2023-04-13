import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/home/home.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InvestmentFinish extends ConsumerWidget {
  const InvestmentFinish({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {

       final currentTheme = ref.watch(settingsNotifierProvider);
    return CustomScaffoldReturnLogo(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(children: [
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    ' Mis inversiones 💸 ',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color:
                          Color(Theme.of(context).colorScheme.secondary.value),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 80,
              ),
              const Spacer(),
              Image.asset(
                'assets/icons/calendar.png',
                width: 20,
                height: 20,
                color: currentTheme.isDarkMode
                    ? const Color(primaryLight)
                    : const Color(primaryDark),
              ),
            ]),
            const SizedBox(
              height: 30,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 170,
                  height: 40,
                  decoration: BoxDecoration(
                    color: currentTheme.isDarkMode
                        ? const Color(primaryLight)
                        : const Color(primaryDark),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Rentabilidad",
                      style: TextStyle(
                        color: currentTheme.isDarkMode
                            ? const Color(primaryDark)
                            : const Color(whiteText),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 170,
                  height: 40,
                  decoration: BoxDecoration(
                    color: currentTheme.isDarkMode
                        ? const Color(primaryDark)
                        : const Color(primaryLight),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/investment_history');
                        },
                        child: Text(
                          "Mi historial",
                          style: TextStyle(
                            color: currentTheme.isDarkMode
                                ? const Color(whiteText)
                                : const Color(primaryDark),
                          ),
                        )),
                  ),
                ),
              ],
            ),

            const LineReportHomeWidget(
              initialAmount: 550,
              finalAmount: 583,
              revenueAmount: 33,
            ),
           
            Padding(
              padding: const EdgeInsets.only(right: 30, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .start, // Alinear widgets en el centro horizontalmente
                children: [
                  Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: currentTheme.isDarkMode
                            ? const Color(primaryDark)
                            : const Color(primaryDark),
                      ),
                      shape: BoxShape.circle,
                      color: currentTheme.isDarkMode
                          ? const Color(primaryDark)
                          : const Color(primaryLight),
                    ),
                    // Si desea agregar un icono dentro del círculo
                  ),
                  const SizedBox(
                      width: 5), // Separación entre el círculo y el texto
                  Text(
                    'Dinero invertido',
                    style: TextStyle(
                      fontSize: 10,
                      color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(blackText),
                    ),
                  ),

                  const Spacer(),

                  Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      border:
                          Border.all(width: 1, color: const Color(primaryDark)),
                      shape: BoxShape.circle,
                      color: currentTheme.isDarkMode
                          ? const Color(primaryLight)
                          : const Color(secondary),
                    ),
                    // Si desea agregar un icono dentro del círculo
                  ),
                  // Separación entre el círculo y el texto
                  const SizedBox(width: 5),
                  Text(
                    'Intereses generados',
                    style: TextStyle(
                      fontSize: 10,
                      color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(blackText),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Distribución de mi patrimonio',
              style: TextStyle(
                fontSize: 16,
                color: currentTheme.isDarkMode
                    ? const Color(whiteText)
                    : const Color(blackText),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(
                  'Inversiones en Curso',
                  style: TextStyle(
                    fontSize: 12,
                    color: currentTheme.isDarkMode
                        ? const Color(whiteText)
                        : const Color(primaryDark),
                  ),
                ),
                const SizedBox(
                  width: 90,
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  
                  child: Container(decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: currentTheme.isDarkMode
                            ? const Color(secondary)
                            : const Color(primaryLight), // color del subrayado
                        width: 5.0, // ancho del subrayado
                      ),
                    ),
                  ),
                    child: Text(
                      'Inversiones finalizadas',
                      style: TextStyle(
                        fontSize: 12,
                        color: currentTheme.isDarkMode
                            ? const Color(whiteText)
                            : const Color(blackText),
                      ),
                    ),
                  ),
                )
              
              
              
              
              
              
              
              ],
            ),
     SizedBox(height: 10,),
     
     TableCard()
          ],
          ),
          ),
          ),
          );
  }
}


class TableCard extends ConsumerWidget {
  const TableCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 200,
      decoration: BoxDecoration(
        color: currentTheme.isDarkMode
            ? Colors.transparent
            : const Color(whiteText),
        border: Border.all(
          color: currentTheme.isDarkMode
              ? const Color(primaryLight)
              : const Color(primaryDark),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Plan estable',
                style: TextStyle(
                  color: currentTheme.isDarkMode
                      ? const Color(primaryLight)
                      : const Color(primaryDark),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.39,
              ),
              Image.asset(
                alignment: Alignment.center,
                'assets/images/circle_purple.png',
                height: 15,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                'Finalizado',
                style: TextStyle(
                  fontSize: 11,
                  color: currentTheme.isDarkMode
                      ? const Color(whiteText)
                      : const Color(blackText),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
           Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              'Finalizó:29 Enero 2023',
              style: TextStyle(fontSize: 11, color: currentTheme.isDarkMode? const Color(whiteText)
                      : const Color(blackText),fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.center,
           
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Column(children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: 
                                     const Color(primaryLight),
                                border: Border.all(
                                  color:
                                       const Color(primaryLight),
                                )),
                            height: 60,
                            width: 5,
                          ),
                        ]),
                        const SizedBox(width: 10,),
                        Column(
                          children: [
                            Text(
                              'Dinero invertido',
                              style: TextStyle(
                                color: currentTheme.isDarkMode
                                    ? const Color(whiteText)
                                    : const Color(blackText),
                                fontSize: 10,
                              
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'S/1000',
                              style: TextStyle(
                                color: currentTheme.isDarkMode
                                    ? const Color(whiteText)
                                    : const Color(primaryDark),
                                fontSize: 16,
                             
                              ),
                            ),
                          ],
                        ),
                     const SizedBox(width: 15,),
                      Column(children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: 
                                     const Color(gradient_secondary_option),
                                border: Border.all(
                                  color: 
                                       const Color(gradient_secondary_option),
                                ),
                                ),
                            height: 60,
                            width: 5,
                          ),
                        ],
                        ),
                     
                     const SizedBox(width: 10,),
                      Column(
                          children: [
                            Text(
                              'Dinero+ intereses',
                              style: TextStyle(
                                color: currentTheme.isDarkMode
                                    ? const Color(primaryLight)
                                    : const Color(primaryDark),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'S/1140',
                              style: TextStyle(
                                color: currentTheme.isDarkMode
                                    ? const Color(primaryLight)
                                    : const Color(primaryDark),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),],
                    ),
                  
                 
                ],
                ),
              ),
             
                 ],
                ),

                const SizedBox(height: 10,),
                    Container(alignment: Alignment.center,
                      child: const Text(textAlign:TextAlign.center,
                                'Rentabilidad generada en 12 meses:14%',
                                style: TextStyle(
                                  color:  Color(grayText2),
                                  fontSize: 10,
                                
                                ),
                              ),
                    ),
                
                ]
                
                
                ,
              ),
              );
          
  }
}

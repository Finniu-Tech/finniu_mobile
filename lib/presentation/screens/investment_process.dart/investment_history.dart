

import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../widgets/scaffold.dart';
class InvestmentHistory extends ConsumerWidget {
  const InvestmentHistory({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
       final currentTheme = ref.watch(settingsNotifierProvider);
    return CustomScaffoldReturnLogo(
      
      
        body: SingleChildScrollView(
          
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
              
              children: <Widget>[
                
                 
              Row(
                  children: [
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                                  'Mis inversiones',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Color(Theme.of(context).colorScheme.secondary.value),
                                  ),
                                ),
                      ),
                    ),
                const SizedBox(width: 10,),
                 Image.asset(
        'assets/icons/dollar.png',
        width: 20,
        height: 20,
      ),
           const SizedBox(width:80,),
               
               Spacer(),
               Image.asset(
        'assets/icons/calendar.png',
        width: 20,
        height: 20,color:currentTheme.isDarkMode
                          ? const Color(primaryLight)
                          : const Color(primaryDark),
      ),
              
              
              ]),
                const SizedBox(height: 30,),
                
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
      width: 170,
      height: 40,
      decoration:  BoxDecoration(
        color:currentTheme.isDarkMode
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
        child: Text("Rentabilidad",style: TextStyle(color:currentTheme.isDarkMode
                          ? const Color(primaryDark)
                          : const Color(whiteText),
                          ),),
      ),
    ),
          
    Container(
      width: 170,
      height: 40,
      decoration:  BoxDecoration(
        color:currentTheme.isDarkMode
                          ? const Color(primaryDark)
                          : const Color(primaryLight),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
        
      ),
      child:  Center(

        child: GestureDetector(  
                        onTap: () {
                          Navigator.pushNamed(context, '/investment_history');
                        },child: Text("Mi historial",style: TextStyle(color:currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(primaryDark),),)),
      ),
    ),  
    
       
               
     ],
                ),
               
           
                const SizedBox(height: 20,),
                
                
                
                const CircularImageSimulation(),
                
                
                
                
                
                ]
                ),
                ),
                ),
                );
  
  
  }
  }


  class CircularImageSimulation extends ConsumerWidget {
  const CircularImageSimulation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final themeProvider = ref.watch(settingsNotifierProvider);
    return Column(
      children: [
        Container(
      
          child: CircularPercentIndicator(
            circularStrokeCap: CircularStrokeCap.round,
            radius: 86.0,
            lineWidth: 12.0,
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
                  Container(alignment: Alignment.centerLeft,
                    child: Text(
                      "Dinero invertido",
                      
                                   
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: themeProvider.isDarkMode
                              ? const Color(primaryLight)
                              : const Color(primaryDark)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "S/4050",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.isDarkMode
                            ? const Color(primaryLight)
                            : const Color(primaryDark)),
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
        ),
       SizedBox(height: 20,),
       Row(mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: themeProvider.isDarkMode
                                ? const Color(primaryDark)
                                : const Color(primaryLight),
                          ),
                          shape: BoxShape.circle,
                          color: themeProvider.isDarkMode
                              ? const Color(primaryDark)
                              : const Color(primaryLight),
                        ),
                        // Si desea agregar un icono dentro del círculo
                      ),
       
                  const SizedBox(
                      width: 5), // Separación entre el círculo y el texto
                  Text(
                    'Plan Origen',
                    style: TextStyle(
                      fontSize: 10,
                      color: themeProvider.isDarkMode
                          ? const Color(whiteText)
                          : const Color(blackText),
                    ),
                  ),
                  
                  
              
                  SizedBox(width: 20,),
                  Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      border:
                          Border.all(width: 1, color: const Color(primaryDark)),
                      shape: BoxShape.circle,
                      color:themeProvider.isDarkMode
                          ? const Color(primaryLight)
                          : const Color(primaryDark),
                    ),
                    // Si desea agregar un icono dentro del círculo
                  ),
                  // Separación entre el círculo y el texto
                 
                  const SizedBox(width: 5),
                  Text(
                    'Plan Estable',
                    style: TextStyle(
                      fontSize: 10,
                      color: themeProvider.isDarkMode
                          ? const Color(whiteText)
                          : const Color(blackText),
                    ),
                  ),
                ],
    ),
    SizedBox(height: 10,)
,     Container(alignment: Alignment.centerLeft,
  child:   Text(
                      'Estado de mis inversiones ',
                      style: TextStyle(
                        fontSize: 10,
                        color: themeProvider.isDarkMode
                            ? const Color(whiteText)
                            : const Color(blackText),
                      ),
                    ),
),
                  
                  
                  ],
       );
           
  }
}



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
                                  'Mis inversiones 💸 ',
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
             
           const SizedBox(width:80,),
               
               const Spacer(),
               Padding(
                 padding: const EdgeInsets.only(right: 11),
                 child: InkWell( onTap: () {
            Navigator.pushNamed(context, '/calendar_page');
          },
                   child: Image.asset(
                         'assets/icons/calendar.png',
                         width: 20,
                         height: 20,color:currentTheme.isDarkMode
                              ? const Color(primaryLight)
                              : const Color(primaryDark),
                       ),
                 ),
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
                          ? const Color(primaryDark)
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
                          ? const Color(whiteText)
                          : const Color(whiteText),
                          ),),
      ),
    ),
          
    Container(
      width: 170,
      height: 40,
      decoration:  BoxDecoration(
        color:currentTheme.isDarkMode
                          ? const Color(primaryLight)
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
                          ? const Color(primaryDark)
                          : const Color(primaryDark),),)),
      ),
    ),  
    
       
               
     ],
                ),
               
           
                const SizedBox(height: 20,),
                
                
                
                const CircularImageSimulation(),
                
                Container(alignment: Alignment.centerLeft,
  child:   Text(
                      'Estado de mis inversiones ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: currentTheme.isDarkMode
                            ? const Color(whiteText)
                            : const Color(blackText),
                      ),
                    ),
),
                  const SizedBox(height: 10,),
                  
                  Row(
                    children: [
                      Container(decoration:  BoxDecoration(
                        border:Border(
                          bottom:BorderSide(
                            color:currentTheme.isDarkMode
                               ? const Color(secondary)
                               : const Color(primaryLight),
                            width: 6,),),
                            
                            
                            ),
                        child: Text(
                         'En curso',
                         style: TextStyle(
                           fontSize: 12,
                          
                           color:currentTheme.isDarkMode
                               ? const Color(primaryLight)
                               : const Color(primaryDark),
                         ),
                        ),
                      ),
                    const SizedBox(width: 22,),
                     Text(
                       'Finalizadas',
                       style: TextStyle(
                         fontSize: 12,
                        
                         color:currentTheme.isDarkMode
                             ? const Color(whiteText)
                             : const Color(blackText),
                       ),
                      ),
                   
                   
                     const SizedBox(width: 22,),
                     Text(
                       'En proceso',
                       style: TextStyle(
                         fontSize: 12,
                        
                         color:currentTheme.isDarkMode
                             ? const Color(whiteText)
                             : const Color(blackText),
                       ),
                      ),

                      Text(
                       '(1)',
                       style: TextStyle(
                         fontSize: 12,
                        
                         color:currentTheme.isDarkMode
                             ? const Color(primaryLight)
                             : const Color(primaryDark),
                       ),
                      ),
                       const SizedBox(width: 22,),
                       Text(
                       'Rechazadas',
                       style: TextStyle(
                         fontSize: 12,
                         fontWeight: FontWeight.bold,
                        
                         color:currentTheme.isDarkMode
                             ? const Color(whiteText)
                             : const Color(primaryDark),
                       ),
                      ),
                  
                  
                    ],
                  ),
                       
                       const SizedBox(height: 10,),
                       
                        Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(width: MediaQuery.of(context).size.width * 0.9,
           
            
            height: 110,
            decoration: BoxDecoration( 
               boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset:
                                    const Offset(0, 3), // changes position of shadow
                              ),
                            ],
              
              
              
              color: currentTheme.isDarkMode
                          ? const Color(primaryDark)
                          : const Color(primaryLightAlternative),borderRadius: BorderRadius.circular(10)),
            
            
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
               
               
                children: [
               
                   const SizedBox(height: 10,),
                   
                     Row(
                       children: [
                         Text(
                          'Plan Estable',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: currentTheme.isDarkMode
                              ? const Color(whiteText)
                              : const Color(blackText),
                          ),
                         
                         
                         
                         
                          ),
                       const SizedBox(width: 10,),
                      Text(
                      'S/1500',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: currentTheme.isDarkMode
                          ? const Color(primaryLight)
                          : const Color(blackText),
                      ),
                     
                     
                     
                     
                      ),
                      const Spacer(),
                       Image.asset(
                     alignment: Alignment.center,
                     'assets/images/circle_green.png',
                    height: 15,
                    
                   ),
            const SizedBox(width: 5,),
             Text(
                    'En curso',
                    style: TextStyle(
                      fontSize: 11,
                  
                      color:currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(blackText),
                    ),

      )
                      
                      
                      ],
                     ),
                const SizedBox(height: 10,),
                Text(
                          'Plazo de 12 meses: 14%',
                          style: TextStyle(
                            fontSize: 10,
                        
                            color: currentTheme.isDarkMode
                          ? const Color(grayText)
                          : const Color(grayText),
                          ),
                         
                         
                         
                         
                          ),




                const SizedBox(height: 10,),
                Row(
                children: [
                   Text(
                          'Inicio',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(blackText),
                          ),
                         
                         
                         
                         
                          ),
                            Text(
                          '29 Mayo',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(blackText),
                          ),
                         
                         
                         
                         
                          ),
                           
                            SizedBox(width:MediaQuery.of(context).size.width * 0.03,),
                const SizedBox(height: 10,),
                     const Spacer(),
                       Text(
                      'Finaliza:',
                      style: TextStyle(
                        fontSize: 12,
                 
                        color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(blackText),
                      ),
                     
                     
                     
                     
                      ),
                
               Text(
                      '29 Mayo 2023',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(blackText),
                      ),
                     
                     
                     
                     
                      ),
                
                ],
                ),
              ],
              ),
                ),
                )),
                SizedBox(height: 10,),
                  Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(width: MediaQuery.of(context).size.width * 0.9,
            
            height: 110,
            decoration: BoxDecoration(
              
                 boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset:
                                    const Offset(0, 3), // changes position of shadow
                              ),
                            ],
              
              
              
               color: currentTheme.isDarkMode
                          ? const Color(primaryDark)
                          : const Color(primaryLightAlternative),borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
               
               
                children: [
               
                   const SizedBox(height: 10,),
                   
                     Row(
                       children: [
                         Text(
                          'Plan Estable',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: currentTheme.isDarkMode
                              ? const Color(whiteText)
                              : const Color(blackText),
                          ),
                         
                         
                         
                         
                          ),
                       const SizedBox(width: 10,),
                      Text(
                      'S/720',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: currentTheme.isDarkMode
                          ? const Color(primaryLight)
                          : const Color(blackText),
                      ),
                     
                     
                     
                     
                      ),
                      const Spacer(),
                       Image.asset(
                     alignment: Alignment.center,
                     'assets/images/circle_green.png',
                    height: 15,
                    
                   ),
            const SizedBox(width: 5,),
             Text(
                    'En curso',
                    style: TextStyle(
                      fontSize: 11,
                  
                      color:currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(blackText),
                    ),

      )
                      
                      
                      ],
                     ),
                const SizedBox(height: 10,),
                Text(
                          'Plazo de 12 meses: 12%',
                          style: TextStyle(
                            fontSize: 10,
                        
                            color: currentTheme.isDarkMode
                          ? const Color(grayText)
                          : const Color(grayText),
                          ),
                         
                         
                         
                         
                          ),




                const SizedBox(height: 10,),
                Row(
                children: [
                   Text(
                          'Inicio',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(blackText),
                          ),
                         
                         
                         
                         
                          ),
                            Text(
                          '29 Noviembre',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(blackText),
                          ),
                         
                         
                         
                         
                          ),
                           
                            SizedBox(width:MediaQuery.of(context).size.width * 0.03,),
                const SizedBox(height: 10,),
                     const Spacer(),
                    Text(
                      'Finaliza:',
                      style: TextStyle(
                        fontSize: 12,
                 
                        color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(blackText),
                      ),
                     
                     
                     
                     
                      ),
                
               Text(
                      '29 Mayo 2023',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(blackText),
                      ),
                     
                     
                     
                     
                      ),
                
                ]
                ),
             
             

               








             
             
              ]),
                ),
                
                
                
                
                
                
                
              )),
              const SizedBox(height: 10,),
              
                Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(width: MediaQuery.of(context).size.width * 0.9,
            
            height: 110,
            decoration: BoxDecoration( 
              
                 boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset:
                                    const Offset(0, 3), // changes position of shadow
                              ),
                            ],
              
              
              color: currentTheme.isDarkMode
                          ? const Color(primaryDark)
                          : const Color(primaryLightAlternative),borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
               
               
                children: [
               
                   const SizedBox(height: 10,),
                   
                     Row(
                       children: [
                         Text(
                          'Plan Estable',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: currentTheme.isDarkMode
                              ? const Color(whiteText)
                              : const Color(blackText),
                          ),
                         
                         
                         
                         
                          ),
                       const SizedBox(width: 10,),
                      Text(
                      'S/5400',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: currentTheme.isDarkMode
                          ? const Color(primaryLight)
                          : const Color(blackText),
                      ),
                     
                     
                     
                     
                      ),
                      const Spacer(),
                       Image.asset(
                     alignment: Alignment.center,
                     'assets/images/circle_green.png',
                    height: 15,
                    
                   ),
            const SizedBox(width: 5,),
             Text(
                    'En curso',
                    style: TextStyle(
                      fontSize: 11,
                  
                      color:currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(blackText),
                    ),

      )
                      
                      
                      ],
                     ),
                const SizedBox(height: 10,),
                Text(
                          'Plazo de 6 meses: 8%',
                          style: TextStyle(
                            fontSize: 10,
                        
                            color: currentTheme.isDarkMode
                          ? const Color(grayText)
                          : const Color(grayText),
                          ),
                         
                         
                         
                         
                          ),




                const SizedBox(height: 10,),
                Row(
                children: [
                   Text(
                          'Inicio',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(blackText),
                          ),
                         
                         
                         
                         
                          ),
                            Text(
                          '13 Octubre',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(blackText),
                          ),
                         
                         
                         
                         
                          ),
                           
                            SizedBox(width:MediaQuery.of(context).size.width * 0.03,),
                const SizedBox(height: 10,),
                     const Spacer(),
                       Text(
                      'Finaliza:',
                      style: TextStyle(
                        fontSize: 12,
                 
                        color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(blackText),
                      ),
                     
                     
                     
                     
                      ),
                
                 Text(
                      '13 Abril 2023',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(blackText),
                      ),
                     
                     
                     
                     
                      ),
                
                ],
                ),
              ],
              ),
                ),
              
              
              
              ))]
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
        CircularPercentIndicator(
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
                            ? const Color(whiteText)
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
              Color(themeProvider.isDarkMode ? gradient_secondary_option : primaryDark),
          backgroundColor:
              Color(themeProvider.isDarkMode ? primaryLight : primaryLightAlternative),
          fillColor: themeProvider.isDarkMode
              ? const Color(backgroundColorDark)
              : Colors.white,
        ),
       const SizedBox(height: 20,),
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
                  
                  
              
                  const SizedBox(width: 20,),
                  Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      border:
                          Border.all(width: 1, color: const Color(primaryDark)),
                      shape: BoxShape.circle,
                      color:themeProvider.isDarkMode
                          ? const Color(gradient_secondary_option)
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
    const SizedBox(height: 10,)
,     
                       ],
                       );
                
     
           
  }
}

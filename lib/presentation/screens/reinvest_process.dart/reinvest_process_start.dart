import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
class Reinvest extends HookConsumerWidget {
  const Reinvest({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
       final themeProvider = ref.watch(settingsNotifierProvider);
   return CustomScaffoldReturnLogo(
      body:  Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
              
                
                Row(
                  children: [
                     SizedBox(width: 160,
                      child: Text(textAlign:TextAlign.justify,
                        'Reinvierte tu inversión ',
                        style: TextStyle(
                          color: 
                           themeProvider.isDarkMode
                    ? const Color(primaryLight)
                    : const Color(primaryDark),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                   Spacer(),
                  const SizedBox(width: 12,),
                    Padding(
                 padding: const EdgeInsets.only(right: 10),
                 child: GestureDetector( onTap: () {
                        Navigator.pushNamed(context, '/my_investment');
                      },
                   child: Container(width: 142,height: 32,decoration: BoxDecoration(color: Color(primaryLight), borderRadius: BorderRadius.circular(20)),
                     child: const Padding(
                       padding: EdgeInsets.all(8.0),
                       child: Text( textAlign:TextAlign.center,
                              'Planes para reinvertir',
                              style: TextStyle(
                                fontSize: 11,
                            
                                color:
                                     Color(primaryDark),
                              ),
                                  
                           ),
                     ),
                     ),
                 ),
                   ),
                   ],
                ),
               const SizedBox(height: 15,),
               Row(mainAxisAlignment: MainAxisAlignment.center,
               
               
               
                 children: [
               
                     Image.asset(
                       alignment: Alignment.centerRight,
                       'assets/images/bills2.png',
                      height: 90,
                      width: 90,
                      
                     ),
               
                  SizedBox(width: 160,
                     child: Text( textAlign:TextAlign.justify,
                                  'Tu plan seleccionado a reinvertir es Plan Origen ',
                                  style: TextStyle(
                                    fontSize: 14,
                                
                                    color:
                                       themeProvider.isDarkMode
                  ? const Color(whiteText)
                  : const Color(primaryDark),
                                  ),
                                      
                               ),
                   ),
                ],
               ),
               const SizedBox(height: 25,),
               Padding(
                 padding: const EdgeInsets.only(left: 20),
                 child: SizedBox(
                    width: 320,
                    height: 102,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 185,
                            height: 85,
                            padding:  const EdgeInsets.only(
                              left:20,
                           
                              top: 20,
                            
                            ),
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
                              
                              color:
                                   const Color(secondary),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: const Color(secondary),
                              ),
                            ),
                            child: Column(
                              children: const [
                                Text(textAlign: TextAlign.center,
                               
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: 
                                         Color(blackText),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  "Tu inversión generada",
                                ),
                             Text(
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: 
                                         Color(primaryDark),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  "S/583",
                                ), ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 3,
                          left: 8,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              height: 88,
                              width: 86,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/money3.png"),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
               ),
               const SizedBox(height: 30,),
               Row(
                
                 children: [
                       Image.asset(
                         alignment: Alignment.centerRight,
                         'assets/images/money_dark.png',
                        height: 24,
                        width: 24,
                        color:themeProvider.isDarkMode
                    ? const Color(primaryLight)
                    : const Color(primaryDark),
                       ),
                  const SizedBox(width: 10,),
                   Text( textAlign:TextAlign.justify,
                                        'Elige tu método de reinvertir ',
                                        style: TextStyle(
                                          fontSize: 14,
                                      
                                          color:
                                             themeProvider.isDarkMode
                    ? const Color(whiteText)
                    : const Color(primaryDark,
                                        ),
                                            
                                     ),
               )],
               ),
                  const SizedBox(height: 30,),
                  
                   Padding(
                 padding: const EdgeInsets.only(right: 10),
                 child: GestureDetector(onTap: () {
              Navigator.pushNamed(context, '/reinvest_end');},
                   child: Container(width: 320,height: 53,decoration: BoxDecoration(color: themeProvider.isDarkMode
                      ? const Color(primaryLight)
                      : const Color(primaryDark), 
                   
                   
                   
                   borderRadius: BorderRadius.circular(20)),
                     child: Padding(
                       padding: const EdgeInsets.all(19.0),
                       child: Text( textAlign:TextAlign.center,
                              'Reinvertir mi capital+intereses',
                              style: TextStyle(
                                fontSize: 11,
                            
                                color:
                                   themeProvider.isDarkMode
                                       ? const Color(primaryDark)
                                       : const Color(whiteText),
                              ),
                                  
                           ),
                     ),
                     ),
                 ),
                   ), 
                   
                   const SizedBox(height: 30,),
                   SizedBox(
                     child: Row(mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                        Container(
                          height:1,
                          width:70,
                          color:themeProvider.isDarkMode
                    ? const Color(primaryLight)
                    : const Color(primaryDark),),
                          const SizedBox(width: 10,),
                        SizedBox(width: 140,
                           child: Text( textAlign:TextAlign.center,
                                    'Si tienes otra opción para reinvertir, escribenos al',
                                    style: TextStyle(
                                      fontSize: 11,
                                  
                                      color:
                                        themeProvider.isDarkMode
                    ? const Color(whiteText)
                    : const Color(primaryDark),
                                    ),
                                        
                                 ),
                         ),
                      Container(
                height: 1,
                width: 70,
                color: themeProvider.isDarkMode
                    ? const Color(primaryLight)
                    : const Color(primaryDark),
              ), ],
                     ),
                   ),
                     const SizedBox(height: 30,),
                     Center(
                       child: Container(
                        
                        width: 68,height: 66,
                        
                        alignment: Alignment.center,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),border:Border.all(color:themeProvider.isDarkMode
                    ? const Color(primaryLight)
                    : const Color(primaryDark),
                        
                        
                        
                        width: 2)),
                         child: Image.asset(
                            
                       
                             'assets/images/whatsapp.png',
                            height: 40,
                            width: 40,
                            
                           ),
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
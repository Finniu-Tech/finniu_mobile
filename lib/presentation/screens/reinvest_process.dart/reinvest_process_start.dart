import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
class Reinvest extends StatelessWidget {
  const Reinvest({super.key});

  @override
  Widget build(BuildContext context) {
   return CustomScaffoldReturnLogo(
      body:  Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              const SizedBox(
                height: 10,
              ),
              
              Row(
                children: [
                  Container(width: 160,
                    child: const Text(textAlign:TextAlign.justify,
                      'Reinvierte tu inversion ',
                      style: TextStyle(
                        color: 
                            Color(primaryDark),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                 
                 const SizedBox(width: 30,),
                  Padding(
               padding: const EdgeInsets.only(right: 10),
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
                 ],
              ),
             SizedBox(height: 15,),
             Padding(
               padding: const EdgeInsets.only(left: 25),
               child: Row(
             
             
             
                 children: [
             
                     Image.asset(
                       alignment: Alignment.centerRight,
                       'assets/images/bills2.png',
                      height: 90,
                      width: 90,
                      
                     ),
             
                   Container(width: 160,
                     child: Text( textAlign:TextAlign.justify,
                                  'Tu plan seleccionado a reinvertir es Plan Origen ',
                                  style: TextStyle(
                                    fontSize: 14,
                                
                                    color:
                                         Color(primaryDark),
                                  ),
                                      
                               ),
                   ),
                ],
               ),
             ),
             SizedBox(height: 25,),
             SizedBox(
                width: 320,
                height: 102,
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 185,
                        height: 95,
                        padding:  const EdgeInsets.only(
                          left: 45,
                          right: 15,
                          top: 15,
                          bottom: 15,
                        ),
                        decoration: BoxDecoration(
                          color:
                               Color(secondary),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: const Color(primaryDark),
                          ),
                        ),
                        child: Column(
                          children: const [
                            Text(
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 14,
                                color: 
                                     Color(blackText),
                                fontWeight: FontWeight.w500,
                              ),
                              "Tu inversion generada.",
                            ),
                         Text(
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 24,
                                color: 
                                     Color(primaryDark),
                                fontWeight: FontWeight.w500,
                              ),
                              "S/583.",
                            ), ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 3,
                      left: 25,
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
             const SizedBox(height: 30,),
             Row(
              
               children: [
                     Image.asset(
                       alignment: Alignment.centerRight,
                       'assets/images/money_dark.png',
                      height: 24,
                      width: 24,
                      
                     ),
                
                 const Text( textAlign:TextAlign.justify,
                                      'Elige tu metodo de reinvertir ',
                                      style: TextStyle(
                                        fontSize: 14,
                                    
                                        color:
                                             Color(primaryDark),
                                      ),
                                          
                                   ),
               ],
             ),
                SizedBox(height: 30,),
                
                 Padding(
               padding: const EdgeInsets.only(right: 10),
               child: Container(width: 320,height: 53,decoration: BoxDecoration(color: Color(primaryDark), borderRadius: BorderRadius.circular(20)),
                 child: const Padding(
                   padding: EdgeInsets.all(19.0),
                   child: Text( textAlign:TextAlign.center,
                          'Reinvertir mi capital+intereses',
                          style: TextStyle(
                            fontSize: 11,
                        
                            color:
                                 Color(whiteText),
                          ),
                              
                       ),
                 ),
                 ),
                 ), 
                 
                 SizedBox(height: 30,),
                 Container(width: 160,
                   child: Text( textAlign:TextAlign.center,
                            'Si tienes otra opcion para reinvertir, escribenes al',
                            style: TextStyle(
                              fontSize: 11,
                          
                              color:
                                   Color(primaryDark),
                            ),
                                
                         ),
                 ),
                   SizedBox(height: 10,),
                   Image.asset(
                       alignment: Alignment.center,
                       'assets/images/whatsapp.png',
                      height: 68,
                      width: 66,
                      
                     ),
                 
                 ],
              ),
              ),
              ),
              );
  }
}

import 'dart:async';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/investment_confirmation/step_1.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Step_3 extends ConsumerWidget {
  const Step_3({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final currentTheme = ref.watch(settingsNotifierProvider);
  
     Future.delayed(const Duration(seconds: 10), (){
    print("Wait for 10 seconds");
      
      () =>const Calification();
      

    });
    
    return CustomScaffoldReturnLogo(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const StepBar(),
            const SizedBox(height: 8,),
         Container(
            width: MediaQuery.of(context).size.width,
             height:MediaQuery.of(context).size.height * 0.5,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/man.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
         
          Container(
            width: MediaQuery.of(context).size.width,
            height:MediaQuery.of(context).size.height * 0.5,
            color: const Color(primaryDark),
       child: Padding(
         padding: const EdgeInsets.all(18.0),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.center,
           children:[
         
             const SizedBox(width: 300,
               child: Text(textAlign:TextAlign.justify,
                       "Hola Mari, la validación de tu transferencia será confirmada en 30 min,te enviaremos una notificación cuando validemos tu inversión.",
                       style: TextStyle(
                        
                         height: 1.9,
                         color: Colors.white,
                         fontSize: 16,
                       ),
               ),
             ),
             const SizedBox(height: 16),
             Padding(
               padding: const EdgeInsets.only(left: 23),
               child: Container(alignment: Alignment.center,
                 child: const Text(
                       "Gracias por tu comprensión!",
                       style: TextStyle(
                         color: Color(primaryLight),
                         fontSize: 16,
                       ),
                 ),
               ),
             ),
            ],
         ),
       ),
),
             
       
    ],
      ),
    ),
  );
}

}




void calificationExperience(
  BuildContext ctx,
) {
  showModalBottomSheet(
    clipBehavior: Clip.antiAlias,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(50),
        topLeft: Radius.circular(50),
      ),
    ),
    elevation: 11,
    context: ctx,
    builder: (ctx) => const Calification(),
  );
}

class Calification extends ConsumerWidget {
  const Calification ({key});

  @override
Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
            gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
               currentTheme.isDarkMode ? const Color(primaryDarkAlternative) : const Color(secondary),
               currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryLight),
            ],
          ),
                             borderRadius: BorderRadius.circular(40)),
      
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.start,
            
            children: [
            Container(
             alignment: Alignment.topRight,
             
          margin: const EdgeInsets.only( right: 20,top: 15),
              child: IconButton(color:currentTheme.isDarkMode
                            ? const Color(primaryLight)
                            : const Color(
                                blackText,
                              ),alignment: Alignment.topRight,
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop(); // cerrar la pantalla modal
                      },
                    ),
            ),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  
                  SizedBox(width: 260,
                    child: Text(
                      'Como calificaria tu experiencia durante el proceso de inversion? ',
                      textAlign: TextAlign.justify,
                      
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color:Color(
                         
                                primaryDark,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                  
              children: [
                Container(
                  width: 45,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(primaryLight),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        '1',
                        style: TextStyle(
                          color:Color(primaryDark),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Image(
                        image: AssetImage('assets/images/angry.png'),
                        width: 15,
                        height: 15,
                      ),
                      
                    ],
                  ),
              ),
               const SizedBox(width: 10,),
               Container(
                  width: 45,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(primaryLight),
                  ),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                       Text(
                        '2',
                        style: TextStyle(
                          color: Color(primaryDark),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Image(
                        image: AssetImage('assets/images/bored.png'),
                        width: 15,
                        height: 15,
                      ),
                     
                    
                  ],
                  ),
              
                   
              ),
                const SizedBox(width: 10,),
               Container(
                  width: 45,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(primaryLight),
                  ),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                       Text(
                        '3',
                        style: TextStyle(
                          fontSize: 12,
                          color:Color(primaryDark),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Image(
                        image: AssetImage('assets/images/so_so.png'),
                        width: 15,
                        height:15,
                      ),          
                  ],
                  ),
                  
              ),
               const SizedBox(width: 10,),
              Container(
                  width: 45,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(primaryDark),
                  ),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                       Text(
                        '4',
                        style: TextStyle(
                          fontSize: 12,
                          color:Color(primaryLight),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Image(
                        image: AssetImage('assets/images/happy.png'),
                        width: 15,
                        height:15,
                      ),          
                  ],
                  ),
                  
              ), 
              const SizedBox(width: 10,),
              Container(
                  width: 45,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(primaryLight),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        '5',
                        style: TextStyle(
                          color:Color(primaryDark),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Image(
                        image: AssetImage('assets/images/good.png'),
                        width: 15,
                        height: 15,
                      ),
                    
                    ],
                  ),
              ),
              
              ],
              
              ),
            ),
            
            const SizedBox(height: 10,),
            const SizedBox(width: 260,
            
              child: Text(
                  '¿Tienes algun comentario o sugerencia para mejorar nuestro proceso?(Opcional)',
                  textAlign: TextAlign.justify,
                  
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 12,
                  fontWeight: FontWeight.bold,
                    color: Color(blackText)
                  ),
                ),
            ),
          const SizedBox(height: 10,),
          Container(  width: 300,height: 124,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color:Color(whiteText))),
           const SizedBox(height: 4,),
             CustomButton(
                  text: "Enviar respuesta",
                  colorText:
                          currentTheme.isDarkMode ? (primaryDark) : whiteText,
                  colorBackground:currentTheme.isDarkMode ? (primaryLight) : primaryDark ,
                  height: 38,
                  width: 134,
                  pushName: '/investment_step4',
                ),
        
            ],
            ),
            ),
    );

  }}

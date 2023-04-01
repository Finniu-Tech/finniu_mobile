import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
class FinishInvestment extends ConsumerWidget {
  const FinishInvestment({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
     final currentTheme = ref.watch(settingsNotifierProvider);
   return Scaffold(
     body:Center(
     child:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
              TextPoppins(
              text: '¡Sigue cumpliendo tus metas financieras!',
              colorText: currentTheme.isDarkMode
                  ?  (primaryLight)
                  :  (primaryDark),
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
            Stack(
            children: <Widget>[
              SizedBox(
                width:MediaQuery.of(context).size.width,
           
                child: Image.asset(
                  fit: BoxFit.fitWidth,
                  'assets/images/hands_shake.png', // Agregar nueva imagen aquí
                          
                ),
              ),
          Positioned(
            
          top:20,
            left: 10,
            right: 10,
            child:
            SizedBox(width:111,
            height: 82,
              child: Image.asset(
              'assets/images/finniu_logo.png',color:currentTheme.isDarkMode
                    ? const Color(whiteText)
                    : const Color(primaryDark),
              
               
              ),
            ),),
            ],
            ),
            const SizedBox(height: 30,),
             Container(width:MediaQuery.of(context).size.width * 0.9,
               child: Stack(alignment: Alignment.center,
                 children: [
                  
                  Container(alignment:Alignment.center,
                           width: 252,
                           height: 75,
                           decoration: BoxDecoration(border:Border.all(color:currentTheme.isDarkMode
                      ? const Color(primaryLight)
                      : const Color(primaryDark),),borderRadius: BorderRadius.circular(10)),
                       child: Padding(
                         padding: const EdgeInsets.all(17.0),
                         child: Text(textAlign:TextAlign.justify,
                           'Recuerda que te enviaremos tu contrato a tu correo en maximo 30 minutos ',
                           style: TextStyle(
                             fontSize: 12,
                             color:currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(primaryDark),
                           ),
                             ),
                       ),
                     ),
                     Positioned(
                       top: 10,
                       left:26,
                       bottom: 10,
                       child: Icon(size:35,
                       Icons.attach_email_outlined, color:currentTheme.isDarkMode
                          ? const Color(primaryLight)
                          : const Color(primaryDark),),
                     ),
                   ],
                                   
                     ),
             ),
                      
           const SizedBox(height: 25,),
                
          Container(
          width: 224,
          height: 50,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color:currentTheme.isDarkMode
                  ? const Color(primaryLight)
                  : const Color(primaryDark),),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,
            
            children: [
          
            const SizedBox(height: 8),
            Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
                  'Ir a Mis Inversiones ',
                  style: TextStyle(
         
                    color:
                     currentTheme.isDarkMode
                  ? const Color(primaryDark)
                  : const Color(whiteText),
                    fontSize: 14,
                  ),
                ),
            const SizedBox(width: 5,),
             InkWell(onTap: (){ calificationExperience(context);
          },
               child:  Icon(
                         Icons.monetization_on_outlined,
                         color:
                      currentTheme.isDarkMode
                  ? const Color(primaryDark)
                  : const Color(primaryLight),
                         size: 22,
                       ),
             ),
            
             ],
          ),
        
        
         ],
            ),),
          
          ],
          ),
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
    builder: (ctx) => const calification(),
  );
}

class calification extends ConsumerWidget {
  const calification ({key});

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
                  pushName: '/investment_step3',
                ),
        
            ],
            ),
            ),
    );

  }}
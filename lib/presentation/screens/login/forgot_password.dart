import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:finniu/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:finniu/constants/colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';



class ForgotPassword extends ConsumerWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(settingsNotifierProvider);
    // final currentTheme = Provider.of<SettingsProvider>(context, listen: false);

    return CustomScaffoldReturn(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 80),
              TextPoppins(
                text: '¿Olvidaste tu contraseña?',
                colorText: Theme.of(context).textTheme.titleLarge!.color!.value,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 20),
             TextPoppins(
                text: 'No te preocupes es posible recuperarla',
                colorText: themeProvider.isDarkMode
                          ? (whiteText)
                          :(blackText),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 20),
              Container(width: 320,height: 130,
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Card(
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 50, right: 30, top: 15, bottom: 15),
                          decoration: BoxDecoration(
                            color: 
                                 Color(gradient_secondary),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: 130,
                          width: 267,
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                                textAlign: TextAlign.center,
                                style:
                                    TextStyle(fontSize: 11, color: Colors.black,height: 1.5),
                                "Por favor ingresa tu correo electrónico que ingresaste al crear tu cuenta en la App , en unos minutos recibiras un correo para recuperar tu contraseña."),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                  
                   right: 250,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: 90,
                          width: 80,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage("assets/forgotpassword/padlock.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(
                width: 224,
                height: 38,
                child: ButtonDecoration(
                    textHint: 'Escribe tu correo electrónico',
                    textLabel: "Correo electrónico"),
              ),
              const SizedBox(height: 25),
              Container(
                height: 50,
                width: 224,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color(primaryDark),
                ),
                child: const Center(
                    child: CustomButton(
                        text: 'Enviar correo',
                        // colorBackground: primaryDark,
                        // colorText: white_text,
                        pushName: '/verification')),
              
 
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GoodVerification extends ConsumerWidget {
  const GoodVerification({super.key});

   @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(settingsNotifierProvider);
    // final currentTheme = Provider.of<SettingsProvider>(context, listen: false);

    return CustomScaffoldReturn(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               SizedBox(height:
              MediaQuery.of(context).size.height * 0.1),
                  Container(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  child: Image.asset(
                    'assets/forgotpassword/padlock.png',
                    width: 67,
                    height: 75,
                  ),
                ),
              ),


              TextPoppins(
                text: 'Cambiar tu contraseña',
                colorText: Theme.of(context).textTheme.titleLarge!.color!.value,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 20),
              TextPoppins(
                text: 'Ingresa tu nueva contraseña',
                colorText: themeProvider.isDarkMode
                          ? (whiteText)
                          :(blackText),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 20),
            
             
              const SizedBox(
                width: 224,
                height: 38,
                child: ButtonDecoration(
                    textHint: 'Digita tu nueva contraseña',
                    textLabel: "Contraseña nueva"),
              ),
              const SizedBox(height: 25),
              Container(
                height: 50,
                width: 224,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color(primaryDark),
                ),
                child: const Center(
                    child: CustomButton(
                        text: 'Cambiar contraseña',
                        // colorBackground: primaryDark,
                        // colorText: white_text,
                        pushName: '/verification')),
              
 
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// final stateSucessProvider = StateNotifierProvider<SucessState, bool>((ref) {
//   return SucessState();
// });
// class SucessState extends StateNotifier<bool> {
// SucessState() : super(false);

// }

// class ForgotPassword
//  extends ConsumerWidget {
//   const ForgotPassword
//   ({super.key});
   


//   @override
//   Widget build(BuildContext context,ref  ) {
//       final sucessState= ref.watch(stateSucessProvider);


//     return Scaffold( body: sucessState? SucessPassword(): NoSucessPassword() ,
 
   
      
//    );
   
     
//   }
// }


// class SucessPassword extends ConsumerWidget {
//   const SucessPassword({super.key});

//   @override
//   Widget build(BuildContext context,ref) {
//     return 
//      Center(
//          child: Container(color: Colors.yellow,
//            child: SizedBox(
//                   width: 224,
//                   height: 50,
//                   child: TextButton(
//                     onPressed: () {
//                           ref.read(stateSucessProvider.notifier).state=false;
                
//                       }
                     
//                     ,
//                     child: Text(
//                       'boton de regreso',
//                     ),
                  
//                 )),
//          ),
//        );
  
  
  
  
//   }
// }


// class NoSucessPassword extends ConsumerWidget {
//   const NoSucessPassword({super.key});

//   @override
//   Widget build(BuildContext context,ref) {
//     return 
//        Center(
//          child: SizedBox(
//                 width: 224,
//                 height: 50,
//                 child: TextButton(
//                   onPressed: () {
//                         ref.read(stateSucessProvider.notifier).state=true;
       
//                     }
                   
//                   ,
//                   child: Text(
//                     'Exitoso',
//                   ),
                
//               )),
//        );

    
//   }
// }



 


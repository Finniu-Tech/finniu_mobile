import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../providers/settings_provider.dart';

// class ConfirmationPhone extends HookConsumerWidget {
//   const ConfirmationPhone({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // final currentTheme = ref.watch(settingsNotifierProvider);
//     final userProfileProvider = ref.watch(userProfileNotifierProvider);

//     final phoneController =
//         TextEditingController(text: userProfileProvider.phoneNumber);
//     final showError = useState(false);
//     final accountCreated = useState(false);
//     final formKey = GlobalKey<FormState>();

//     return CustomLoaderOverlay(
//       child: CustomScaffoldReturn(
//         body: Form(
//           key: formKey,
//           child: Container(
//             padding: const EdgeInsets.all(10),
//             width: double.infinity,
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   const SizedBox(height: 90),
//                   Text(
//                     'Confirmación de número telefónico',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.w600,
//                       color:
//                           Color(Theme.of(context).colorScheme.secondary.value),
//                     ),
//                   ),
//                   Stack(
//                     alignment: AlignmentDirectional.center,
//                     children: <Widget>[
//                       Positioned(
//                         child: Container(
//                           alignment: Alignment.center,
//                           width: 246,
//                           height: 99,
//                           padding: const EdgeInsets.all(15),
//                           margin: const EdgeInsets.only(top: 65),
//                           decoration: BoxDecoration(
//                             color: const Color(gradient_secondary),
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           child: Text(
//                             'Hola ${userProfileProvider.nickName} queremos enviarte un SMS de tu código de verificación por favor confirmanos tu número telefónico.',
//                             textAlign: TextAlign.center,
//                             style: const TextStyle(
//                               color: Colors.black,
//                               fontSize: 11,
//                               fontWeight: FontWeight.w400,
//                               height: 1.5,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         top: 30,
//                         // left: 160,
//                         child: Container(
//                           color: Colors.transparent,
//                           child: const Center(
//                             child: SizedBox(
//                               width: 65, // ancho deseado de la imagen
//                               height: 61, // alto deseado de la imagen
//                               child: Image(
//                                 image: AssetImage(
//                                     'assets/forgotpassword/letter.png'),
//                                 fit: BoxFit.contain,
//                               ),
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 35,
//                   ),
//                   SizedBox(
//                     width: 224,
//                     child: TextFormField(
//                       controller: phoneController,
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Este dato es requerido';
//                         }
//                         if (value.length != 9) {
//                           return 'Tiene que ser de 9 dígitos';
//                         }
//                         return null;
//                       },
//                       onChanged: (value) {},
//                       keyboardType: TextInputType.number,
//                       inputFormatters: <TextInputFormatter>[
//                         FilteringTextInputFormatter.digitsOnly
//                       ],
//                       decoration: const InputDecoration(
//                         hintText: 'Escriba su número telefónnico',
//                         label: Text('Número telefónico'),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 120,
//                   ),
//                   if (showError.value) ...[
//                     const Text(
//                       'No se pudo completar el registro',
//                       style: TextStyle(
//                         fontSize: 11,
//                         color: Colors.red,
//                       ),
//                     ),
//                   ],
//                   SizedBox(
//                     width: 224,
//                     height: 50,
//                     child: TextButton(
//                       onPressed: () async {
//                         showError.value = false;
//                         if (accountCreated.value == true) {
//                           sendSMSModal(context, ref);
//                           return;
//                         } else {
//                           // sendSMSModal(context, ref);
//                           if (formKey.currentState!.validate()) {
//                             context.loaderOverlay.show();
//                             Future<bool> status =
//                                 SignUpService().finishRegister(
//                               ref,
//                               phoneController.text.toString(),
//                             );
//                             status.then((value) {
//                               if (value == false) {
//                                 showError.value = true;
//                               } else {
//                                 accountCreated.value = true;
//                                 context.loaderOverlay.hide();
//                                 ref
//                                     .read(timerCounterDownProvider.notifier)
//                                     .startTimer(first: true);

//                                 sendSMSModal(context, ref);
//                               }
//                               context.loaderOverlay.hide();
//                             });
//                           }
//                         }
//                       },
//                       child: Text(accountCreated.value == true
//                           ? 'Enviar SMS'
//                           : 'Registrar'),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class SendCode extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(settingsNotifierProvider);
    return CustomScaffoldReturn(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Espacio vacío para mover el contenido hacia arriba
            const SizedBox(height: 40),

            SizedBox(
              width: 291,
              height: 71,
              child: TextPoppins(
                text: "Tu seguridad es primero",
                colorText:
                    themeProvider.isDarkMode ? primaryLight : primaryDark,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(
              height: 18,
            ),
            const SizedBox(
              width: 118,
              height: 95.62,
              child: Image(
                image: AssetImage('assets/sendcode/send_code.png'),
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            SizedBox(
              width: 280,
              height: 60,
              child: Text(
                textAlign: TextAlign.center,
                'Te enviaremos el código de verificación por correo',
                style: TextStyle(
                  fontSize: 14,
                  color: themeProvider.isDarkMode
                      ? const Color(whiteText)
                      : const Color(primaryDark),
                ),
              ),
            ),
            SizedBox(
              width: 224,
              height: 50,
              child: TextButton(
                onPressed: () async {
                  Navigator.of(context).pushNamed('/activate_account');
                },
                child: const Text(
                  'Recibir Código',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(
              height: 65,
            )
          ],
        ),
      ),
    );
  }
}

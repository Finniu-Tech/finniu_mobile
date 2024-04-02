// I need a bottomSheetModal where  start with a image at center top, then have a title  , then it show two button bottom, one for cancel and other for accept

import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void reinvestmentQuestionModal(BuildContext ctx, WidgetRef ref) {
  final themeProvider = ref.watch(settingsNotifierProvider);
  // final themeProvider = Provider.of<SettingsProvider>(ctx, listen: false);
  showModalBottomSheet(
    clipBehavior: Clip.antiAlias,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(50),
        topLeft: Radius.circular(50),
      ),
    ),
    elevation: 10,
    backgroundColor: themeProvider.isDarkMode ? const Color(primaryDark) : const Color(cardBackgroundColorLight),
    context: ctx,
    builder: (ctx) => ReinvestmentQuestionBody(themeProvider: themeProvider),
  );
}

class ReinvestmentQuestionBody extends HookConsumerWidget {
  const ReinvestmentQuestionBody({
    super.key,
    required this.themeProvider,
  });

  final SettingsProviderState themeProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.90,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 15),
            SizedBox(
              width: 88, // ancho deseado
              height: 6,

              child: Container(
                decoration: BoxDecoration(
                  color: Color(
                    themeProvider.isDarkMode ? primaryLight : primaryDark,
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // alto deseado
            SizedBox(
              width: 90,
              height: 90,
              child: Image.asset('assets/images/padlock.png'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 280,
              child: Text(
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                  color: themeProvider.isDarkMode ? Colors.white : const Color(primaryDark),
                ),
                "¿Desea reinvertir su capital?",
              ),
            ),
            SizedBox(
              width: 280,
              child: Text(
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                  color: themeProvider.isDarkMode ? Colors.white : const Color(primaryDark),
                ),
                "Al reinvertir su capital, se generará un nuevo contrato con el capital reinvertido",
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    backgroundColor: Color(
                      themeProvider.isDarkMode ? primaryLight : primaryDark,
                    ),
                  ),
                  child: Text(
                    'Cancelar',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      color: themeProvider.isDarkMode ? Color(primaryDark) : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

// void sendEmailRecoveryPasswordModal(BuildContext ctx, WidgetRef ref) {
//   final themeProvider = ref.watch(settingsNotifierProvider);
//   // final themeProvider = Provider.of<SettingsProvider>(ctx, listen: false);
//   showModalBottomSheet(
//     clipBehavior: Clip.antiAlias,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.only(
//         topRight: Radius.circular(50),
//         topLeft: Radius.circular(50),
//       ),
//     ),
//     elevation: 10,
//     backgroundColor: themeProvider.isDarkMode ? const Color(primaryDark) : const Color(cardBackgroundColorLight),
//     context: ctx,
//     builder: (ctx) => SMSBody(themeProvider: themeProvider),
//   );
// }

// class SMSBody extends HookConsumerWidget {
//   const SMSBody({
//     super.key,
//     required this.themeProvider,
//   });

//   final SettingsProviderState themeProvider;

//   @override
//   Widget build(BuildContext ctx, ref) {
//     final UserProfile userProfile = ref.watch(userProfileNotifierProvider);

//     return SizedBox(
//       height: MediaQuery.of(ctx).size.height * 0.90,
//       width: double.infinity,
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             const SizedBox(height: 15),
//             SizedBox(
//               width: 88, // ancho deseado
//               height: 6,

//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Color(
//                     themeProvider.isDarkMode ? primaryLight : primaryDark,
//                   ),
//                   borderRadius: BorderRadius.circular(25),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             // alto deseado
//             SizedBox(
//               width: 90,
//               height: 90,
//               child: Image.asset('assets/images/padlock.png'),
//             ),
//             const SizedBox(height: 20),
//             SizedBox(
//               width: 280,
//               child: Text(
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   height: 1.5,
//                   color: themeProvider.isDarkMode ? Colors.white : const Color(primaryDark),
//                 ),
//                 "Ingresa el código de verificacion",
//               ),
//             ),
//             SizedBox(
//               width: 280,
//               child: Text(
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 11,
//                   fontWeight: FontWeight.w500,
//                   height: 1.5,
//                   color: themeProvider.isDarkMode ? Colors.white : const Color(primaryDark),
//                 ),
//                 "Te hemos enviado un código a tu correo para confirmar la operación",
//               ),
//             ),
//             const SizedBox(height: 10),
//             VerificationCode(
//               onCompleted: (code) {
//                 final futureIsValidCode = ref.watch(
//                   otpValidatorFutureProvider(
//                     OTPForm(
//                       email: userProfile.email!,
//                       otp: code,
//                       action: 'recovery_password',
//                     ),
//                   ).future,
//                 );
//                 futureIsValidCode.then((status) {
//                   if (status == true) {
//                     Navigator.of(ctx).pushNamed('/set_new_password');
//                   } else {
//                     Navigator.of(ctx).pop();
//                     CustomSnackbar.show(
//                       ctx,
//                       'No se pudo validar el código de verificación',
//                       'error',
//                     );
//                     // ScaffoldMessenger.of(ctx).showSnackBar(
//                     //   customSnackBar(
//                     //       'No se pudo validar el código de verificación',
//                     //       'error'),
//                     // );
//                   }
//                 });
//               },
//               onEditing: (value) {},
//               textStyle: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: themeProvider.isDarkMode ? Colors.white : const Color(blackText),
//               ),

//               keyboardType: TextInputType.number,
//               underlineColor: const Color(
//                 0xff9381FF,
//               ), // If this is null it will use primaryColor: Colors.red from Theme
//               underlineUnfocusedColor: Color(
//                 themeProvider.isDarkMode ? primaryLight : primaryDark,
//               ),
//               length: 4,
//               fullBorder: true,
//               cursorColor: Colors.blue, // If this is null it will default to the ambient
//               itemSize: 70,
//             ),

//             const SizedBox(height: 15),
//             if (ref.watch(timerCounterDownProvider) == 0) ...[
//               TextButton(
//                 onPressed: () {
//                   ref.read(timerCounterDownProvider.notifier).resetTimer();

//                   ref.read(resendOTPCodeFutureProvider.future).then((status) {
//                     if (status == true) {
//                       ref.read(timerCounterDownProvider.notifier).startTimer(first: true);
//                     } else {
//                       CustomSnackbar.show(
//                         ctx,
//                         'No se pudo reenviar el correo',
//                         "error",
//                       );
//                       // ScaffoldMessenger.of(ctx).showSnackBar(
//                       //   customSnackBar('No se pudo reenviar el correo', 'error'),
//                       // );
//                     }
//                   });
//                 },
//                 style: TextButton.styleFrom(
//                   padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
//                   backgroundColor: Color(
//                     themeProvider.isDarkMode ? primaryLight : primaryDark,
//                   ),
//                 ),
//                 child: Text(
//                   'Reenviar código',
//                   style: TextStyle(
//                     fontSize: 11,
//                     fontWeight: FontWeight.w500,
//                     height: 1.5,
//                     color: themeProvider.isDarkMode ? Color(primaryDark) : Colors.white,
//                   ),
//                 ),
//               ),
//             ] else ...[
//               SizedBox(
//                 width: 280,
//                 child: Text(
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 11,
//                     fontWeight: FontWeight.w500,
//                     height: 1.5,
//                     color: themeProvider.isDarkMode ? Colors.white : const Color(primaryDark),
//                   ),
//                   "Reenviar el codigo en",
//                 ),
//               ),
//               const SizedBox(height: 10),
//               const CircularCountdown(),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }
}

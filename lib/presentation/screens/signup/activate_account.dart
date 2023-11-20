
import 'package:finniu/constants/colors.dart';
import 'package:finniu/infrastructure/models/user.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ActivateAccount extends HookConsumerWidget {
  const ActivateAccount({
    Key? key, // Corregir aquí
    // Required this.themeProvider,
  }) : super(key: key); // Corregir aquí

  // final SettingsProviderState themeProvider; // Si no se usa, puedes eliminar esta línea

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(settingsNotifierProvider);
    final UserProfile userProfile = ref.watch(userProfileNotifierProvider);

    return CustomScaffoldReturn(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 15),
              SizedBox(
                width: 88, // ancho deseado
                height: 6,

                child: Container(
                  decoration: BoxDecoration(
                    color: Color(
                        themeProvider.isDarkMode ? primaryLight : primaryDark),
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
                    color: themeProvider.isDarkMode
                        ? Colors.white
                        : const Color(primaryDark),
                  ),
                  "Ingresa el codigo de verificacion",
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
                      color: themeProvider.isDarkMode
                          ? Colors.white
                          : const Color(primaryDark),
                    ),
                    "Te hemos enviado un SMS a tu numero para confirmar la operacion"),
              ),
              const SizedBox(height: 10),
              // VerificationCode(
              //   onCompleted: (code) {
              //     final futureIsValidCode = ref.watch(
              //       otpValidatorFutureProvider(
              //         OTPForm(
              //           email: userProfile.email!,
              //           otp: code,
              //           action: 'register',
              //         ),
              //       ).future,
              //     );
              //     futureIsValidCode.then((status) {
              //       if (status == true) {
              //         Preferences.username = userProfile.email!;
              //         Navigator.pushNamedAndRemoveUntil(
              //           ctx,
              //           '/on_boarding_start',
              //           (route) => false, // Remove all the previous routes
              //         );
              //       } else {
              //         Navigator.of(ctx).pop();
              //         CustomSnackbar.show(
              //           ctx,
              //           'No se pudo validar el código de verificación',
              //           'error',
              //         );
              //       }
              //     });
              //   },
              //   onEditing: (value) {},
              //   textStyle: TextStyle(
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //     color: themeProvider.isDarkMode
              //         ? Colors.white
              //         : const Color(blackText),
              //   ),

              //   keyboardType: TextInputType.number,
              //   underlineColor: const Color(
              //     0xff9381FF,
              //   ), // If this is null it will use primaryColor: Colors.red from Theme
              //   underlineUnfocusedColor: Color(
              //     themeProvider.isDarkMode ? primaryLight : primaryDark,
              //   ),
              //   length: 4,
              //   fullBorder: true,
              //   cursorColor:
              //       Colors.blue, // If this is null it will default to the ambient
              //   itemSize: 70,
              // ),

              // const SizedBox(height: 15),
              // if (ref.watch(timerCounterDownProvider) == 0) ...[
              //   TextButton(
              //     onPressed: () {
              //       ref.read(timerCounterDownProvider.notifier).resetTimer();

              //       ref.read(resendOTPCodeFutureProvider.future).then((status) {
              //         if (status == true) {
              //           ref
              //               .read(timerCounterDownProvider.notifier)
              //               .startTimer(first: true);
              //         } else {
              //           CustomSnackbar.show(
              //             ctx,
              //             'No se pudo reenviar el correo',
              //             'error',
              //           );
              //           // ScaffoldMessenger.of(ctx).showSnackBar(
              //           //   customSnackBar('No se pudo reenviar el correo', 'error'),
              //           // );
              //         }
              //       });
              //     },
              // style: TextButton.styleFrom(
              //   padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              //   backgroundColor: Color(
              //       themeProvider.isDarkMode ? primaryLight : primaryDark),
              // ),
              //       child: Text(
              //         'Reenviar código',
              //         style: TextStyle(
              //           fontSize: 11,
              //           fontWeight: FontWeight.w500,
              //           height: 1.5,
              //           color: themeProvider.isDarkMode
              //               ? Color(primaryDark)
              //               : Colors.white,
              //         ),
              //       ),
              //     ),
              //   ] else ...[
              //     SizedBox(
              //       width: 280,
              //       child: Text(
              //         textAlign: TextAlign.center,
              //         style: TextStyle(
              //           fontSize: 11,
              //           fontWeight: FontWeight.w500,
              //           height: 1.5,
              //           color: themeProvider.isDarkMode
              //               ? Colors.white
              //               : const Color(primaryDark),
              //         ),
              //         "Reenviar el codigo en",
              //       ),
              //     ),
              //     const SizedBox(height: 10),
              //     const CircularCountdown(),
              //   ],
              // ],
            ]),
      ),
    );
  }
}

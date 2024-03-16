import 'package:finniu/constants/colors.dart';
import 'package:finniu/infrastructure/models/otp.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/otp_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/timer_counterdown_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/signup/widgets/counter.dart';
import 'package:finniu/services/share_preferences_service.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:finniu/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ActivateAccount extends HookConsumerWidget {
  const ActivateAccount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(settingsNotifierProvider);
    final user = ref.watch(userProfileNotifierProvider);
    final client = ref.watch(gqlClientProvider);

    return CustomScaffoldReturn(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: 291,
                  height: 92,
                  child: TextPoppins(
                    text: "Activa tu cuenta en segundos", //
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    colorText: themeProvider.isDarkMode ? primaryLight : primaryDark,

                    // Aquí añade el texto dentro de 'text'
                  ),
                ),
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
                    "Ingresa el código de verificación",
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                    "Te hemos enviado el código a tu correo para confirmar la operacion",
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                VerificationCodeWidget(),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 133,
                  child: Text(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        color: themeProvider.isDarkMode ? Colors.white : const Color(primaryDark),
                      ),
                      "Reenviar el código en "),
                ),
                const SizedBox(
                  height: 15,
                ),
                if (ref.watch(timerCounterDownProvider) == 0) ...[
                  TextButton(
                    onPressed: () async {
                      ref.read(timerCounterDownProvider.notifier).resetTimer();

                      client.when(
                        data: (client) async {
                          final result = await (sendEmailOTPCode(user.email!, client));

                          if (result == true) {
                            ref.read(timerCounterDownProvider.notifier).startTimer(first: true);
                          } else {
                            CustomSnackbar.show(
                              context,
                              'No se pudo reenviar el correo',
                              'error',
                            );
                          }
                        },
                        error: (error, stackTrace) => null,
                        loading: () => null,
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                      backgroundColor: Color(themeProvider.isDarkMode ? primaryLight : primaryDark),
                    ),
                    child: Text(
                      'Reenviar código',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        color: themeProvider.isDarkMode ? Color(primaryDark) : Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ] else ...[
                  const CircularCountdown(),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VerificationCodeWidget extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(settingsNotifierProvider);
    final userProfile = ref.watch(userProfileNotifierProvider);

    return Center(
        child: Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: VerificationCode(
        fullBorder: true,
        textStyle: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: themeProvider.isDarkMode ? Colors.white : const Color(primaryDark),
        ),
        keyboardType: TextInputType.number,
        underlineColor: const Color(
          0xff9381FF,
        ),
        underlineUnfocusedColor: Color(
          themeProvider.isDarkMode ? primaryLight : primaryDark,
        ),
        length: 4,
        itemSize: 50,
        cursorColor: Colors.blue,
        onCompleted: (code) {
          final futureIsValidCode = ref.watch(
            otpValidatorFutureProvider(
              OTPForm(
                email: userProfile.email!,
                otp: code,
                action: 'register',
              ),
            ).future,
          );
          futureIsValidCode.then((status) {
            if (status == true) {
              Preferences.username = userProfile.email!;
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/on_boarding_start',
                (route) => false, // Remove all the previous routes
              );
            } else {
              Navigator.of(context).pop();
              CustomSnackbar.show(
                context,
                'No se pudo validar el código de verificación',
                'error',
              );
            }
          });
        },
        onEditing: (bool value) {},
      ),
    ));
  }
}

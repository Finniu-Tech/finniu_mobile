import 'package:finniu/constants/colors.dart';
import 'package:finniu/infrastructure/models/otp.dart';
import 'package:finniu/infrastructure/models/user.dart';
import 'package:finniu/presentation/providers/otp_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/timer_counterdown_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/signup/widgets/counter.dart';
import 'package:finniu/services/share_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void sendSMSModal(BuildContext ctx, WidgetRef ref) {
  final themeProvider = ref.watch(settingsNotifierProvider);
  showModalBottomSheet(
    isDismissible: false,
    clipBehavior: Clip.antiAlias,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(50),
        topLeft: Radius.circular(50),
      ),
    ),
    elevation: 10,
    backgroundColor: themeProvider.isDarkMode
        ? const Color(primaryDark)
        : const Color(cardBackgroundColorLight),
    context: ctx,
    isScrollControlled: true,
    builder: (ctx) => SMSBody(themeProvider: themeProvider),
  );
}

class SMSBody extends HookConsumerWidget {
  const SMSBody({
    super.key,
    required this.themeProvider,
  });

  final SettingsProviderState themeProvider;

  @override
  Widget build(BuildContext context, ref) {
    final UserProfile userProfile = ref.watch(userProfileNotifierProvider);

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.90,
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
              "Te hemos enviado un SMS a tu numero para confirmar la operacion",
            ),
          ),
          const SizedBox(height: 10),
          VerificationCode(
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
                  showSnackBarV2(
                    context: context,
                    title: "Error de validación",
                    message: 'No se pudo validar el código de verificación',
                    snackType: SnackType.error,
                  );
                }
              });
            },
            onEditing: (value) {},
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: themeProvider.isDarkMode
                  ? Colors.white
                  : const Color(blackText),
            ),

            keyboardType: TextInputType.number,
            underlineColor: const Color(
              0xff9381FF,
            ), // If this is null it will use primaryColor: Colors.red from Theme
            underlineUnfocusedColor: Color(
              themeProvider.isDarkMode ? primaryLight : primaryDark,
            ),
            length: 4,
            fullBorder: true,
            cursorColor:
                Colors.blue, // If this is null it will default to the ambient
            itemSize: 70,
          ),

          const SizedBox(height: 15),
          if (ref.watch(timerCounterDownProvider) == 0) ...[
            TextButton(
              onPressed: () {
                ref.read(timerCounterDownProvider.notifier).resetTimer();

                ref.read(resendOTPCodeFutureProvider.future).then((status) {
                  if (status == true) {
                    ref
                        .read(timerCounterDownProvider.notifier)
                        .startTimer(first: true);
                  } else {
                    showSnackBarV2(
                      context: context,
                      title: "Error al reenviar el correo",
                      message: 'No se pudo reenviar el correo',
                      snackType: SnackType.error,
                    );
                  }
                });
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                backgroundColor: Color(
                  themeProvider.isDarkMode ? primaryLight : primaryDark,
                ),
              ),
              child: Text(
                'Reenviar código',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                  color: themeProvider.isDarkMode
                      ? const Color(primaryDark)
                      : Colors.white,
                ),
              ),
            ),
          ] else ...[
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
                "Reenviar el codigo en",
              ),
            ),
            const SizedBox(height: 10),
            const CircularCountdown(),
          ],
        ],
      ),
    );
  }
}

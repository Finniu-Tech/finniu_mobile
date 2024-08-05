import 'package:finniu/constants/colors.dart';
import 'package:finniu/infrastructure/models/otp.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/otp_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/timer_counterdown_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/catalog/widgets/user_profil_v2/scafold_user_profil.dart';
import 'package:finniu/presentation/screens/signup/widgets/counter.dart';
import 'package:finniu/services/share_preferences_service.dart';
import 'package:finniu/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ActivateAccountV2 extends HookConsumerWidget {
  const ActivateAccountV2({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(settingsNotifierProvider);
    final user = ref.watch(userProfileNotifierProvider);
    final client = ref.watch(gqlClientProvider);
    const int titleDark = 0xffA2E6FA;
    const int titleLight = 0xff0D3A5C;
    const int subTitleDark = 0xffFFFFFF;
    const int subTitleLight = 0xff0D3A5C;

    return ScaffoldUserProfile(children: [
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const TextPoppins(
              text: "Activa tu cuenta en segundos",
              fontSize: 24,
              textDark: titleDark,
              textLight: titleLight,
              lines: 2,
              align: TextAlign.center,
            ),
            Image.asset(
              'assets/images/padlock.png',
              width: 100,
              height: 100,
            ),
            const TextPoppins(
              text: "Ingresa el código de verificación",
              fontSize: 16,
              textDark: subTitleDark,
              textLight: subTitleLight,
              isBold: true,
              align: TextAlign.center,
            ),
            const TextPoppins(
              text:
                  "Te hemos enviado el código a tu correo para confirmar la operación",
              fontSize: 12,
              textDark: subTitleDark,
              textLight: subTitleLight,
              isBold: false,
              align: TextAlign.center,
              lines: 2,
            ),
            const VerificationCodeV2(),
            if (ref.watch(timerCounterDownProvider) == 0) ...[
              TextButton(
                onPressed: () async {
                  ref.read(timerCounterDownProvider.notifier).resetTimer();

                  client.when(
                    data: (client) async {
                      final result =
                          await (sendEmailOTPCode(user.email!, client));

                      if (result == true) {
                        ref
                            .read(timerCounterDownProvider.notifier)
                            .startTimer(first: true);
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
              const SizedBox(
                height: 15,
              ),
            ] else ...[
              const CircularCountdown(),
            ],
          ],
        ),
      )
    ]);
  }
}

class VerificationCodeV2 extends HookConsumerWidget {
  const VerificationCodeV2({super.key});

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
            color: themeProvider.isDarkMode
                ? Colors.white
                : const Color(primaryDark),
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
      ),
    );
  }
}

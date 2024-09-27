import 'package:finniu/constants/colors.dart';
import 'package:finniu/infrastructure/models/otp.dart';
import 'package:finniu/presentation/providers/otp_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/timer_counterdown_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/activate_account_v2.dart/widgets/verification_code_v2.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

void sendEmailRecoveryPasswordModalV2(BuildContext ctx, WidgetRef ref) {
  final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
  // final themeProvider = Provider.of<SettingsProvider>(ctx, listen: false);
  const int backgroudDark = 0xff1A1A1A;
  const int backgroudLight = 0xffFFFFFF;
  showModalBottomSheet(
    isDismissible: false,
    isScrollControlled: true,
    clipBehavior: Clip.antiAlias,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(50),
        topLeft: Radius.circular(50),
      ),
    ),
    elevation: 10,
    backgroundColor:
        isDarkMode ? const Color(backgroudDark) : const Color(backgroudLight),
    context: ctx,
    builder: (ctx) => const SMSBody(),
  );
}

class SMSBody extends HookConsumerWidget {
  const SMSBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int titleDark = 0xffA2E6FA;
    const int titleLight = 0xff0D3A5C;
    const int lineColor = 0xffD9D9D9;

    final ValueNotifier<bool?> isValidated = useState<bool?>(null);

    void reSendEmail() {
      context.loaderOverlay.show();
      ref.read(timerCounterDownProvider.notifier).resetTimer();

      ref.read(resendOTPCodeFutureProvider.future).then((status) {
        if (status == true) {
          ref.read(timerCounterDownProvider.notifier).startTimer(first: true);
        } else {
          showSnackBarV2(
            context: context,
            title: "Error al reenviar el correo",
            message: 'No se pudo reenviar el correo',
            snackType: SnackType.error,
          );
        }
      });

      context.loaderOverlay.hide();
    }

    useEffect(
      () {
        return null;
      },
      [isValidated.value],
    );
    void isComplete(String code) {
      final userProfile = ref.read(userProfileNotifierProvider);
      context.loaderOverlay.show();
      final futureIsValidCode = ref.watch(
        otpValidatorFutureProvider(
          OTPForm(
            email: userProfile.email!,
            otp: code,
            action: 'recovery_password',
          ),
        ).future,
      );
      futureIsValidCode.then((status) {
        if (status == true) {
          isValidated.value = true;
          Navigator.of(context).pushNamed('/v2/set_new_password');
        } else {
          isValidated.value = false;
        }

        context.loaderOverlay.hide();
        Future.delayed(const Duration(seconds: 2), () {
          isValidated.value = null;
        });
      });
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.8,
      child: LoaderOverlay(
        useDefaultLoading: false,
        overlayWidgetBuilder: (progress) {
          return const Center(
            child: CircularLoader(
              width: 50,
              height: 50,
            ),
          );
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 15),
              SizedBox(
                width: 101,
                height: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(lineColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // alto deseado
              SizedBox(
                width: 90,
                height: 90,
                child: Image.asset('assets/images/padlock.png'),
              ),
              const SizedBox(height: 10),
              const TextPoppins(
                text: "Ingresa el código de verificación",
                fontSize: 16,
                textDark: titleDark,
                textLight: titleLight,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(height: 10),
              const SizedBox(
                width: 270,
                child: TextPoppins(
                  text:
                      "Te hemos enviado el código a tu correo para confirmar la operación",
                  fontSize: 12,
                  textDark: titleDark,
                  textLight: titleLight,
                  lines: 2,
                  align: TextAlign.center,
                ),
              ),

              const SizedBox(height: 10),
              VeridicationCodePasswordV2(
                onCompleted: isComplete,
              ),

              const SizedBox(height: 10),
              if (ref.watch(timerCounterDownProvider) == 0) ...[
                ButtonInvestment(
                  text: 'Reenviar código',
                  onPressed: () => reSendEmail(),
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
                      color:
                          isDarkMode ? Colors.white : const Color(primaryDark),
                    ),
                    "Reenviar el codigo en",
                  ),
                ),
                const SizedBox(height: 10),
                const CircularCountdownV2(),
                const SizedBox(height: 10),
              ],
              const SizedBox(
                height: 20,
              ),
              ...{
                isValidated.value == null
                    ? const SizedBox()
                    : isValidated.value == true
                        ? const SnackBarContainerV2(
                            title: '¡Validación exitosa!',
                            snackType: SnackType.success,
                            message: 'Tu cuenta ha sido validada con éxito.',
                          )
                        : const SnackBarContainerV2(
                            title: 'Código inválido',
                            snackType: SnackType.warning,
                            message:
                                'Solicita un nuevo código e ingrésalo otra vez.',
                          ),
              },
            ],
          ),
        ),
      ),
    );
  }
}

class VeridicationCodeV2 extends HookConsumerWidget {
  const VeridicationCodeV2({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProfileNotifierProvider);
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int borderDark = 0xff9381FF;
    const int borderLight = 0xff0D3A5C;
    const int borderSelectDark = 0xffA2E6FA;
    const int borderSelectLight = 0xff9381FF;
    return VerificationCode(
      onEditing: (value) {},
      onCompleted: (code) {
        context.loaderOverlay.show();
        final futureIsValidCode = ref.watch(
          otpValidatorFutureProvider(
            OTPForm(
              email: userProfile.email!,
              otp: code,
              action: 'recovery_password',
            ),
          ).future,
        );
        futureIsValidCode.then((status) {
          if (status == true) {
            showSnackBarV2(
              context: context,
              title: "¡Validación exitosa! ",
              message: 'Tu cuenta ha sido validada con éxito.',
              snackType: SnackType.success,
            );
            Navigator.of(context).pushNamed('/v2/set_new_password');
          } else {
            showSnackBarV2(
              context: context,
              title: "Error al validar el código de verificación",
              message: 'No se pudo validar el código de verificación',
              snackType: SnackType.error,
            );
          }

          context.loaderOverlay.hide();
        });
      },
      underlineWidth: 1.5,
      margin: const EdgeInsets.all(3),
      padding: const EdgeInsets.all(3),
      digitsOnly: true,
      keyboardType: TextInputType.number,
      length: 4,
      itemSize: 50,
      fullBorder: true,
      cursorColor:
          isDarkMode ? const Color(borderDark) : const Color(borderLight),
      underlineUnfocusedColor:
          isDarkMode ? const Color(borderDark) : const Color(borderLight),
      underlineColor: isDarkMode
          ? const Color(borderSelectDark)
          : const Color(borderSelectLight),
    );
  }
}

class VeridicationCodePasswordV2 extends HookConsumerWidget {
  const VeridicationCodePasswordV2({
    super.key,
    required this.onCompleted,
  });

  final void Function(String) onCompleted;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int borderDark = 0xff9381FF;
    const int borderLight = 0xff0D3A5C;
    const int borderSelectDark = 0xffA2E6FA;
    const int borderSelectLight = 0xff9381FF;
    return VerificationCode(
      onEditing: (value) {},
      onCompleted: (code) {
        onCompleted(code);
      },
      underlineWidth: 1.5,
      margin: const EdgeInsets.all(3),
      padding: const EdgeInsets.all(3),
      digitsOnly: true,
      keyboardType: TextInputType.number,
      length: 4,
      itemSize: 50,
      fullBorder: true,
      cursorColor:
          isDarkMode ? const Color(borderDark) : const Color(borderLight),
      underlineUnfocusedColor:
          isDarkMode ? const Color(borderDark) : const Color(borderLight),
      underlineColor: isDarkMode
          ? const Color(borderSelectDark)
          : const Color(borderSelectLight),
    );
  }
}

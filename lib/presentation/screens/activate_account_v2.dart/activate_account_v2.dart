import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/otp_provider.dart';
import 'package:finniu/presentation/providers/timer_counterdown_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/activate_account_v2.dart/widgets/verification_code_v2.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/catalog/widgets/user_profil_v2/scafold_user_profile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ActivateAccountV2 extends HookConsumerWidget {
  const ActivateAccountV2({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProfileNotifierProvider);
    final client = ref.watch(gqlClientProvider);
    const int titleDark = 0xffA2E6FA;
    const int titleLight = 0xff0D3A5C;
    const int subTitleDark = 0xffFFFFFF;
    const int subTitleLight = 0xff0D3A5C;

    void sendCode() {
      ref.read(timerCounterDownProvider.notifier).resetTimer();

      client.when(
        data: (client) async {
          final result = await (sendEmailOTPCode(user.email!, client));

          if (result == true) {
            ref.read(timerCounterDownProvider.notifier).startTimer(first: true);
          } else {
            showSnackBarV2(
              context: context,
              title: "Error al enviar el correo",
              message: 'No se pudo enviar el correo',
              snackType: SnackType.error,
            );
          }
        },
        error: (error, stackTrace) => null,
        loading: () => null,
      );
    }

    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (progress) {
        return const Center(
          child: CircularLoader(
            width: 50,
            height: 50,
          ),
        );
      },
      child: ScaffoldUserProfile(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TextPoppins(
                  text: "Activa tu cuenta en segundos",
                  fontSize: 24,
                  textDark: titleDark,
                  textLight: titleLight,
                  lines: 2,
                  align: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Image.asset(
                  'assets/images/padlock.png',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(
                  height: 20,
                ),
                const TextPoppins(
                  text: "Ingresa el código de verificación",
                  fontSize: 16,
                  textDark: subTitleDark,
                  textLight: subTitleLight,
                  isBold: true,
                  align: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
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
                const SizedBox(
                  height: 20,
                ),
                const VerificationCodeV2(),
                const SizedBox(
                  height: 20,
                ),
                if (ref.watch(timerCounterDownProvider) == 0) ...[
                  ButtonInvestment(
                    text: "Reenviar correo",
                    onPressed: () async => sendCode(),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ] else ...[
                  const TextPoppins(
                    text: "Reenviar el código en ",
                    fontSize: 11,
                    textDark: subTitleDark,
                    textLight: subTitleLight,
                    isBold: false,
                    align: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const CircularCountdownV2(),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

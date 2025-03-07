import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/otp_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/catalog/widgets/user_profil_v2/scafold_user_profile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SendCodeV2 extends ConsumerWidget {
  const SendCodeV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileProvider = ref.watch(userProfileNotifierProvider);
    final graphQLClient = ref.watch(gqlClientProvider);

    const int titleDark = 0xffA2E6FA;
    const int titleLight = 0xff0D3A5C;
    const int subTitleDark = 0xffFFFFFF;
    const int subTitleLight = 0xff0D3A5C;

    return ScaffoldUserProfile(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/safety_first_image.png",
                width: 162,
                height: 128,
              ),
              const SizedBox(
                height: 20,
              ),
              const TextPoppins(
                text: "Tu seguridad es primero",
                fontSize: 24,
                textDark: titleDark,
                textLight: titleLight,
                align: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              const TextPoppins(
                text: "Te enviaremos el código de verificación por correo ",
                fontSize: 14,
                lines: 2,
                textDark: subTitleDark,
                textLight: subTitleLight,
                align: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              ButtonInvestment(
                text: "Recibir código ",
                onPressed: () {
                  context.loaderOverlay.show();

                  graphQLClient.when(
                    data: (client) async {
                      final result = await sendEmailOTPCode(
                        userProfileProvider.email!,
                        client,
                      );

                      if (result == true) {
                        context.loaderOverlay.hide();
                        ref
                            .read(firebaseAnalyticsServiceProvider)
                            .logCustomEvent(
                          eventName: FirebaseAnalyticsEvents.pushDataSucces,
                          parameters: {
                            "screen": FirebaseScreen.sendCodeV2,
                            "navigate_to": FirebaseScreen.activateAccountV2,
                            "send_email": "email_true",
                          },
                        );
                        Navigator.of(context).pushNamed('v2/activate_account');
                      } else {
                        ref
                            .read(firebaseAnalyticsServiceProvider)
                            .logCustomEvent(
                          eventName: FirebaseAnalyticsEvents.pushDataError,
                          parameters: {
                            "screen": FirebaseScreen.sendCodeV2,
                            "send_email": "email_false",
                          },
                        );
                        showSnackBarV2(
                          context: context,
                          title: "Error al enviar el correo",
                          message: 'No se pudo enviar el correo',
                          snackType: SnackType.error,
                        );
                      }
                    },
                    loading: () => null,
                    error: (error, stackTrace) => null,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

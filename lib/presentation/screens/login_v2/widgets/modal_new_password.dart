import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void modalNewPassword(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const _BodyDialog();
    },
  );
}

class _BodyDialog extends ConsumerWidget {
  const _BodyDialog();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff1A1A1A;
    const int backgroundLight = 0xffF9FAFA;
    const int iconDark = 0xff0DCB6C;
    const int iconLight = 0xff008F47;
    const String title = "Guardado con exito!";
    const String subTitle =
        "Tu contraseña ha sido actualizada correctamente, puedes ingresar a la app nuevamente";
    return Dialog(
      backgroundColor: isDarkMode
          ? const Color(backgroundDark)
          : const Color(backgroundLight),
      child: SizedBox(
        height: 320,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 40,
                color:
                    isDarkMode ? const Color(iconDark) : const Color(iconLight),
              ),
              const TextPoppins(
                text: title,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                align: TextAlign.center,
              ),
              const TextPoppins(
                text: subTitle,
                fontSize: 14,
                align: TextAlign.center,
                lines: 4,
              ),
              ButtonInvestment(
                text: 'Ir a inicio de sesión',
                onPressed: () => {
                  ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
                    eventName: FirebaseAnalyticsEvents.navigateTo,
                    parameters: {
                      "screen": FirebaseScreen.setNewPasswordV2,
                      "navigate_to": FirebaseScreen.loginEmailV2
                    },
                  ),
                  Navigator.pushNamed(context, '/v2/login_email'),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

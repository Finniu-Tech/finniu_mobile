// import 'package:finniu/presentation/providers/graphql_provider.dart';
// import 'package:finniu/presentation/providers/settings_provider.dart';
// import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/catalog/widgets/user_profil_v2/scafold_user_profil.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SendCodeV2 extends ConsumerWidget {
  const SendCodeV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final themeProvider = ref.watch(settingsNotifierProvider);
    // final userProfileProvider = ref.watch(userProfileNotifierProvider);
    // final graphQLClient = ref.watch(gqlClientProvider);

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
              ),
              const SizedBox(
                height: 20,
              ),
              ButtonInvestment(text: "Recibir código ", onPressed: () {}),
            ],
          ),
        ),
      ],
    );
  }
}

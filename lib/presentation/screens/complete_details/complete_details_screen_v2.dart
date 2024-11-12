import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/catalog/widgets/user_profil_v2/scafold_user_profile.dart';
import 'package:finniu/presentation/screens/complete_details/widgets/app_bar_logo.dart';
import 'package:finniu/presentation/screens/complete_details/widgets/dotted_vertical_line.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CompleteDetailsScreenV2 extends StatelessWidget {
  const CompleteDetailsScreenV2({super.key});
  final String textTitle = "Activa tu cuenta y comienza a invertir!";
  final String textBody =
      "Completa tus datos ahora y comencemos juntos este emocionante viaje de inversiones";
  final int titleDark = 0xffA2E6FA;
  final int titleLight = 0xff0D3A5C;
  final int bodyDark = 0xffFFFFFF;
  final int bodyLight = 0xff000000;

  @override
  Widget build(BuildContext context) {
    return ScaffoldUserProfile(
      appBar: const AppBarLogo(),
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  "assets/images/document_image_v2.png",
                  width: 183,
                  height: 130,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextPoppins(
                text: textTitle,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                lines: 2,
                textDark: titleDark,
                textLight: titleLight,
              ),
              const SizedBox(
                height: 10,
              ),
              TextPoppins(
                text: textBody,
                fontSize: 14,
                lines: 2,
                align: TextAlign.start,
                textDark: bodyDark,
                textLight: bodyLight,
              ),
              const SizedBox(
                height: 30,
              ),
              const DataDocumentsAbout(),
              const SizedBox(
                height: 30,
              ),
              ButtonInvestment(
                text: "Comenzar",
                onPressed: () {
                  Navigator.pushNamed(context, 'v2/validate_identity');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DataDocumentsAbout extends ConsumerWidget {
  const DataDocumentsAbout({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int clipOvalDark = 0xffA2E6FA;
    const int clipOvalLight = 0xff0D3A5C;
    const int notSelectClipOvalDark = 0xff6A6A6A;
    const int notSelectClipOvalLight = 0xff989898;
    const int iconClipOvalDark = 0xff191919;
    const int iconClipOvalLight = 0xffFFFFFF;
    const int textNotSelectDark = 0xff4D4D4D;
    const int textNotSelectLight = 0xff989898;
    const int textSelectDark = 0xffFFFFFF;
    const int textSelectLight = 0xff0D3A5C;
    const List<Color> gradientDark = [Color(0xFFA2E6FA), Color(0xFF454545)];
    const List<Color> gradientLight = [Color(0xFF0D3A5C), Color(0xFF454545)];
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 136,
      child: Stack(
        children: [
          Positioned(
            left: 10,
            child: DottedVerticalLine(
              height: 122,
              dashWidth: 2,
              dashHeight: 5,
              dashSpace: 3,
              gradientColors: isDarkMode ? gradientDark : gradientLight,
            ),
          ),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ClipOval(
                    child: Container(
                      width: 20,
                      height: 20,
                      color: isDarkMode
                          ? const Color(clipOvalDark)
                          : const Color(clipOvalLight),
                      child: Icon(Icons.circle,
                          size: 12,
                          color: isDarkMode
                              ? const Color(iconClipOvalDark)
                              : const Color(iconClipOvalLight)),
                    ),
                  ),
                  ClipOval(
                    child: Container(
                      width: 20,
                      height: 20,
                      color: isDarkMode
                          ? const Color(notSelectClipOvalDark)
                          : const Color(notSelectClipOvalLight),
                      child: Icon(Icons.circle,
                          size: 12,
                          color: isDarkMode
                              ? const Color(iconClipOvalDark)
                              : const Color(iconClipOvalLight)),
                    ),
                  ),
                  ClipOval(
                    child: Container(
                      width: 20,
                      height: 20,
                      color: isDarkMode
                          ? const Color(notSelectClipOvalDark)
                          : const Color(notSelectClipOvalLight),
                      child: Icon(Icons.circle,
                          size: 12,
                          color: isDarkMode
                              ? const Color(iconClipOvalDark)
                              : const Color(iconClipOvalLight)),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 40),
              const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextPoppins(
                    text: "Mis datos personales",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    textDark: textSelectDark,
                    textLight: textSelectLight,
                  ),
                  TextPoppins(
                    text: "Documentos legales",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    textDark: textNotSelectDark,
                    textLight: textNotSelectLight,
                  ),
                  TextPoppins(
                    text: "Sobre",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    textDark: textNotSelectDark,
                    textLight: textNotSelectLight,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

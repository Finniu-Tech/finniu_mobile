import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/catalog/widgets/user_profil_v2/scafold_user_profile.dart';

import 'package:flutter/material.dart';

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
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                isBold: true,
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
                isBold: false,
                lines: 2,
                align: TextAlign.start,
                textDark: bodyDark,
                textLight: bodyLight,
              ),
              const DataDocumentsAbout(),
            ],
          ),
        ),
      ],
    );
  }
}

class DataDocumentsAbout extends StatelessWidget {
  const DataDocumentsAbout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row();
  }
}

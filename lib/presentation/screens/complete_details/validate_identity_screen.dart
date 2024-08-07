import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/catalog/widgets/user_profil_v2/scafold_user_profile.dart';
import 'package:finniu/presentation/screens/complete_details/widgets/app_bar_logo.dart';
import 'package:finniu/presentation/screens/complete_details/widgets/container_slide.dart';
import 'package:finniu/presentation/screens/complete_details/widgets/navigate_gesture_container.dart';
import 'package:flutter/material.dart';

class ValidateIdentityScreenV2 extends StatelessWidget {
  const ValidateIdentityScreenV2({super.key});
  final String textTitle = "Queremos validar tu identidad";
  final String textBody = "Elige como deseas validar tu identidad";
  final int titleDark = 0xffA2E6FA;
  final int titleLight = 0xff0D3A5C;
  final int bodyDark = 0xffFFFFFF;
  final int bodyLight = 0xff000000;

  @override
  Widget build(BuildContext context) {
    return ScaffoldUserProfile(
      appBar: const AppBarLogo(),
      children: [
        const ContainerSlide(),
        const SizedBox(
          height: 20,
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
        const SizedBox(
          height: 10,
        ),
        NavigateGestureContainer(
          svgUrl: "assets/svg_icons/document_icon.svg",
          textBody: "Escanear mi documento de identidad",
          onTap: () {
            Navigator.pushNamed(context, '/v2/scan_document');
          },
        ),
        const SizedBox(
          height: 10,
        ),
        NavigateGestureContainer(
          svgUrl: "assets/svg_icons/note_add.svg",
          textBody: "Completar  mis datos manualmente",
          onTap: () {
            Navigator.pushNamed(context, '/v2/form_personal_data');
          },
        ),
      ],
    );
  }
}

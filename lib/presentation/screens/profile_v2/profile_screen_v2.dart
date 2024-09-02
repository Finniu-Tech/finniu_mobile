import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/app_bar_profile.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/button_my_data.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/button_navigate_profile.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/image_profile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserProfileV2 extends ConsumerWidget {
  const UserProfileV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    const int backgroundDark = 0xff191919;
    const int backgroundLight = 0xffFFFFFF;
    return Scaffold(
      appBar: const AppBarProfile(title: "Mi perfil"),
      backgroundColor: isDarkMode
          ? const Color(backgroundDark)
          : const Color(backgroundLight),
      body: const SingleChildScrollView(
        child: _BodyProfile(),
      ),
    );
  }
}

class _BodyProfile extends ConsumerWidget {
  const _BodyProfile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProfileNotifierProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ImageProfileStack(
          fullName: "${userProfile.firstName} ${userProfile.lastName}",
          email: "${userProfile.email}",
          profileImage: "${userProfile.imageProfileUrl}",
          backgroundImage: "",
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ButtonMyData(
              icon: "assets/svg_icons/file_text_icon.svg",
              title: "Mis datos",
              subtitle: "Clic para ver mis datos",
              load: 0.5,
              onTap: () => Navigator.pushNamed(context, '/v2/my_data'),
            ),
            const SizedBox(
              width: 10,
            ),
            ButtonMyData(
              icon: "assets/svg_icons/credit-card.svg",
              title: "Mis cuentas",
              subtitle: "Falta agregar tus cuentas",
              load: 1,
              onTap: () => print("click"),
              isComplete: true,
            ),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        const ButtonNavigateProfile(
          icon: "assets/svg_icons/settings.svg",
          title: "Configuraciones",
          subtitle:
              "Notificaciones, Modo oscuro, \nprivacidad, cambio de contraseña",
          onTap: null,
        ),
        const ButtonNavigateProfile(
          icon: "assets/svg_icons/legal_icon_v2.svg",
          title: "Documentos legales",
          subtitle: "Información legal para las \ninversiones",
          onTap: null,
        ),
        const ButtonNavigateProfile(
          icon: "assets/svg_icons/help_circle.svg",
          title: "Soporte y ayuda",
          subtitle: "Ticket de soporte y preguntas \nfrecuentes",
          onTap: null,
        ),
        const ButtonNavigateProfile(
          icon: "assets/svg_icons/log_out.svg",
          title: "Cerrar sesión",
          isComplete: true,
          onlyTitle: true,
          subtitle: "",
          onTap: null,
        ),
      ],
    );
  }
}

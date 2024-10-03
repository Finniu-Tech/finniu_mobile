import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/config_v2/helpers/email_reset.dart';
import 'package:finniu/presentation/screens/config_v2/scaffold_config.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/expansion_title_profile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class PrivacyScreenV2 extends ConsumerWidget {
  const PrivacyScreenV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const ScaffoldConfig(
      title: "Privacidad",
      children: _BodyPrivacy(),
    );
  }
}

class _BodyPrivacy extends ConsumerWidget {
  const _BodyPrivacy();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? email = ref.watch(userProfileNotifierProvider).email;
    void setRememberPassword() {
      context.loaderOverlay.show();
      emailReset(context, ref);
    }

    return Column(
      children: [
        ExpansionTitleProfile(
          icon: "assets/svg_icons/key_icon.svg",
          title: "Contraseñas",
          subtitle:
              "Sobre los depósitos, aprobaciones de mis inversiones y otros.",
          children: [
            // ChildrenSwitchTitle(
            //   title: "Visualización de contraseña",
            //   subtitle: "Mostrar caracteres brevemente mientras escribes",
            //   value: rememberPassword,
            // ),
            ChildrenEmail(
              title: "Cambio de contraseña",
              subtitle:
                  "Te enviaremos un correo para reestablecer tu contraseña ",
              email: email ?? '',
            ),
            ButtonChangePassword(
              onTap: () => setRememberPassword(),
            ),
          ],
        ),
        // ExpansionTitleProfile(
        //   icon: "assets/svg_icons/lock_key_icon.svg",
        //   title: "Administrador de permisos",
        //   subtitle: "Avisos sobre las nuevas novedades ",
        //   children: [
        //     ChildrenSwitchTitle(
        //       title: "Permiso de ubicación actual",
        //       subtitle:
        //           "Activar tu ubicación actual mientras la app esta en uso",
        //     ),
        //     ChildrenSwitchTitle(
        //       title: "Permiso de acceso a tu galeria",
        //       subtitle:
        //           "Visualizar directamente tus fotos de tu galeria mientras la app esta en uso",
        //     ),
        //   ],
        // ),
        const ExpansionTitleProfile(
          icon: "assets/svg_icons/shield_check_icon.svg",
          title: "Política de privacidad",
          subtitle: "Avisos sobre las nuevas novedades ",
          children: [
            ChildrenOnlyText(
              textBig: false,
              text:
                  "Política de privacidad de la app Finniu, tenemos respaldo y seguridad de tus datos , no los compartimos ni exponemos tus datos personales",
            ),
          ],
        ),
      ],
    );
  }
}

class ButtonChangePassword extends ConsumerWidget {
  const ButtonChangePassword({
    super.key,
    required this.onTap,
  });
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    const int backgroundDark = 0xffA2E6FA;
    const int backgroundLight = 0xff0D3A5C;
    const int textDark = 0xff000000;
    const int textLight = 0xffFFFFFF;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 220,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
              color: isDarkMode
                  ? const Color(backgroundDark)
                  : const Color(backgroundLight),
            ),
            child: const Center(
              child: TextPoppins(
                text: "Solicitar cambio de contraseña",
                fontSize: 12,
                fontWeight: FontWeight.w500,
                textDark: textDark,
                textLight: textLight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

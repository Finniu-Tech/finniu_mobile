import 'package:finniu/presentation/screens/config_v2/scaffold_config.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/expansion_title_profile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

class _BodyPrivacy extends StatelessWidget {
  const _BodyPrivacy();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ExpansionTitleProfile(
          icon: "assets/svg_icons/key_icon.svg",
          title: "Contraseñas",
          subtitle:
              "Sobre los depósitos, aprobaciones de mis inversiones y otros.",
          children: [
            ChildrenSwitchTitle(
              title: "Visualización de contraseña",
              subtitle: "Mostrar caracteres brevemente mientras escribes",
            ),
            ChildrenEmail(
              title: "Cambio de contraseña",
              subtitle:
                  "Te enviaremos un correo para reestablecer tu contraseña ",
              email: "H8kzK@example.com",
            ),
          ],
        ),
        ExpansionTitleProfile(
          icon: "assets/svg_icons/lock_key_icon.svg",
          title: "Administrador de permisos",
          subtitle: "Avisos sobre las nuevas novedades ",
          children: [
            ChildrenSwitchTitle(
              title: "Permiso de ubicación actual",
              subtitle:
                  "Activar tu ubicación actual mientras la app esta en uso",
            ),
            ChildrenSwitchTitle(
              title: "Permiso de acceso a tu galeria",
              subtitle:
                  "Visualizar directamente tus fotos de tu galeria mientras la app esta en uso",
            ),
          ],
        ),
        ExpansionTitleProfile(
          icon: "assets/svg_icons/shield_check_icon.svg",
          title: "Política de privacidad",
          subtitle: "Avisos sobre las nuevas novedades ",
          children: [
            ChildrenOnlyText(
              textBig: true,
              text:
                  "Política de privacidad de la app Finniu, tenemos respaldo y seguridad de tus datos , no los compartimos ni exponemos tus datos personales",
            ),
          ],
        ),
      ],
    );
  }
}

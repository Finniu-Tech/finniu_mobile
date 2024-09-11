import 'package:finniu/presentation/screens/config_v2/scaffold_config.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/button_navigate_profile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyDataScreen extends ConsumerWidget {
  const MyDataScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const ScaffoldConfig(
      title: "Mis datos",
      children: _BodyMyData(),
    );
  }
}

class _BodyMyData extends StatelessWidget {
  const _BodyMyData();
  void navigate(BuildContext context, String navigate) {
    Navigator.pushNamed(context, navigate);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ButtonNavigateProfile(
          isComplete: true,
          icon: "assets/svg_icons/user_icon.svg",
          title: "Datos personales",
          subtitle: "Información personal legal. \n",
          onTap: () => navigate(context, '/v2/edit_personal_data'),
        ),
        ButtonNavigateProfile(
          isComplete: true,
          icon: "assets/svg_icons/map_icon_v2.svg",
          title: "Ubicación",
          subtitle: "Información sobre su ubicación actual \n",
          onTap: () => navigate(context, '/v2/edit_location_data'),
        ),
        ButtonNavigateProfile(
          isComplete: false,
          icon: "assets/svg_icons/bag_icon_v2.svg",
          title: "Ocupación laboral",
          subtitle: "Información sobre tu ocupación laboral \n",
          onTap: () => navigate(context, '/v2/edit_job_data'),
        ),
        const ButtonNavigateProfile(
          isComplete: false,
          icon: "assets/svg_icons/user_icon_v2.svg",
          title: "Sobre mí",
          subtitle: "Información personal que deseas compartir. \n",
          onTap: null,
        ),
      ],
    );
  }
}

import 'package:finniu/presentation/screens/config_v2/scaffold_config.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/button_navigate_profile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SupportHelpScreen extends ConsumerWidget {
  const SupportHelpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const ScaffoldConfig(
      title: "Soporte & ayuda",
      children: _BodySupportHelp(),
    );
  }
}

class _BodySupportHelp extends StatelessWidget {
  const _BodySupportHelp();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ButtonNavigateProfile(
          isComplete: true,
          icon: "assets/svg_icons/ticket_icon.svg",
          title: "Ticket de soporte",
          subtitle: "Registre el problema en un formulario \n",
          onTap: () => Navigator.pushNamed(context, '/v2/support_ticket'),
        ),
        ButtonNavigateProfile(
          isComplete: true,
          icon: "assets/svg_icons/message_question_icon.svg",
          title: "Preguntas frecuentes",
          subtitle: "Aquí podras encontrar las respuestas a tus dudas \n",
          onTap: () => Navigator.pushNamed(context, '/v2/frequently_questions'),
        ),
      ],
    );
  }
}

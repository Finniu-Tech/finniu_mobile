import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/screens/config_v2/scaffold_config.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/button_navigate_profile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SupportHelpScreen extends StatelessWidget {
  const SupportHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldConfig(
      title: "Soporte & ayuda",
      children: _BodySupportHelp(),
    );
  }
}

class _BodySupportHelp extends ConsumerWidget {
  const _BodySupportHelp();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ButtonNavigateProfile(
          isComplete: true,
          icon: "assets/svg_icons/ticket_icon.svg",
          title: "Ticket de soporte",
          subtitle: "Registre el problema en un formulario \n",
          onTap: () => {
            ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
              eventName: FirebaseAnalyticsEvents.navigateTo,
              parameters: {
                "screen": FirebaseScreen.supportV2,
                "navigate_to": FirebaseScreen.supportTicketV2,
              },
            ),
            Navigator.pushNamed(context, '/v2/support_ticket'),
          },
        ),
        ButtonNavigateProfile(
          isComplete: true,
          icon: "assets/svg_icons/message_question_icon.svg",
          title: "Preguntas frecuentes",
          subtitle: "Aquí podras encontrar las respuestas a tus dudas \n",
          onTap: () => {
            ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
              eventName: FirebaseAnalyticsEvents.navigateTo,
              parameters: {
                "screen": FirebaseScreen.supportTicketV2,
                "navigate_to": FirebaseScreen.supportTicketV2,
              },
            ),
            Navigator.pushNamed(context, '/v2/frequently_questions'),
          },
        ),
      ],
    );
  }
}

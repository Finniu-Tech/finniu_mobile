import 'package:finniu/presentation/providers/bubble_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/config_v2/scaffold_config.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/button_navigate_profile.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/button_switch_profile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const ScaffoldConfig(
      title: "Configuraciones",
      children: _BodySettings(),
    );
  }
}

class _BodySettings extends ConsumerWidget {
  const _BodySettings();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final bubbleState = ref.watch(positionProvider);
    void setDarkMode() {
      if (!isDarkMode) {
        ref.read(settingsNotifierProvider.notifier).setDarkMode();
      } else {
        ref.read(settingsNotifierProvider.notifier).setLightMode();
      }
    }

    void setBubble() {
      if (bubbleState.isRender) {
        ref.read(positionProvider.notifier).resetBubble();
      } else {
        ref.read(positionProvider.notifier).getBubble();
      }
    }

    void navigatePrivacy() {
      Navigator.pushNamed(context, '/v2/privacy');
    }

    return Column(
      children: [
        ButtonSwitchProfile(
          icon: "assets/svg_icons/dark_mode_icon.svg",
          title: "Modo oscuro",
          subtitle: "Elige tu modo favorito",
          onTap: () => setDarkMode(),
          value: isDarkMode,
        ),
        // ButtonNavigateProfile(
        //   isComplete: true,
        //   icon: "assets/svg_icons/notification_icon.svg",
        //   title: "Notificaciones",
        //   subtitle: "Qué notificaciones quieres recibir \n",
        //   onTap: () => Navigator.pushNamed(context, '/v2/new_notifications'),
        // ),
        ButtonNavigateProfile(
          isComplete: true,
          icon: "assets/svg_icons/lock_key_icon.svg",
          title: "Privacidad",
          subtitle: "Configura tu privacidad \n",
          onTap: () => navigatePrivacy(),
        ),
        ButtonSwitchProfile(
          icon: "assets/svg_icons/julia_icon.svg",
          title: "Chat de ayuda",
          subtitle: "Visualización de chat con Julia en la app",
          onTap: () => setBubble(),
          value: bubbleState.isRender,
        ),
      ],
    );
  }
}

import 'package:finniu/presentation/screens/config_v2/scaffold_config.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/button_switch_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotificationsScreenV2 extends ConsumerWidget {
  const NotificationsScreenV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const ScaffoldConfig(
      title: "Notificaciones",
      children: _BodyNotifications(),
    );
  }
}

class _BodyNotifications extends HookConsumerWidget {
  const _BodyNotifications();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aboutInvestments = useState(false);
    final informativeNotices = useState(false);
    void setInvest() {
      aboutInvestments.value = !aboutInvestments.value;
    }

    void setInformative() {
      informativeNotices.value = !informativeNotices.value;
    }

    return Column(
      children: [
        ButtonSwitchProfile(
          icon: null,
          title: "Sobre mis inversiones",
          subtitle:
              "Sobre los depósitos, aprobaciones de mis inversiones y otros.",
          onTap: () => setInvest(),
          value: aboutInvestments.value,
        ),
        ButtonSwitchProfile(
          icon: null,
          title: "Avisos informativos",
          subtitle: "Avisos sobre las nuevas novedades ",
          onTap: () => setInformative(),
          value: aboutInvestments.value,
        ),
      ],
    );
  }
}

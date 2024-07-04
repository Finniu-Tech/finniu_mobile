import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/report_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/home/widgets/modals.dart';
import 'package:finniu/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileButton extends ConsumerWidget {
  const ProfileButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(settingsNotifierProvider);
    final userBalanceReport = ref.watch(userProfileBalanceNotifierProvider);
    final currency = ref.watch(isSolesStateProvider);
    final settings = ref.read(settingsNotifierProvider.notifier);
    final userProfile = ref.watch(userProfileNotifierProvider);
    return InkWell(
      onTap: () {
        settingsDialog(
          context,
          ref,
          themeProvider,
          userBalanceReport,
          currency,
          userProfile,
          settings,
        );
      },
      child: Container(
        alignment: Alignment.center,
        child: CircularPercentAvatarWidget(
          userProfile.percentCompleteProfile ?? 0.0,
        ),
      ),
    );
  }
}

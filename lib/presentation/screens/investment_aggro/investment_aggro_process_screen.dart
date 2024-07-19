import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widgets/scafold.dart';
import 'package:finniu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InvestmentAggroProcessScreen extends ConsumerWidget {
  const InvestmentAggroProcessScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    return CustomLoaderOverlay(
      child: ScaffoldInvestment(
        isDarkMode: currentTheme.isDarkMode,
        backgroundColor:
            currentTheme.isDarkMode ? const Color(scaffoldBlackBackground) : const Color(scaffoldSkyBlueBackground),
        body: AggroBody(),
      ),
    );
  }
}

class AggroBody extends HookConsumerWidget {
  const AggroBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Text('Aggro Screen'),
    );
  }
}

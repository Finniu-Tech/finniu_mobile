import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/navigation_bar.dart';
import 'package:finniu/presentation/screens/simulator_v2/widgets/button_calculate.dart';
import 'package:finniu/presentation/screens/simulator_v2/widgets/column_how_invest.dart';
import 'package:finniu/presentation/screens/simulator_v2/widgets/custom_for_how_long.dart';
import 'package:finniu/presentation/screens/simulator_v2/widgets/simulator_appbar.dart';
import 'package:finniu/presentation/screens/simulator_v2/widgets/title_simulator.dart';
import 'package:finniu/presentation/screens/simulator_v2/widgets/type_investment.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class V2SimulatorScreen extends HookConsumerWidget {
  const V2SimulatorScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int columnColorDark = 0xff0E0E0E;
    const int columnColorLight = 0xffDCF6FF;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(columnColorDark) : const Color(columnColorLight),
      appBar: const AppBarSimulatorScreen(),
      bottomNavigationBar: const NavigationBarHome(
        colorBackground: Colors.transparent,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            TitleSimulator(),
            SimulatorBody(),
          ],
        ),
      ),
    );
  }
}

class SimulatorBody extends ConsumerWidget {
  const SimulatorBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    const int backgroundDark = 0xff191919;
    const int backgroundLight = 0xffFFFFFF;
    return Container(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 30),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(backgroundDark) : const Color(backgroundLight),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TypeInvestment(),
          ColumnHowInvest(),
          ColumnForHowLong(),
          ButtonCalculate(),
        ],
      ),
    );
  }
}

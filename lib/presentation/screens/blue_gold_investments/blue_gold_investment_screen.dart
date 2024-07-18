import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/blue_gold_investments/widgets/funds_title_blue_gold.dart';
import 'package:finniu/presentation/screens/business_investments/widgets/app_bar_business.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BlueGoldInvestmentsScreen extends HookConsumerWidget {
  const BlueGoldInvestmentsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int columnColorDark = 0xff0E0E0E;
    const int columnColorLight = 0xffF8F8F8;
    // final isVisible = useState<bool>(true);

    // void hideNoInvestmentBody() {
    //   isVisible.value = false;
    // }

    return Scaffold(
      backgroundColor: isDarkMode
          ? const Color(columnColorDark)
          : const Color(columnColorLight),
      appBar: const AppBarBusinessScreen(),
      bottomNavigationBar: const NavigationBarHome(),
      body: const SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            BodyScaffold(),
          ],
        ),
      ),
    );
  }
}

class BodyScaffold extends ConsumerWidget {
  const BodyScaffold({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int columnColorDark = 0xff0E0E0E;
    const int columnColorLight = 0xffF8F8F8;
    return Container(
      color: isDarkMode
          ? const Color(columnColorDark)
          : const Color(columnColorLight),
      width: MediaQuery.of(context).size.width,
      child: const Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlueGoldFundTitle(),
          ],
        ),
      ),
    );
  }
}

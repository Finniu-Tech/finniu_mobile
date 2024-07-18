import 'package:finniu/infrastructure/models/blue_gold_investment/progress_blue_gold.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/blue_gold_investments/widgets/funds_title_blue_gold.dart';
import 'package:finniu/presentation/screens/business_investments/widgets/app_bar_business.dart';
import 'package:finniu/presentation/screens/catalog/widgets/carousel_blue_gold.dart';
import 'package:finniu/presentation/screens/catalog/widgets/row_schedule_logbook.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
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
            BlueGoldBody(),
          ],
        ),
      ),
    );
  }
}

class BlueGoldBody extends ConsumerWidget {
  const BlueGoldBody({
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
            CarouselBlueGold(),
            RowScheduleLogbook(),
            TitleProgress(),
            InvestmentList(),
          ],
        ),
      ),
    );
  }
}

class InvestmentList extends ConsumerWidget {
  const InvestmentList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
      child: ListView.builder(
        itemCount: progressBlueGold.length,
        itemBuilder: (context, index) {
          final item = progressBlueGold[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: getCardWidget(item),
          );
        },
      ),
    );
  }
}

class TitleProgress extends StatelessWidget {
  const TitleProgress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: 10,
        ),
        TextPoppins(
          text: "Progreso de mi inversión",
          fontSize: 16,
          isBold: true,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

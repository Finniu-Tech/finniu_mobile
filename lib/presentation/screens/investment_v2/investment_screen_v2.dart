import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/blue_gold_investments/blue_gold_investment_screen.dart';
import 'package:finniu/presentation/screens/blue_gold_investments/widgets/funds_title_blue_gold.dart';
import 'package:finniu/presentation/screens/business_investments/business_investments_screen.dart';
import 'package:finniu/presentation/screens/business_investments/widgets/app_bar_business.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/funds_title.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PageWidget {
  Widget title;
  Widget itemBuilder;
  PageWidget({required this.itemBuilder, required this.title});
}

class InvestmentsV2Screen extends HookConsumerWidget {
  const InvestmentsV2Screen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int columnColorDark = 0xff0E0E0E;
    const int columnColorLight = 0xffF8F8F8;
    PageController pageController = PageController();
    List<PageWidget> itemBuilder = [
      PageWidget(
        title: GestureDetector(
          onTap: () => pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          ),
          child: const EnterpriseFundTitle(),
        ),
        itemBuilder: const RealEstateBody(),
      ),
      PageWidget(
        title: GestureDetector(
          onTap: () => pageController.animateToPage(
            1,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          ),
          child: const BlueGoldFundTitle(),
        ),
        itemBuilder: const BlueGoldBody(),
      ),
    ];

    return Scaffold(
      backgroundColor: isDarkMode
          ? const Color(columnColorDark)
          : const Color(columnColorLight),
      appBar: const AppBarBusinessScreen(),
      bottomNavigationBar: const NavigationBarHome(
        colorBackground: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              child: Row(
                children: [itemBuilder[0].title, itemBuilder[1].title],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.9,
              child: PageView.builder(
                itemCount: itemBuilder.length,
                itemBuilder: (context, index) {
                  return itemBuilder[index].itemBuilder;
                },
                controller: pageController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

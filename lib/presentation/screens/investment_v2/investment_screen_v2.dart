import 'package:finniu/presentation/providers/navigator_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/blue_gold_investments/blue_gold_investment_screen.dart';
import 'package:finniu/presentation/screens/blue_gold_investments/widgets/funds_title_blue_gold.dart';
import 'package:finniu/presentation/screens/business_investments/business_investments_screen.dart';
import 'package:finniu/presentation/screens/business_investments/widgets/app_bar_business.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/funds_title.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PageWidget {
  Widget title;
  Widget itemBuilder;
  PageWidget({
    required this.itemBuilder,
    required this.title,
  });
}

class InvestmentsV2Screen extends StatefulHookConsumerWidget {
  const InvestmentsV2Screen({super.key});

  @override
  InvestmentsV2ScreenState createState() => InvestmentsV2ScreenState();
}

class InvestmentsV2ScreenState extends ConsumerState<InvestmentsV2Screen> {
  final PageController pageController = PageController();
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(navigatorStateProvider.notifier).state = 2;
        });
        return null;
      },
      [],
    );
    return HookConsumer(
      builder: (context, ref, _) {
        final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
        const int columnColorDark = 0xff0E0E0E;
        const int columnColorLight = 0xffF8F8F8;

        List<PageWidget> pageWidgets = [
          PageWidget(
            title: GestureDetector(
              onTap: () {
                pageController.animateToPage(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
                setState(() {
                  selectedPage = 0;
                });
              },
              child: RealStateTitleAndNavigate(
                isSelect: selectedPage == 0,
                isDarkMode: isDarkMode,
              ),
            ),
            itemBuilder: const RealEstateBody(),
          ),
          PageWidget(
            title: GestureDetector(
              onTap: () {
                pageController.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
                setState(() {
                  selectedPage = 1;
                });
              },
              child: BlueGoldTitleAndNavigate(
                isSelect: selectedPage == 1,
                isDarkMode: isDarkMode,
              ),
            ),
            itemBuilder: const BlueGoldBody(),
          ),
        ];

        return Scaffold(
          backgroundColor: isDarkMode ? const Color(columnColorDark) : const Color(columnColorLight),
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
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      pageWidgets[0].title,
                      const SizedBox(width: 7),
                      pageWidgets[1].title,
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: PageView.builder(
                    itemCount: pageWidgets.length,
                    itemBuilder: (context, index) {
                      return pageWidgets[index].itemBuilder;
                    },
                    controller: pageController,
                    onPageChanged: (index) {
                      setState(() {
                        selectedPage = index;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

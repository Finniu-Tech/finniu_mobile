import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:finniu/domain/entities/fund_entity.dart';
import 'package:finniu/presentation/providers/funds_provider.dart';
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

        final fundListAsyncValue = ref.watch(fundListFutureProvider);

        return fundListAsyncValue.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
          data: (fundList) {
            List<PageWidget> pageWidgets = fundList.map((fund) {
              return PageWidget(
                title: GestureDetector(
                  onTap: () {
                    pageController.animateToPage(
                      fundList.indexOf(fund),
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                    setState(() {
                      selectedPage = fundList.indexOf(fund);
                    });
                  },
                  child: SizedBox(
                    child: FundTitleAndNavigate(
                      isSelect: selectedPage == fundList.indexOf(fund),
                      fund: fund,
                    ),
                  ),
                ),
                itemBuilder:
                    fund.fundType == FundTypeEnum.corporate ? RealEstateBody(fund: fund) : BlueGoldBody(fund: fund),
              );
            }).toList();

            return Scaffold(
              backgroundColor: isDarkMode ? const Color(columnColorDark) : const Color(columnColorLight),
              appBar: const AppBarBusinessScreen(),
              bottomNavigationBar: const NavigationBarHome(
                colorBackground: Colors.transparent,
              ),
              extendBody: true,
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 5),
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 36,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: pageWidgets.map((widget) => widget.title).toList(),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.topCenter,
                      child: ExpandablePageView.builder(
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
      },
    );
  }
}

class FundTitleAndNavigate extends ConsumerWidget {
  final FundEntity fund;
  final bool isSelect;
  const FundTitleAndNavigate({super.key, required this.fund, required this.isSelect});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return fund.fundType == FundTypeEnum.corporate
        ? RealStateTitleAndNavigate(isSelect: isSelect, isDarkMode: isDarkMode, funName: fund.name)
        : BlueGoldTitleAndNavigate(
            isDarkMode: isDarkMode,
            isSelect: isSelect,
            fundName: fund.name,
          );
  }
}

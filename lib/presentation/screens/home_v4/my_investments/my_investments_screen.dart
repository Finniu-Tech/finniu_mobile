import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:finniu/constants/colors/my_invest_v4_colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v4/my_investments/document_page.dart';
import 'package:finniu/presentation/screens/home_v4/my_investments/my_investments_container.dart';
import 'package:finniu/presentation/screens/home_v4/products_v4/app_bar_products.dart';
import 'package:finniu/presentation/screens/home_v4/widget/nav_bar_v4.dart';
import 'package:finniu/presentation/screens/home_v4/my_investments/tab_bar_v4.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyInvestmentsScreen extends ConsumerWidget {
  const MyInvestmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return Scaffold(
      backgroundColor: isDarkMode
          ? const Color(MyInvestV4Colors.backgroudDark)
          : const Color(MyInvestV4Colors.backgroudLight),
      appBar: const AppBarProducts(
        title: "Mis inversiones",
      ),
      bottomNavigationBar: const NavBarV4(),
      body: const SingleChildScrollView(
        child: MyInvestmentsBody(),
      ),
    );
  }
}

class MyInvestmentsBody extends StatelessWidget {
  const MyInvestmentsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController(initialPage: 0);
    final List<Widget> pages = [
      InvestPage(
        pageController: pageController,
      ),
      DocumentTabBar(
        pageController: pageController,
      ),
    ];

    return ExpandablePageView.builder(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: pages.length,
      itemBuilder: (BuildContext context, int index) {
        return pages[index];
      },
    );
  }
}

class DocumentTabBar extends StatelessWidget {
  const DocumentTabBar({
    super.key,
    required this.pageController,
  });
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dx > 0) {
          pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      },
      child: const DocumenteBody(),
    );
  }
}

class InvestPage extends StatelessWidget {
  const InvestPage({
    super.key,
    required this.pageController,
  });
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MyInvestmentsContainer(
          isLoaded: false,
        ),
        GestureDetector(
          onTap: () => pageController.animateToPage(
            1,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          ),
          child: const NavigateToDocuments(),
        ),
        const TabBarBusinessV4(
          isReinvest: false,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class NavigateToDocuments extends ConsumerWidget {
  const NavigateToDocuments({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.edit_document,
                    color: isDarkMode
                        ? const Color(MyInvestV4Colors.goDocumentDark)
                        : const Color(MyInvestV4Colors.goDocumentLight),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const TextPoppins(
                    text: "Documentación",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    textDark: MyInvestV4Colors.goDocumentDark,
                    textLight: MyInvestV4Colors.goDocumentLight,
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: isDarkMode
                        ? const Color(MyInvestV4Colors.goDocumentDark)
                        : const Color(MyInvestV4Colors.goDocumentLight),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(
              color: isDarkMode
                  ? const Color(MyInvestV4Colors.dividerDark)
                  : const Color(MyInvestV4Colors.dividerLight),
              height: 2,
            ),
          ],
        ),
      ),
    );
  }
}

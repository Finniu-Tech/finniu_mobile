import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:finniu/constants/colors/my_invest_v4_colors.dart';
import 'package:finniu/domain/entities/home_v4_entity.dart';
import 'package:finniu/presentation/providers/home_v4_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v4/my_investments/document_page.dart';
import 'package:finniu/presentation/screens/home_v4/my_investments/my_investments_container.dart';
import 'package:finniu/presentation/screens/home_v4/products_v4/app_bar_products.dart';
import 'package:finniu/presentation/screens/home_v4/widget/button_tour_invest.dart';
import 'package:finniu/presentation/screens/home_v4/widget/nav_bar_v4.dart';
import 'package:finniu/presentation/screens/home_v4/my_investments/tab_bar_v4.dart';
import 'package:finniu/services/share_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class MyInvestmentsScreen extends ConsumerWidget {
  const MyInvestmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (progress) {
        return const Center(
          child: CircularLoader(
            width: 50,
            height: 50,
          ),
        );
      },
      child: Scaffold(
        backgroundColor:
            isDarkMode ? const Color(MyInvestV4Colors.backgroudDark) : const Color(MyInvestV4Colors.backgroudLight),
        appBar: const AppBarProducts(
          title: "Mis inversiones",
        ),
        bottomNavigationBar: const NavBarV4(),
        body: const Stack(
          children: [
            SingleChildScrollView(
              child: InvestPage(),
            ),
            TourButton(),
          ],
        ),
      ),
    );
  }
}

class TourButton extends StatefulWidget {
  const TourButton({
    super.key,
  });

  @override
  State<TourButton> createState() => _TourButtonState();
}

class _TourButtonState extends State<TourButton> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: Preferences.tourInvestmentNotifier,
      builder: (context, tourHome, child) {
        return tourHome
            ? const Positioned(
                top: 180,
                child: ButtonInvestTourV4(),
              )
            : const SizedBox();
      },
    );
  }
}

class MyInvestmentsBody extends StatelessWidget {
  const MyInvestmentsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController(initialPage: 0);
    final List<Widget> pages = [
      const InvestPage(),
      const DocumenteBody(),
    ];

    return ExpandablePageView.builder(
      controller: pageController,
      itemCount: pages.length,
      itemBuilder: (BuildContext context, int index) {
        return pages[index];
      },
    );
  }
}

class InvestPage extends StatelessWidget {
  const InvestPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        MiInvestProvider(),
        TabBarBusinessV4(
          isReinvest: false,
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class MiInvestProvider extends ConsumerWidget {
  const MiInvestProvider({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<HomeUserInvest> investHome = ref.watch(homeV4InvestProvider);

    return investHome.when(
      data: (data) {
        if (data.investmentInDolares == null && data.investmentInSoles == null) {
          return MyInvestmentsContainer(
            data: homeUserErrorInvest,
            isLoaded: false,
          );
        }
        return MyInvestmentsContainer(
          data: data,
          isLoaded: false,
        );
      },
      error: (error, stackTrace) => MyInvestmentsContainer(
        data: homeUserErrorInvest,
        isLoaded: false,
      ),
      loading: () => MyInvestmentsContainer(
        data: homeUserErrorInvest,
        isLoaded: true,
      ),
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
              color:
                  isDarkMode ? const Color(MyInvestV4Colors.dividerDark) : const Color(MyInvestV4Colors.dividerLight),
              height: 2,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:finniu/constants/colors/my_invest_v4_colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v4/my_investments/my_investments_container.dart';
import 'package:finniu/presentation/screens/home_v4/products_v4/app_bar_products.dart';
import 'package:finniu/presentation/screens/home_v4/widget/nav_bar_v4.dart';
import 'package:finniu/presentation/screens/home_v4/my_investments/tab_bar_v4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  const MyInvestmentsBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        MyInvestmentsContainer(
          isLoaded: false,
        ),
        NavigateToDocuments(),
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

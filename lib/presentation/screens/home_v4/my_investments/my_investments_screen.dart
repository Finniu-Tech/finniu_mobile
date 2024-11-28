import 'package:finniu/constants/colors/my_invest_v4_colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/home_v4/my_investments/my_investments_container.dart';
import 'package:finniu/presentation/screens/home_v4/products_v4/app_bar_products.dart';
import 'package:finniu/presentation/screens/home_v4/widget/nav_bar_v4.dart';
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
      ],
    );
  }
}

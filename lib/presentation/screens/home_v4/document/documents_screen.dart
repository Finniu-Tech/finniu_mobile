import 'package:finniu/constants/colors/my_invest_v4_colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/home_v4/my_investments/document_page.dart';
import 'package:finniu/presentation/screens/home_v4/products_v4/app_bar_products.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DocumentsScreen extends ConsumerWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.read(settingsNotifierProvider).isDarkMode;
    return Scaffold(
      backgroundColor: isDarkMode
          ? const Color(MyInvestV4Colors.backgroudDark)
          : const Color(MyInvestV4Colors.backgroudLight),
      appBar: const AppBarProducts(
        title: "Mis inversiones",
      ),
      // bottomNavigationBar: const NavBarV4(),
      body: const SingleChildScrollView(
        child: DocumenteBody(),
      ),
    );
  }
}

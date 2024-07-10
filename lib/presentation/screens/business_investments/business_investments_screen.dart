import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BusinessInvestmentsScreen extends HookConsumerWidget {
  const BusinessInvestmentsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int columnColorDark = 0xff0E0E0E;
    const int columnColorLight = 0xffF8F8F8;

    return Scaffold(
      backgroundColor: isDarkMode
          ? const Color(columnColorDark)
          : const Color(columnColorLight),
      appBar: const AppBarBusinessScreen(),
      bottomNavigationBar: const NavigationBarInvestment(),
      body: SingleChildScrollView(
        child: Container(
          color: isDarkMode
              ? const Color(columnColorDark)
              : const Color(columnColorLight),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: const Column(
            children: [
              TextPoppins(
                text: "No hay inversiones",
                fontSize: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppBarBusinessScreen extends ConsumerWidget
    implements PreferredSizeWidget {
  const AppBarBusinessScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int titleColorDark = 0xffFFFFFF;
    const int titleColorLight = 0xff000000;
    const int appBarColorDark = 0xff0E0E0E;
    const int appBarColorLight = 0xffFFFFFF;
    const int iconColorDark = 0xffA2E6FA;
    const int iconColorLight = 0xff0D3A5C;
    const int borderColorDark = 0xff1E1E1E;
    const int borderColorLight = 0xff1E1E1E;

    return AppBar(
      centerTitle: true,
      title: Text(
        "Mis inversiones",
        style: TextStyle(
          fontFamily: "Poppins",
          fontSize: 17,
          color: isDarkMode
              ? const Color(titleColorDark)
              : const Color(titleColorLight),
          fontWeight: FontWeight.bold,
        ),
      ),
      scrolledUnderElevation: 1,
      backgroundColor: isDarkMode
          ? const Color(appBarColorDark)
          : const Color(appBarColorLight),
      iconTheme: IconThemeData(
        color: isDarkMode
            ? const Color(
                iconColorDark,
              )
            : const Color(
                iconColorLight,
              ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: isDarkMode
              ? const Color(borderColorDark)
              : const Color(borderColorLight),
          height: 1.0,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1.0);
}

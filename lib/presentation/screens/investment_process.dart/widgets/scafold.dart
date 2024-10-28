import 'package:finniu/constants/colors.dart';
import 'package:flutter/material.dart';

class ScaffoldInvestment extends StatelessWidget {
  final dynamic body;
  final bool isDarkMode;
  final Color backgroundColor;

  const ScaffoldInvestment({
    super.key,
    required this.body,
    required this.isDarkMode,
    required this.backgroundColor,
  });
  @override
  Widget build(BuildContext context) {
    // final themeProvider = ref.watch(settingsNotifierProvider);

    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.surface,
      backgroundColor: backgroundColor,
      // bottomNavigationBar: !hideNavBar ? const NavigationBarHome() : null,
      // bottomNavigationBar: !hideNavBar ? const BottomNavigationBarHome() : null,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        // backgroundColor: Theme.of(context).colorScheme.surface,
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            color: isDarkMode
                ? const Color(primaryLight)
                : const Color(primaryDark),
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: body,
    );
  }
}

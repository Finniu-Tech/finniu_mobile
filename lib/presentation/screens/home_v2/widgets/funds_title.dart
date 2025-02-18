import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EnterpriseFundTitle extends ConsumerWidget {
  const EnterpriseFundTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);

    return Container(
      height: 33,
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: currentTheme.isDarkMode ? const Color(primaryDark) : const Color(primaryLight),
        ),
        color: currentTheme.isDarkMode
            ? const Color(backGroundColorFundTitleContainer)
            : const Color(lightBackgroundTitleFund),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(
          '🏢 Inversiones empresariales',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: currentTheme.isDarkMode ? Colors.white : Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class RealStateTitleAndNavigate extends StatefulWidget {
  final bool isSelect;
  final bool isDarkMode;
  final String? funName;

  const RealStateTitleAndNavigate({
    super.key,
    required this.isSelect,
    required this.isDarkMode,
    this.funName,
  });

  @override
  RealStateTitleAndNavigateState createState() => RealStateTitleAndNavigateState();
}

class RealStateTitleAndNavigateState extends State<RealStateTitleAndNavigate> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const int borderDark = 0xff0D3A5C;
    const int borderLight = 0xffA2E6FA;
    const int backgroundDark = 0xff05627D;
    const int backgroundLight = 0xffE4F9FF;
    final String fundName = widget.funName ?? "Inversiones Empresariales";

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: widget.isSelect ? 240 : 50,
      height: 33,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: widget.isDarkMode ? const Color(borderDark) : const Color(borderLight),
        ),
        color: widget.isDarkMode ? const Color(backgroundDark) : const Color(backgroundLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: TextPoppins(
            text: widget.isSelect ? "🏢 $fundName" : "🏢",
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BlueGoldFundTitle extends ConsumerWidget {
  const BlueGoldFundTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    const int borderDark = 0xff3295FF;
    const int borderLight = 0xff5BA9FF;
    const int backgroundColorDark = 0xff8BC2FF;
    const int backgroundColorLight = 0xffC8E2FF;
    const int textDark = 0xff000000;
    const int textLight = 0xff000000;

    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: 33,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: currentTheme.isDarkMode
              ? const Color(borderDark)
              : const Color(borderLight),
        ),
        color: currentTheme.isDarkMode
            ? const Color(backgroundColorDark)
            : const Color(backgroundColorLight),
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
        child: Row(
          children: [
            Image.asset(
              "assets/blue_gold/blue_gold_investment.png",
              width: 16,
              height: 16,
            ),
            const SizedBox(
              width: 5,
            ),
            const TextPoppins(
              text: "Inversiones agroinmobiliaria",
              fontSize: 14,
              isBold: true,
              textDark: textDark,
              textLight: textLight,
            ),
          ],
        ),
      ),
    );
  }
}

class BlueGoldTitleAndNavigate extends StatefulWidget {
  final bool isSelect;
  final bool isDarkMode;

  const BlueGoldTitleAndNavigate({
    super.key,
    required this.isSelect,
    required this.isDarkMode,
  });

  @override
  BlueGoldTitleAndNavigateState createState() =>
      BlueGoldTitleAndNavigateState();
}

class BlueGoldTitleAndNavigateState extends State<BlueGoldTitleAndNavigate> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const int borderDark = 0xff3295FF;
    const int borderLight = 0xff3295FF;
    const int backgroundDark = 0xff8BC2FF;
    const int backgroundLight = 0xffC8E2FF;
    const int textDark = 0xff000000;
    const int textLight = 0xff000000;

    return LayoutBuilder(
      builder: (context, constraints) => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: widget.isSelect ? 240 : 50,
        height: 33,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: widget.isDarkMode
                ? const Color(borderDark)
                : const Color(borderLight),
          ),
          color: widget.isDarkMode
              ? const Color(backgroundDark)
              : const Color(backgroundLight),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: widget.isSelect
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/blue_gold/blue_gold_investment.png",
                    width: 16,
                    height: 16,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  constraints.maxWidth > 230
                      ? const Flexible(
                          child: TextPoppins(
                            text: "Inversiones agroinmobiliaria",
                            fontSize: 14,
                            isBold: true,
                            textDark: textDark,
                            textLight: textLight,
                          ),
                        )
                      : const SizedBox(),
                ],
              )
            : Center(
                child: Image.asset(
                  "assets/blue_gold/blue_gold_investment.png",
                  width: 16,
                  height: 16,
                ),
              ),
      ),
    );
  }
}

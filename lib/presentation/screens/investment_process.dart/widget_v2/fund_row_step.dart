import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FundRowStep extends ConsumerWidget {
  const FundRowStep({
    super.key,
    required this.icon,
    this.isLoader = false,
  });
  final String icon;
  final bool isLoader;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int containerDark = 0xff0D3A5C;
    const int containerLight = 0xffA2E6FA;
    const int iconDark = 0xff08273F;
    const int iconLight = 0xffB4EEFF;
    const int dividerDark = 0xff00518E;
    const int dividerLight = 0xff0D3A5C;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              width: 150,
              height: 30,
              padding: const EdgeInsets.only(right: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isDarkMode ? const Color(containerDark) : const Color(containerLight),
              ),
              child: const Row(
                children: [
                  SizedBox(
                    width: 60,
                  ),
                  TextPoppins(
                    text: "Invierte",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    lines: 1,
                    align: TextAlign.center,
                  ),
                ],
              ),
            ),
            Positioned(
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: isDarkMode ? const Color(iconDark) : const Color(iconLight),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                    child: isLoader
                        ? const CircularLoader(
                            width: 24,
                            height: 24,
                          )
                        : Image.network(
                            icon,
                            width: 24,
                            height: 24,
                            fit: BoxFit.contain,
                          )
                    // : TextPoppins(
                    //     text: icon,
                    //     fontSize: 24,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    ),
                // child: Image.asset(
                //   urlIcon,
                // ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Container(
            height: 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isDarkMode ? const Color(dividerDark) : const Color(dividerLight),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TypeInvestment extends ConsumerWidget {
  const TypeInvestment({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextPoppins(
          text: "Quiero invertir en ",
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
        SwitchIsSoles(),
      ],
    );
  }
}

class SwitchIsSoles extends ConsumerWidget {
  const SwitchIsSoles({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final isSoles = ref.watch(isSolesStateProvider);
    void onTap() {
      ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
        eventName: FirebaseAnalyticsEvents.clickEvent,
        parameters: {
          "screen": FirebaseScreen.simulatorV2,
          "click": "switch_${isSoles ? "dollar" : "soles"}",
        },
      );
      ref
          .read(isSolesStateProvider.notifier)
          .toggleSwitch(isSoles ? false : true);
    }

    int backgroundSwitchDark = isSoles ? 0xff08273F : 0xffA2E6FA;
    int backgroundSwitchLight = isSoles ? 0xffB0E5F8 : 0xff051926;

    int backgroundPositionDark = isSoles ? 0xffA2E6FA : 0xff81D1E8;
    int backgroundPositionLight = isSoles ? 0xffDCF6FF : 0xff0D3A5C;
    int textPositionDark = isSoles ? 0xff0D3A5C : 0xff0D3A5C;
    int textPositionLight = isSoles ? 0xff000000 : 0xffFFFFFF;
    int textDark = isSoles ? 0xffFFFFFF : 0xff000000;
    int textLight = isSoles ? 0xff000000 : 0xffFFFFFF;

    return Container(
      width: 158,
      height: 43,
      decoration: BoxDecoration(
        color: Color(isDarkMode ? backgroundSwitchDark : backgroundSwitchLight),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(5),
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextPoppins(
                  text: "Soles",
                  fontSize: 14,
                  textDark: textDark,
                  textLight: textLight,
                ),
                TextPoppins(
                  text: "Dólares",
                  fontSize: 14,
                  textDark: textDark,
                  textLight: textLight,
                ),
              ],
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              left: isSoles ? 5 : 72,
              child: Container(
                width: 71,
                height: 40,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? Color(backgroundPositionDark)
                      : Color(backgroundPositionLight),
                  borderRadius: BorderRadius.circular(25),
                ),
                alignment: Alignment.center,
                child: TextPoppins(
                  text: isSoles ? "Soles" : "Dólares",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  textDark: textPositionDark,
                  textLight: textPositionLight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

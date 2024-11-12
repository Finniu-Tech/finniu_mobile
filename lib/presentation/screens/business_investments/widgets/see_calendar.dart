import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math' as math;

class SeeCalendar extends ConsumerWidget {
  const SeeCalendar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int containerDark = 0xff272727;
    const int containerLight = 0xffFFFFFF;
    const int iconCalendarDark = 0xffA2E6FA;
    const int iconCalendarLight = 0xff0D3A5C;
    const int iconArrowDark = 0xffA2E6FA;
    const int iconArrowLight = 0xff000000;
    return GestureDetector(
      onTap: () {
        ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
          eventName: FirebaseAnalyticsEvents.clickCalendar,
          parameters: {
            "screen": FirebaseScreen.homeV2,
            "navigateTo": FirebaseScreen.calendarV2,
          },
        );
        Navigator.pushNamed(context, '/v2/calendar');
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode
              ? const Color(containerDark)
              : const Color(containerLight),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(1, 3),
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        height: 53,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                children: [
                  const SizedBox(width: 10),
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 20,
                    color: isDarkMode
                        ? const Color(iconCalendarDark)
                        : const Color(iconCalendarLight),
                  ),
                  const SizedBox(width: 10),
                  const TextPoppins(
                    text: "Ver mi calendario de pagos",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Transform.rotate(
                  angle: math.pi / -4,
                  child: Icon(
                    Icons.arrow_forward,
                    size: 20,
                    color: isDarkMode
                        ? const Color(iconArrowDark)
                        : const Color(iconArrowLight),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

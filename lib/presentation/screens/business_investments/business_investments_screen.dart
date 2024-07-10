import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/business_investments/widgets/app_bar_business.dart';
import 'package:finniu/presentation/screens/catalog/widgets/graphic_container.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/funds_title.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math' as math;

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
      bottomNavigationBar: const NavigationBarHome(),
      body: const SingleChildScrollView(
        child: BodyScaffold(),
      ),
    );
  }
}

class BodyScaffold extends ConsumerWidget {
  const BodyScaffold({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int columnColorDark = 0xff0E0E0E;
    const int columnColorLight = 0xffF8F8F8;
    return Container(
      color: isDarkMode
          ? const Color(columnColorDark)
          : const Color(columnColorLight),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: const Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EnterpriseFundTitle(),
            SizedBox(height: 15),
            GraphicContainer(),
            SizedBox(height: 10),
            SeeCalendar(),
            SizedBox(height: 10),
            TextPoppins(
              text: "Historial de inversiones",
              fontSize: 16,
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }
}

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
        print("hola harol");
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
                    isBold: true,
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

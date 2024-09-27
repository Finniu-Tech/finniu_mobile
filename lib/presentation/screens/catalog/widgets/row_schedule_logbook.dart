import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math' as math;

class RowScheduleLogbook extends StatelessWidget {
  const RowScheduleLogbook({
    super.key,
  });
  void scheduleButton() {
    print('Cronograma');
  }

  void logbookButton(BuildContext context) {
    print('Bitácora');
    Navigator.pushNamed(context, "/v2/binnacle");
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: RowIconItem(
            onPressed: scheduleButton,
            text: 'Cronograma',
            icon: Icons.calendar_today_outlined,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: RowImageItem(
            onPressed: () => logbookButton(context),
            text: 'Bitácora',
            image: "logbook_icon",
          ),
        ),
        const SizedBox(
          width: 5,
        ),
      ],
    );
  }
}

class RowIconItem extends ConsumerWidget {
  final VoidCallback? onPressed;
  final String text;
  final IconData icon;
  const RowIconItem({
    super.key,
    required this.onPressed,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int containerDark = 0xff272727;
    const int containerLight = 0xffFFFFFF;
    const int iconCalendarDark = 0xffA2E6FA;
    const int iconCalendarLight = 0xff0D3A5C;
    const int iconArrowDark = 0xffFFFFFF;
    const int iconArrowLight = 0xff000000;
    return GestureDetector(
      onTap: onPressed,
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
                    icon,
                    size: 20,
                    color: isDarkMode
                        ? const Color(iconCalendarDark)
                        : const Color(iconCalendarLight),
                  ),
                  const SizedBox(width: 10),
                  TextPoppins(
                    text: text,
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

class RowImageItem extends ConsumerWidget {
  final VoidCallback? onPressed;
  final String text;
  final String image;
  const RowImageItem({
    super.key,
    required this.onPressed,
    required this.text,
    required this.image,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int containerDark = 0xff272727;
    const int containerLight = 0xffFFFFFF;
    const int iconArrowDark = 0xffFFFFFF;
    const int iconArrowLight = 0xff000000;
    return GestureDetector(
      onTap: onPressed,
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
        height: 53,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                children: [
                  const SizedBox(width: 10),
                  Image.asset(
                    "assets/icons/$image${isDarkMode ? "_dark" : "_light"}.png",
                    width: 20,
                  ),
                  const SizedBox(width: 10),
                  TextPoppins(
                    text: text,
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

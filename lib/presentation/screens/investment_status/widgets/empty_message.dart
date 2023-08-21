import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../home/widgets/empty_message.dart';

class EmptyHistoryMessage extends ConsumerWidget {
  bool is_history_screen;
  EmptyHistoryMessage({Key? key, required this.is_history_screen});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Text(
                'Mis inversiones 💸',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/calendar_page');
                },
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Image.asset(
                    'assets/icons/calendar.png',
                    width: 20,
                    height: 20,
                    color: currentTheme.isDarkMode
                        ? const Color(primaryLight)
                        : const Color(primaryDark),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        if (is_history_screen) ...[
          const HistorialButtons()
        ] else ...[
          const RentabilidadButtons()
        ],
        const SizedBox(height: 22),
        EmptyReportMessage(),
      ],
    );
  }
}

class RentabilidadButtons extends ConsumerWidget {
  const RentabilidadButtons({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            // Navigator.pushNamed(context, '/process_investment');
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.45,
            height: 40,
            decoration: BoxDecoration(
              color: currentTheme.isDarkMode
                  ? const Color(primaryLight)
                  : const Color(primaryDark),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Text(
                "Rentabilidad",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: currentTheme.isDarkMode
                      ? const Color(primaryDark)
                      : const Color(whiteText),
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/investment_history');
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.45,
            height: 40,
            decoration: BoxDecoration(
              color: currentTheme.isDarkMode
                  ? const Color(primaryDark)
                  : const Color(primaryLightAlternative),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Text(
                "Mi historial",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: currentTheme.isDarkMode
                      ? const Color(whiteText)
                      : const Color(primaryDark),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HistorialButtons extends ConsumerWidget {
  const HistorialButtons({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            // Navigator.pushNamed(context, '/process_investment');
            Navigator.pop(context);
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.45,
            height: 40,
            decoration: BoxDecoration(
              color: currentTheme.isDarkMode
                  ? const Color(primaryDark)
                  : const Color(primaryLightAlternative),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Text(
                "Rentabilidad",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: currentTheme.isDarkMode
                      ? const Color(whiteText)
                      : const Color(primaryDark),
                ),
              ),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.45,
          height: 40,
          decoration: BoxDecoration(
            color: currentTheme.isDarkMode
                ? const Color(primaryLight)
                : const Color(primaryDark),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          child: Center(
            child: GestureDetector(
                onTap: () {
                  // Navigator.pushNamed(context, '/investment_history');
                },
                child: Text(
                  "Mi historial",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: currentTheme.isDarkMode
                        ? const Color(primaryDark)
                        : const Color(whiteText),
                  ),
                )),
          ),
        ),
      ],
    );
  }
}

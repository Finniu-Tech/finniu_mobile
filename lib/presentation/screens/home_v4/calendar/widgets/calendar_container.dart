import 'package:finniu/presentation/providers/important_days_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/calendar_v2/v2_calendar.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CalendarContainer extends ConsumerWidget {
  const CalendarContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final importantDays = ref.watch(importantDaysFutureProvider);
    final DateTime currentDate = DateTime.now();
    final DateTime selectedDate = DateTime.now();
    return importantDays.when(
      data: (data) {
        return CalendarBody(
          isDarkMode: isDarkMode,
          currentDay: currentDate,
          selectedDay: selectedDate,
          importantDays: data,
        );
      },
      loading: () => Center(
        child: Container(
          width: 280,
          height: 280,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black.withOpacity(0.1),
          ),
          alignment: Alignment.center,
          child: const CircularLoader(
            width: 50,
            height: 50,
          ),
        ),
      ),
      error: (error, stackTrace) => Center(
        child: Container(
          width: 280,
          height: 280,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black.withOpacity(0.1),
          ),
          alignment: Alignment.center,
          child: const Text("Error obteniendo calendario"),
        ),
      ),
    );
  }
}

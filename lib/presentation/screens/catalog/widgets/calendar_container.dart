import 'package:finniu/presentation/providers/important_days_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CalendarContainer extends ConsumerWidget {
  const CalendarContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final importantDays = ref.watch(importantDaysFutureProvider);

    return importantDays.when(
      data: (data) {
        return CalendarBody(
          importantDays: data,
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stack) => Center(
        child: Text(error.toString()),
      ),
    );
  }
}

class CalendarBody extends ConsumerWidget {
  const CalendarBody({
    super.key,
    required List importantDays,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int calendarDark = 0xff1E1E1E;
    const int calendarLight = 0xffEEFBFF;
    const int textColorDark = 0xffA2E6FA;
    const int textColorLight = 0xff0D3A5C;
    const int textNotMonthDark = 0xff7C7C7C;
    const int textNotMonthLight = 0xff7C7C7C;
    const int borderColorDark = 0xff3C3C3C;
    const int borderColorLight = 0xff000000;

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color:
            isDarkMode ? const Color(calendarDark) : const Color(calendarLight),
      ),
      width: 270,
      height: 280.0,
      child: CalendarCarousel(
        width: 289,
        height: 289,
        daysHaveCircularBorder: true,
        headerMargin: const EdgeInsets.symmetric(vertical: 1.0),
        locale: 'es',
        dayPadding: 4,
        thisMonthDayBorderColor: isDarkMode
            ? const Color(borderColorDark)
            : const Color(borderColorLight),
        prevMonthDayBorderColor: isDarkMode
            ? const Color(borderColorDark)
            : const Color(borderColorLight),
        nextMonthDayBorderColor: isDarkMode
            ? const Color(borderColorDark)
            : const Color(borderColorLight),
        todayBorderColor: isDarkMode
            ? const Color(borderColorDark)
            : const Color(borderColorLight),
        todayButtonColor: Colors.transparent,
        todayTextStyle: TextStyle(
          color: isDarkMode
              ? const Color(textColorDark)
              : const Color(textColorLight),
          fontSize: 11.0,
          fontWeight: FontWeight.bold,
        ),
        daysTextStyle: TextStyle(
          color: isDarkMode
              ? const Color(textColorDark)
              : const Color(textColorLight),
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
        weekendTextStyle: TextStyle(
          color: isDarkMode
              ? const Color(textColorDark)
              : const Color(textColorLight),
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
        prevDaysTextStyle: TextStyle(
          color: isDarkMode
              ? const Color(textNotMonthDark)
              : const Color(textNotMonthLight),
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
        nextDaysTextStyle: TextStyle(
          color: isDarkMode
              ? const Color(textNotMonthDark)
              : const Color(textNotMonthLight),
          fontSize: 11.0,
          fontWeight: FontWeight.bold,
        ),
        weekdayTextStyle: TextStyle(
          color: isDarkMode
              ? const Color(textColorDark)
              : const Color(textColorLight),
          fontSize: 11.0,
          fontWeight: FontWeight.bold,
        ),
        iconColor: isDarkMode
            ? const Color(textColorDark)
            : const Color(textColorLight),
        headerTextStyle: TextStyle(
          color: isDarkMode
              ? const Color(textColorDark)
              : const Color(textColorLight),
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
        customWeekDayBuilder: (weekday, weekdayName) {
          return Text(
            weekdayName[0].toUpperCase(),
            style: TextStyle(
              color: isDarkMode
                  ? const Color(textColorDark)
                  : const Color(textColorLight),
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
            ),
          );
        },
        dayCrossAxisAlignment: CrossAxisAlignment.center,
        dayMainAxisAlignment: MainAxisAlignment.center,
        dayButtonColor: Colors.transparent,
        customDayBuilder: (
          bool isSelectable,
          int index,
          bool isSelectedDay,
          bool isToday,
          bool isPrevMonthDay,
          TextStyle textStyle,
          bool isNextMonthDay,
          bool isThisMonthDay,
          DateTime day,
        ) {
          Color backgroundColor = isDarkMode
              ? const Color(calendarDark)
              : const Color(calendarLight);
          Color borderColor = isThisMonthDay && !isSelectable
              ? Color(isDarkMode ? borderColorDark : borderColorLight)
              : Colors.transparent;

          return Center(
            child: Container(
              width: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: backgroundColor,
                border: Border.all(
                  color: borderColor,
                  width: 1.2,
                ),
              ),
              child: Center(
                child: Text(
                  '${day.day}',
                  style: textStyle,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

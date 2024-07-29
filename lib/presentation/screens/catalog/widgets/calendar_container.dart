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
//    const int textTodayDark = 0xff000000;
    //   const int textTodayLight = 0xffFFFFFF;
    //   const int backgroundTodayDark = 0xff000000;
    //  const int backgroundTodayLight = 0xffFFFFFF;
    const int borderColorDark = 0xff3C3C3C;
    const int borderColorLight = 0xff000000;
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color:
            isDarkMode ? const Color(calendarDark) : const Color(calendarLight),
      ),
      width: 289,
      height: 280.0,
      child: CalendarCarousel(
          width: 289,
          height: 289,
          daysHaveCircularBorder: true,
          headerMargin: const EdgeInsets.symmetric(vertical: 1.0),
          locale: 'es',
          dayPadding: 4,
          // selected month border, previous , next and today
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
          //------------------------------------------------
          // text style month,( today , day , weekend , prev , next )
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
          //---------------------------------------------------
          // style button today
          todayButtonColor: Colors.transparent,
          //---------------------------------------------------
          //days of week style
          weekdayTextStyle: TextStyle(
            color: isDarkMode
                ? const Color(textColorDark)
                : const Color(textColorLight),
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
          ),

          //---------------------------------------------------
          // icons style navigation
          iconColor: isDarkMode
              ? const Color(textColorDark)
              : const Color(textColorLight),

          //---------------------------------------------------
          // header text
          headerTextStyle: TextStyle(
            color: isDarkMode
                ? const Color(textColorDark)
                : const Color(textColorLight),
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
          headerText: "jills"
          //---------------------------------------------------
          //onCalendarChanged: _handlePageChange,

          //selectedDateTime: widget.selectedDay,

          // headerText: _selectedMonth,
          // onDayPressed: (DateTime date, List events) {
          //   setState(() => selectedDay = date);
          // },
          ),
    );
  }
}

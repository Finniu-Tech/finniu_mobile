import 'package:finniu/presentation/providers/calendar_provider.dart';
import 'package:finniu/presentation/providers/important_days_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/business_investments/widgets/app_bar_business.dart';
import 'package:finniu/presentation/screens/calendar_v2/widgets/tab_payments_widget.dart';
// import 'package:finniu/presentation/screens/business_investments/widgets/tab_bar_business.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

bool hasImportantDates(List<dynamic> importantDays, DateTime selectedDate) {
  for (final item in importantDays) {
    final itemDate = item['date'];
    if (itemDate.month == selectedDate.month && itemDate.year == selectedDate.year) {
      return true;
    }
  }
  return false;
}

String formatDateWithCapitalizedMonth(DateTime date) {
  String formattedDate = DateFormat('MMMM y', 'es').format(date).toString();
  return formattedDate[0].toUpperCase() + formattedDate.substring(1);
}

class CalendarV2 extends StatefulHookConsumerWidget {
  const CalendarV2({super.key});

  @override
  ConsumerState<CalendarV2> createState() => CalendarState();
}

class CalendarState extends ConsumerState<CalendarV2> {
  final DateTime _currentDate = DateTime.now();
  final DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('es');
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    return Scaffold(
      appBar: const AppBarBusinessScreen(
        title: "Mi calendario de pagos",
      ),
      bottomNavigationBar: const NavigationBarHome(),
      body: SingleChildScrollView(
        child: HookBuilder(
          builder: (context) {
            final importantDays = ref.watch(importantDaysFutureProvider);

            return importantDays.when(
              data: (data) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CalendarBody(
                          isDarkMode: isDarkMode,
                          currentDay: _currentDate,
                          selectedDay: _selectedDate,
                          importantDays: data,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const TextPoppins(
                        text: "Historial de inversiones",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 10),
                      const TabPaymentsWidget(),
                    ],
                  ),
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stack) => Center(
                child: Text(error.toString()),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CalendarBody extends ConsumerStatefulWidget {
  final bool isDarkMode;
  final DateTime currentDay;
  final DateTime selectedDay;
  final List<dynamic> importantDays;

  const CalendarBody({
    super.key,
    required this.isDarkMode,
    required this.currentDay,
    required this.selectedDay,
    required this.importantDays,
  });

  @override
  CalendarBodyState createState() => CalendarBodyState();
}

class CalendarBodyState extends ConsumerState<CalendarBody> {
  DateTime _currentDate = DateTime.now();
  late PageController _pageController;
  List<DateTime> markedDays = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentDate.month - 1,
    );
    markedDays = extractDates(widget.importantDays);
  }

  List<DateTime> extractDates(List<dynamic> importantDays) {
    List<DateTime> dates = [];
    for (final item in importantDays) {
      final itemDate = item['date'];
      dates.add(itemDate);
    }
    return dates;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handlePageChange(DateTime date) {
    print('hsnflr page change $date');
    setState(() {
      _currentDate = date;
    });
    ref.read(selectedCalendarDateProvider.notifier).state = DateTime(date.year, date.month, 1);
  }

  @override
  Widget build(BuildContext context) {
    DateFormat('MMMM y', 'es').format(widget.selectedDay);
    const int calendarDark = 0xff1E1E1E;
    const int calendarLight = 0xffEEFBFF;
    const int textColorDark = 0xffA2E6FA;
    const int textColorLight = 0xff0D3A5C;
    const int textMarkerColorDark = 0xff000000;
    const int textMarkerColorLight = 0xffFFFFFF;
    const int textNotMonthDark = 0xff7C7C7C;
    const int textNotMonthLight = 0xff7C7C7C;
//    const int textTodayDark = 0xff000000;
    //   const int textTodayLight = 0xffFFFFFF;
    //   const int backgroundTodayDark = 0xff000000;
    //  const int backgroundTodayLight = 0xffFFFFFF;
    const int borderColorDark = 0xff3C3C3C;
    const int borderColorLight = 0xff000000;
    bool isDarkMode = widget.isDarkMode;
    return Center(
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 289,
          maxHeight: 280,
        ),
        padding: const EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width * 0.90,
        height: MediaQuery.of(context).size.height * 0.40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: widget.isDarkMode ? const Color(calendarDark) : const Color(calendarLight),
        ),
        child: CalendarCarousel(
          leftButtonIcon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: isDarkMode ? const Color(textColorDark) : const Color(textColorLight),
          ),
          rightButtonIcon: Icon(
            Icons.arrow_forward_ios_outlined,
            color: isDarkMode ? const Color(textColorDark) : const Color(textColorLight),
          ),
          onCalendarChanged: _handlePageChange,
          width: 289,

          daysHaveCircularBorder: true,
          headerText: formatDateWithCapitalizedMonth(_currentDate),
          headerMargin: const EdgeInsets.symmetric(vertical: 1.0),
          locale: 'es',
          dayPadding: 1,
          todayBorderColor: Colors.transparent,
          markedDateIconBorderColor: Colors.transparent,
          //------------------------------------------------
          // text style month,( today , day , weekend , prev , next )
          todayTextStyle: TextStyle(
            color: isDarkMode ? const Color(textColorDark) : const Color(textColorLight),
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
          ),
          daysTextStyle: TextStyle(
            color: isDarkMode ? const Color(textColorDark) : const Color(textColorLight),
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
          weekendTextStyle: TextStyle(
            color: isDarkMode ? const Color(textColorDark) : const Color(textColorLight),
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
          prevDaysTextStyle: TextStyle(
            color: isDarkMode ? const Color(textNotMonthDark) : const Color(textNotMonthLight),
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
          nextDaysTextStyle: TextStyle(
            color: isDarkMode ? const Color(textNotMonthDark) : const Color(textNotMonthLight),
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
          ),
          //---------------------------------------------------
          // style button today
          todayButtonColor: Colors.transparent,
          //---------------------------------------------------
          //days of week style
          weekdayTextStyle: TextStyle(
            color: isDarkMode ? const Color(textColorDark) : const Color(textColorLight),
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
          ),

          //---------------------------------------------------
          // icons style navigation
          iconColor: isDarkMode ? const Color(textColorDark) : const Color(textColorLight),

          //---------------------------------------------------
          // header text
          headerTextStyle: TextStyle(
            color: isDarkMode ? const Color(textColorDark) : const Color(textColorLight),
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
          //---------------------------------------------------
          weekDayFormat: WeekdayFormat.narrow,
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
            final isMarkedDay = markedDays.contains(day);
            Color backgroundColor = Color(
              isDarkMode ? (calendarDark) : (calendarLight),
            );
            Color borderColor = isThisMonthDay && !isSelectable
                ? Color(
                    isDarkMode ? borderColorDark : borderColorLight,
                  )
                : Color(
                    isDarkMode ? borderColorDark : borderColorLight,
                  );
            if (isThisMonthDay && !isSelectable && !isSelectedDay && !isPrevMonthDay && !isNextMonthDay) {
              borderColor = Color(
                isDarkMode ? borderColorDark : borderColorLight,
              );
            }
            if (!isThisMonthDay) {
              borderColor = Color(
                isDarkMode ? borderColorDark : borderColorLight,
              );
            }
            if (isSelectedDay) {
              backgroundColor = Color(
                (isDarkMode ? (calendarDark) : (calendarLight)),
              );
              // borderColor = Colors.transparent;
            }
            if (isMarkedDay) {
              backgroundColor = Color(
                (isDarkMode ? (calendarDark) : (calendarLight)),
              );
              backgroundColor = isDarkMode ? const Color(textColorDark) : const Color(textColorLight);
              textStyle = TextStyle(
                color: isDarkMode ? const Color(textMarkerColorDark) : const Color(textMarkerColorLight),
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
              );
            }
            if (!isThisMonthDay) {
              textStyle = TextStyle(
                color: isDarkMode ? const Color(textNotMonthDark) : const Color(textNotMonthLight),
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
              );
            }

            return Container(
              width: 40,
              // height: 35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: backgroundColor,
                border: Border.all(
                  color: borderColor,
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  '${day.day}',
                  style: textStyle,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

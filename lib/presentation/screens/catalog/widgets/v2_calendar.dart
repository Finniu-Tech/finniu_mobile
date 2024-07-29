import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/important_days_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/navigation_bar.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../business_investments/widgets/app_bar_business.dart';

bool hasImportantDates(List<dynamic> importantDays, DateTime selectedDate) {
  for (final item in importantDays) {
    final itemDate = item['date'];
    if (itemDate.month == selectedDate.month &&
        itemDate.year == selectedDate.year) {
      return true;
    }
  }
  return false;
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
    initializeDateFormatting('es'); // Inicializa el formato de fecha en español
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    return Scaffold(
      appBar: const AppBarBusinessScreen(),
      bottomNavigationBar: const NavigationBarHome(),
      body: SingleChildScrollView(
        child: HookBuilder(
          builder: (context) {
            final importantDays = ref.watch(importantDaysFutureProvider);

            return importantDays.when(
              data: (data) {
                return CalendarBody(
                  isDarkMode: isDarkMode,
                  currentDay: _currentDate,
                  selectedDay: _selectedDate,
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
          },
        ),
      ),
    );
  }
}

class CalendarBody extends StatefulWidget {
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

class CalendarBodyState extends State<CalendarBody> {
  DateTime _currentDate = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  String _selectedMonth = DateFormat('MMMM y', 'es').format(DateTime.now());
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
    setState(() {
      _currentDate = date;
      _selectedMonth = DateFormat('MMMM y', 'es').format(date);
    });
  }

  @override
  Widget build(BuildContext context) {
    DateFormat('MMMM y', 'es').format(widget.selectedDay);
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
    bool isDarkMode = widget.isDarkMode;
    return Center(
      child: SizedBox(
        width: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 320,
              child: Text(
                'Calendario de mis inversiones  🗓️',
                style: TextStyle(
                  color: widget.isDarkMode
                      ? const Color(textColorDark)
                      : const Color(textColorLight),
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 330,
                    maxHeight: 350,
                  ),
                  width: MediaQuery.of(context).size.width * 0.90,
                  height: MediaQuery.of(context).size.height * 0.40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: widget.isDarkMode
                        ? const Color(calendarDark)
                        : const Color(calendarLight),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CalendarCarousel(
                      onCalendarChanged: _handlePageChange,
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
                      //---------------------------------------------------
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
                        final isMarkedDay = markedDays.contains(day);
                        Color backgroundColor = Color(
                          isDarkMode ? (calendarDark) : (calendarLight),
                        );
                        Color borderColor = isThisMonthDay && !isSelectable
                            ? Color(
                                isDarkMode ? borderColorDark : borderColorLight,
                              )
                            : Color(
                                isDarkMode ? calendarDark : calendarLight,
                              );
                        if (isThisMonthDay &&
                            !isSelectable &&
                            !isSelectedDay &&
                            !isPrevMonthDay &&
                            !isNextMonthDay) {
                          borderColor = Color(
                            isDarkMode ? borderColorDark : borderColorLight,
                          );
                        }
                        if (!isThisMonthDay) {
                          borderColor = Colors.transparent;
                        }
                        if (isSelectedDay) {
                          backgroundColor = Color(
                            (isDarkMode ? (calendarLight) : (calendarDark)),
                          );
                          // borderColor = Colors.transparent;
                        }
                        if (isMarkedDay) {
                          backgroundColor = Color(
                            (isDarkMode ? (calendarDark) : (calendarLight)),
                          );
                          borderColor = Colors.black;
                          textStyle = const TextStyle(
                            color: Colors.white,
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                          );
                        }

                        if (!isThisMonthDay) {
                          textStyle = TextStyle(
                            color: isDarkMode
                                ? const Color(textNotMonthDark)
                                : const Color(textNotMonthLight),
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                          );
                        }

                        return Center(
                          child: Container(
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
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImportantDayCard extends ConsumerWidget {
  final DateTime date;
  final String description;
  const ImportantDayCard({
    super.key,
    required this.date,
    required this.description,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    DateFormat dateFormat = DateFormat.MMMM('es');
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        alignment: Alignment.center,
        width: 290,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: currentTheme.isDarkMode
              ? const Color(primaryLight)
              : const Color(primaryLightAlternative),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.9),
              spreadRadius: 0,
              blurRadius: 0,
              offset: const Offset(
                0,
                3,
              ), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${date.day} de ${dateFormat.format(date)}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(blackText),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              description,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Color(blackText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

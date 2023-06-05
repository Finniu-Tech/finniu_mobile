import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/important_days_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class Calendar extends StatefulHookConsumerWidget {
  const Calendar({super.key});

  @override
  ConsumerState<Calendar> createState() => CalendarState();
}

class CalendarState extends ConsumerState<Calendar> {
  DateTime _currentDate = DateTime.now();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('es'); // Inicializa el formato de fecha en español
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(settingsNotifierProvider);

    return CustomScaffoldReturnLogo(
      body: SingleChildScrollView(
        child: HookBuilder(
          builder: (context) {
            final importantDays = ref.watch(importantDaysFutureProvider);
            return importantDays.when(
              data: (data) {
                return CalendarBody(
                  currentTheme: currentTheme,
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

class CalendarBody extends StatelessWidget {
  final currentTheme;
  final currentDay;
  final selectedDay;
  final importantDays;
  const CalendarBody({
    super.key,
    required this.currentTheme,
    required this.currentDay,
    required this.selectedDay,
    required this.importantDays,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 280,
            child: Text(
              'Calendario de mis inversiones  🗓️',
              style: TextStyle(
                color: currentTheme.isDarkMode
                    ? const Color(primaryLight)
                    : const Color(primaryDark),
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
                width: MediaQuery.of(context).size.width * 0.90,
                height: MediaQuery.of(context).size.height * 0.40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: currentTheme.isDarkMode
                      ? const Color(bluedarkalternative)
                      : const Color(secondary),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CalendarCarousel(
                    headerMargin: const EdgeInsets.symmetric(vertical: 1.0),
                    selectedDateTime: selectedDay,
                    prevMonthDayBorderColor: Colors.transparent,
                    nextMonthDayBorderColor: Colors.transparent,
                    thisMonthDayBorderColor: Colors.transparent,
                    daysHaveCircularBorder: true,
                    todayBorderColor: Colors.transparent,
                    todayButtonColor: Colors.transparent,
                    selectedDayButtonColor: Colors.transparent,
                    // onDayPressed: (DateTime date, List events) {
                    //   setState(() => selectedDay = date);
                    // },
                    locale: 'es', // Establece el idioma en español

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
                      Color backgroundColor = Color(
                        currentTheme.isDarkMode
                            ? (bluedarkalternative)
                            : (secondary),
                      );
                      Color borderColor = isThisMonthDay && !isSelectable
                          ? Color(
                              currentTheme.isDarkMode ? graylight : graydark)
                          : Color(currentTheme.isDarkMode
                              ? primaryLight
                              : primaryDark);
                      if (isThisMonthDay &&
                          !isSelectable &&
                          !isSelectedDay &&
                          !isPrevMonthDay &&
                          !isNextMonthDay) {
                        borderColor = Color(currentTheme.isDarkMode
                            ? primaryLight
                            : primaryDark);
                      }
                      if (!isThisMonthDay) {
                        borderColor = Colors
                            .transparent; // establece el color del borde en transparente para los días que no son del mes actual
                      }
                      if (isSelectedDay) {
                        backgroundColor = Color((currentTheme.isDarkMode
                            ? (primaryLight)
                            : (primaryDark)));
                        // borderColor = Colors.transparent;
                      }

                      if (!isThisMonthDay) {
                        textStyle = TextStyle(
                          color: currentTheme.isDarkMode
                              ? Color(graydark)
                              : Color(graylight),
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                        );
                      }

                      return Center(
                        child: Container(
                          width: 30,
                          // height: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: backgroundColor,
                            border: Border.all(
                              color: borderColor,
                              width: 1.2,
                            ),
                            boxShadow: isSelectedDay
                                ? [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.9),
                                      spreadRadius: 0,
                                      blurRadius: 0,
                                      offset: const Offset(0, 5),
                                    )
                                  ]
                                : (isSelectable ? null : []),
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

                    headerTextStyle: TextStyle(
                      color: currentTheme.isDarkMode
                          ? const Color(primaryLight)
                          : const Color(primaryDark),
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    headerText: DateFormat('MMMM y', 'es').format(selectedDay),

                    weekdayTextStyle: TextStyle(
                      color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(primaryDark),
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),

                    weekendTextStyle: TextStyle(
                      color: currentTheme.isDarkMode
                          ? const Color(whiteText)
                          : const Color(primaryDark),
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                    ),
                    daysTextStyle: TextStyle(
                        color: currentTheme.isDarkMode
                            ? const Color(whiteText)
                            : const Color(primaryDark),
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold),
                    prevDaysTextStyle: TextStyle(
                        color: currentTheme.isDarkMode
                            ? const Color(whiteText)
                            : const Color(primaryDark),
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold),
                    nextDaysTextStyle: TextStyle(
                        color: currentTheme.isDarkMode
                            ? const Color(whiteText)
                            : const Color(primaryDark),
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold),
                    selectedDayTextStyle: TextStyle(
                      color: currentTheme.isDarkMode
                          ? const Color(primaryDark)
                          : const Color(whiteText),
                      fontSize: 11.0,
                    ),

                    selectedDayBorderColor: Colors.transparent,
                    // width: 1,

                    weekDayFormat: WeekdayFormat.narrow,
                    // weekDayPadding: const EdgeInsets.symmetric(horizontal: 1),
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 35),
              child: Text(
                'Fechas importantes de Mayo',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: currentTheme.isDarkMode
                      ? const Color(whiteText)
                      : const Color(blackText),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: ListView(
              children: importantDays!
                  .map<Widget>((e) => ImportantDayCard(
                        currentTheme: currentTheme,
                        date: e['date'],
                        description: e['description'],
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}

class ImportantDayCard extends StatelessWidget {
  String date;
  String description;
  ImportantDayCard({
    super.key,
    required this.currentTheme,
    required this.date,
    required this.description,
  });

  final currentTheme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
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
              date,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(blackText),
              ),
            ),
            const SizedBox(
              height: 4,
            ), // Agrega un espacio de 4 píxeles entre los dos textos
            Text(
              description,
              style: TextStyle(
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

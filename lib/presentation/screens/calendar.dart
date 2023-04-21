import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
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
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: currentTheme.isDarkMode
                        ? const Color(primaryDark)
                        : const Color(secondary),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CalendarCarousel(
                      selectedDateTime: _selectedDate,
                      onDayPressed: (DateTime date, List events) {
                        setState(() => _selectedDate = date);
                      },
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
                        Color backgroundColor = Color(currentTheme.isDarkMode
                            ? (primaryDark)
                            : (secondary));
                        Color borderColor = Color((currentTheme.isDarkMode
                            ? (primaryLight)
                            : (primaryDark)));

                        if (isSelectedDay) {
                          backgroundColor = Color((currentTheme.isDarkMode
                              ? (primaryLight)
                              : (primaryDark)));
                          borderColor = Color((currentTheme.isDarkMode
                              ? (primaryLight)
                              : (primaryDark)));
                        }

                        return Center(
                          child: Container(
                            width: 30,
                            height: 30,
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

                      headerTextStyle: TextStyle(
                        color: currentTheme.isDarkMode
                            ? const Color(primaryLight)
                            : const Color(primaryDark),
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      headerText:
                          DateFormat('MMMM y', 'es').format(_selectedDate),

                      weekdayTextStyle: TextStyle(
                        color: currentTheme.isDarkMode
                            ? Color(whiteText)
                            : Color(primaryDark),
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                      weekendTextStyle: TextStyle(
                        color: currentTheme.isDarkMode
                            ? Color(whiteText)
                            : Color(primaryDark),
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                      ),
                      daysTextStyle: TextStyle(
                          color: currentTheme.isDarkMode
                              ? Color(whiteText)
                              : Color(primaryDark),
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold),
                      thisMonthDayBorderColor: Color(primaryLight),
                      prevDaysTextStyle: TextStyle(
                          color: currentTheme.isDarkMode
                              ? Color(whiteText)
                              : Color(primaryDark),
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold),
                      nextDaysTextStyle: TextStyle(
                          color: currentTheme.isDarkMode
                              ? Color(whiteText)
                              : Color(primaryDark),
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold),
                      prevMonthDayBorderColor: Color(primaryDark),
                      nextMonthDayBorderColor: Color(primaryDark),
                      selectedDayTextStyle: TextStyle(
                        color: currentTheme.isDarkMode
                            ? Color(primaryDark)
                            : Color(whiteText),
                        fontSize: 11.0,
                      ),
                      selectedDayButtonColor: currentTheme.isDarkMode
                          ? Color(primaryLight)
                          : Color(primaryDark),
                      selectedDayBorderColor: Color(primaryDark), width: 1,

                      weekDayFormat: WeekdayFormat.short,
                      weekDayPadding: EdgeInsets.symmetric(horizontal: 1),
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
            SizedBox(
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 28),
              child: Center(
                child: Container(
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
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 0,
                          blurRadius: 0,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '29 de Mayo',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(blackText),
                        ),
                      ),
                      SizedBox(
                          height:
                              4), // Agrega un espacio de 4 píxeles entre los dos textos
                      Text(
                        'Fecha de pago de tu inversion Plan Estable',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Color(blackText),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

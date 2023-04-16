import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart';
 


class Calendar extends StatefulWidget {
  @override

  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
      Locale myLocale = const Locale('es');
  DateTime _currentDate = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  
  @override
  Widget build(BuildContext context) {
    return CustomScaffoldReturnLogo(
     
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
          
          children: [
         
        Padding(
          padding: const EdgeInsets.only(right: 60),
          child: Container(width: 260,
            child: const Text(
              
              'Calendario de mis inversiones🗓️',
              style: TextStyle(
             fontSize: 24.0,
             fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
          
          const SizedBox(height: 20,),
          Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: Color(gradient_secondary),),
            child: CalendarCarousel(
                   selectedDateTime: _selectedDate,
                   onDayPressed: (DateTime date, List events) {
             this.setState(() => _selectedDate = date);
                   },
                   weekendTextStyle: const TextStyle(
             color: Color(primaryDark),
                   ),
                   thisMonthDayBorderColor: Colors.grey,
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
                    String dateFormat = 'EEEE d MMMM';
                  String dayOfWeek = DateFormat(dateFormat).format(day); // obtener el día de la semana en español
String dayOfMonth = day.day.toString(); // obtener el primer dígito del día del mes
             if (isToday) {
               return Center(
                 child: Container(
                   decoration: BoxDecoration(
                     color: Color(primaryDark),
                     borderRadius: BorderRadius.circular(50.0),
                   ),
                   child: Center(
                     child: Text(
                      DateFormat('d', 'es').format(day),
                       style: const TextStyle(
                        color: Color(whiteText),
                       ),
                     ),
                   ),
                 ),
               );
          
             } else {
               return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(primaryDark),
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
             }
                   },
                   height: 420.0,
                   selectedDayTextStyle: const TextStyle(
             color: Colors.yellow,
                   ),
                   selectedDayButtonColor: const Color(primaryDark),
                   selectedDayBorderColor: Colors.transparent,
                   todayTextStyle: const TextStyle(
             color: Colors.white,
                   ),
                   showHeaderButton: true,
                   iconColor: const Color(primaryDark),
                   headerTextStyle: const TextStyle(
             color: Color(primaryDark),
                   ),
            ),
          ),
         
        Padding(           padding: const EdgeInsets.all(12.0),
       child: Container(alignment: Alignment.centerLeft,               child: const Text(
   'Fechas importantes de Mayo',                  
        style: TextStyle(
            fontSize: 16,
                        
                           color: 
                                Color(blackText),
                         ),
                       ),
              ),
             ),
           
           Padding(
             padding: const EdgeInsets.only(right:28),
             child: Container(alignment: Alignment.center,              width: 290,height: 75,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),   color: Color(primaryLightAlternative),),
             
           
                  child: Column(mainAxisAlignment:MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,
                  children:const [Text(
                          '29 de Mayo',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: 
                                 Color(blackText),
                          ),
                        ),
                  SizedBox(height: 4), // Agrega un espacio de 4 píxeles entre los dos textos
                     Text(
              'Fecha de pago de tu inversion Plan Estable',
              style: TextStyle(
              fontSize: 10,
              color: Color(blackText),
              ),
                
                
                ),
              ],
              ),
             
        ),
      ),
      ],
      ),
      ),
      );
  }
}













// class Calendar extends StatelessWidget {
//   const Calendar({super.key});


//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(

//       theme:  ThemeData(
      
//         primarySwatch: Colors.blueGrey,
//       ),
//       home:  const MyHomePage(title: 'Calendario Finniu'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;

//   @override

  
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//  @override

//   DateTime _currentDate = DateTime(2023, 2, 3);
//   DateTime _currentDate2 = DateTime(2023, 2, 3);
//   String _currentMonth = DateFormat.yMMM().format(DateTime(2023, 2, 3));
//   DateTime _targetDateTime = DateTime(2023, 2, 3);

//   static final Widget _eventIcon = Container(
//     decoration: BoxDecoration(
      
//         color: Color(secondary),
//         borderRadius: const BorderRadius.all(Radius.circular(1000)),
//         border: Border.all(color: Colors.blue, width: 2.0),),
//     child: const Icon(
//       Icons.person,
//       color: Colors.amber,
//     ),
//   );

//   final EventList<Event> _markedDateMap = EventList<Event>(
//     events: {
//        DateTime(2023, 2, 10): [
//          Event(
//           date:  DateTime(2023, 2, 10),
//           title: 'Event 1',
//           icon: _eventIcon,
//           dot: Container(
//             margin: const EdgeInsets.symmetric(horizontal: 1.0),
//             color: Colors.red,
//             height: 5.0,
//             width: 5.0,
//           ),
//         ),
//         Event(
//           date:  DateTime(2023, 2, 10),
//           title: 'Event 2',
//           icon: _eventIcon,
//         ),
//         Event(
//           date:  DateTime(2023, 2, 10),
//           title: 'Event 3',
//           icon: _eventIcon,
//         ),
//       ],
//     },
//   );

//   @override
//   void initState() {
//      super.initState();
//     initializeDateFormatting('es_ES', null);
//     _markedDateMap.add(
//         DateTime(2023, 2, 25),
//         Event(
//           date:  DateTime(2023, 2, 25),
//           title: 'Event 5',
//           icon: _eventIcon,
//         ),
//         );

//     _markedDateMap.add(
//          DateTime(2023, 2, 10),
//        Event(
//           date: DateTime(2023, 2, 10),
//           title: 'Event 4',
//           icon: _eventIcon,
//         ),
//         );

//     _markedDateMap.addAll( DateTime(2023, 2, 11), [
//        Event(
//         date:  DateTime(2023, 2, 11),
//         title: 'Event 1',
//         icon: _eventIcon,
//       ),
//       Event(
//         date: DateTime(2023, 2, 11),
//         title: 'Event 2',
//         icon: _eventIcon,
//       ),
//        Event(
//         date:  DateTime(2023, 2, 11),
//         title: 'Event 3',
//         icon: _eventIcon,
//       ),
//     ]);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
  
    
  
//     final calendarCarouselNoHeader = CalendarCarousel<Event>(
//       todayBorderColor: Colors.blue,
//       weekdayTextStyle: const TextStyle(color:Color(primaryDark),fontWeight: FontWeight.bold,fontSize: 16),
//       onDayPressed: (date, events) {
//         setState(() => _currentDate2 = date);
//         for (var event in events) {
//           print(event.title);
//         }
//       },
//       daysHaveCircularBorder: true,
//       showOnlyCurrentMonthDate: false,
//       weekendTextStyle: const TextStyle(
//         color: Color(primaryDark),
//       ),
//       thisMonthDayBorderColor: Color(primaryDark),
//       weekFormat: false,
// //      firstDayOfWeek: 4,
//       markedDatesMap: _markedDateMap,
//       height: 420.0,
//       selectedDateTime: _currentDate2,
//       targetDateTime: _targetDateTime,
//       customGridViewPhysics: const NeverScrollableScrollPhysics(),
//       markedDateCustomShapeBorder:
//           const CircleBorder(side: BorderSide(color: Color(primaryDark))),
//       markedDateCustomTextStyle: const TextStyle(
//         fontSize: 18,
//         color: Colors.blue,
//       ),
//       showHeader: false,
//       todayTextStyle: const TextStyle(
//         color: Colors.blue,
//       ),
     
//       todayButtonColor: Color(blackText),
//       selectedDayTextStyle: const TextStyle(
//         color: Color(primaryDark),
//       ),
//       minSelectedDate: _currentDate.subtract(const Duration(days: 360)),
//       maxSelectedDate: _currentDate.add(const Duration(days: 360)),
//       prevDaysTextStyle: const TextStyle(
//         fontSize: 16,
//         color: Color(blackText),
//       ),
//       inactiveDaysTextStyle: const TextStyle(
//         color: Colors.tealAccent,
//         fontSize: 16,
//       ),
//       onCalendarChanged: (DateTime date) {
//         setState(() {
//           _targetDateTime = date;
//           _currentMonth = DateFormat.yMMM().format(_targetDateTime);
//         });
//       },
//       onDayLongPressed: (DateTime date) {
//         print('long pressed date $date');
//       },
//     );

//     return Scaffold(
//         appBar:  AppBar(
//           title: Text(widget.title),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
            
              
//               Container(
//                 margin: const EdgeInsets.only(
//                   top: 30.0,
//                   bottom: 16.0,
//                   left: 16.0,
//                   right: 16.0,
//                 ),
//                 child: Row(
//                   children: <Widget>[
//                     Expanded(
//                         child: Text(
//                       _currentMonth,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 24.0,
//                       ),
//                     ),
//                     ),
                
                   
//                   ],
//                 ),
//               ),
              
//             Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: calendarCarouselNoHeader,
//               ),
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Container(alignment: Alignment.centerLeft,
//                 child: const Text(
//                         'Fechas importantes de Mayo',
//                         style: TextStyle(
//                           fontSize: 16,
                        
//                           color: 
//                                Color(blackText),
//                         ),
//                       ),
//               ),
//             ),
           
//            Padding(
//              padding: const EdgeInsets.only(left:60),
//              child: Container(alignment: Alignment.center,              width: 290,height: 75,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),   color: Color(primaryLightAlternative),),
             
           
//                   child: Column(mainAxisAlignment:MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,
//                   children:const [Text(
//                           '29 de Mayo',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: 
//                                  Color(blackText),
//                           ),
//                         ),
//                   SizedBox(height: 4), // Agrega un espacio de 4 píxeles entre los dos textos
//                      Text(
//               'Fecha de pago de tu inversion Plan Estable',
//               style: TextStyle(
//               fontSize: 10,
//               color: Color(blackText),
//               ),
                
                
//                 ),
//               ],
//               ),
             
//                      ),
//            ),
//           ],
//           ),
//         ),
//         );
//   }
// }
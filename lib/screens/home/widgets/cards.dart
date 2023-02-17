import 'package:finniu/constants/colors.dart';
import 'package:finniu/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

class CardTable extends StatefulWidget {
  const CardTable({super.key});

  @override
  State<CardTable> createState() => _CardTableState();
}

class _CardTableState extends State<CardTable> {
  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context, listen: false);
    return ListView(
      padding: EdgeInsets.only(
        top: 15,
        bottom: 15,
      ),
      scrollDirection: Axis.vertical,
      children: <Widget>[
        Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: <Widget>[
            _SingleCard(
              title: 'Plan Origen',
              text_mount: 'Desde S/500',
              text_percentage: '12% anual',
            ),
            _SingleCard(
              title: 'Plan Estable',
              text_mount: 'Desde S/1,000',
              text_percentage: '14% anual',
            ),
            _SingleCard(
              title: 'Plan Responsable',
              text_mount: 'Desde S/5,000',
              text_percentage: '16% anual',
            ),
            _SingleCard(
              title: 'Plan crecimiento',
              text_mount: 'Desde S/10,000',
              text_percentage: '18%anual',
            )
          ],
        ),
      ],
    );
  }
}

// scrollDirection: Axis.vertical,

// child: Table(
//   children: const [
//     TableRow(children: [
//       _SingleCard(
//         title: 'Plan Origen',
//         text_mount: 'Desde S/500',
//         text_percentage: '12% anual',
//       ),
//       _SingleCard(
//         title: 'Plan Estable',
//         text_mount: 'Desde S/1,000',
//         text_percentage: '14% anual',
//       )
//     ]),
//     TableRow(
//       children: [
//         _SingleCard(
//           title: 'Plan Responsable',
//           text_mount: 'Desde S/5,000',
//           text_percentage: '16% anual',
//         ),
//         _SingleCard(
//           title: 'Plan crecimiento',
//           text_mount: 'Desde S/10,000',
//           text_percentage: '18%anual',
//         )
//       ],
//     ),
//     TableRow(
//       children: [
//         _SingleCard(
//           title: 'Plan Responsable',
//           text_mount: 'Desde S/5,000',
//           text_percentage: '16% anual',
//         ),
//         _SingleCard(
//           title: 'Plan crecimiento',
//           text_mount: 'Desde S/10,000',
//           text_percentage: '18%anual',
//         )
//       ],
//     ),
//   ],
// ),
//     );
//   }
// }

class _SingleCard extends StatelessWidget {
  final String title;
  final String text_mount;
  final String text_percentage;

  const _SingleCard({
    super.key,
    required this.title,
    required this.text_mount,
    required this.text_percentage,
  });

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context, listen: false);
    var column = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      textDirection: TextDirection.ltr,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: currentTheme.isDarkMode ? const Color(0xffA2E6FA) : const Color(primaryDark),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 14.33,
              child: Icon(
                Icons.monetization_on_outlined,
                // size: 14.33,
                color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
              ),
            ),
            Text(
              text_mount,
              style: TextStyle(
                color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(primaryDark),
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 14.33,
              child: Icon(
                Icons.currency_exchange_rounded,
                // size: 11,
                color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
              ),
            ),
            Text(
              text_percentage,
              style: TextStyle(
                  color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(primaryDark),
                  // color: Color(primaryDark),
                  fontSize: 11,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(
          height: 2,
        ),
        SizedBox(
          width: 100,
          height: 23,
          // height: 40,
          child: TextButton(
            onPressed: () {},
            style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
            child: Text(
              'Ir al plan',
              style: TextStyle(
                color: currentTheme.isDarkMode ? const Color(primaryDark) : const Color(whiteText),
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );

    return _CardBackground(child: column);
  }
}

class _CardBackground extends StatelessWidget {
  final Widget child;

  const _CardBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context, listen: false);
    return Container(
      height: 144,
      width: 150,
      // margin: const EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            decoration: BoxDecoration(
              color: currentTheme.isDarkMode ? Colors.transparent : const Color(whiteText),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
                width: 0.5,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

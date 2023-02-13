import 'dart:ui';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:flutter/material.dart';

class CardTable extends StatefulWidget {
  const CardTable({super.key});

  @override
  State<CardTable> createState() => _CardTableState();
}

class _CardTableState extends State<CardTable> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Table(
        children: const [
          TableRow(children: [
            _SingleCard(
              // color: Color(primaryDark),
              title: 'Plan Origen',
              // icon: Icons.paid,
              text_mount: 'Desde S/500',
              text_percentage: '12% anual',
            ),
            _SingleCard(
              // color: Color(primaryDark),
              // icon: Icons.arrow_back,
              title: 'Plan Estable',
              text_mount: 'Desde S/1,000',
              text_percentage: '14% anual',
            )
          ]),
          TableRow(children: [
            _SingleCard(
              // color: Color(primaryDark),
              // icon: Icons.money_off_csred_outlined,
              title: 'Plan Responsable',
              text_mount: 'Desde S/5,000',
              text_percentage: '16% anual',
            ),
            _SingleCard(
              // color: Color(primaryDark),
              // icon: Icons.money_off_csred_outlined,
              title: 'Plan crecimiento',
              text_mount: 'Desde S/10,000',
              text_percentage: '18%anual',
            )
          ]),
        ],
      ),
    );
  }
}

class _SingleCard extends StatelessWidget {
  final String title;
  // final IconData icon;
  // final Color color;
  final String text_mount;
  final String text_percentage;

  const _SingleCard({
    super.key,
    required this.title,
    // required this.icon,
    // required this.color,
    required this.text_mount,
    required this.text_percentage,
  });

  @override
  Widget build(BuildContext context) {
    var column =
        // padding: const EdgeInsets.only(),
        Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      textDirection: TextDirection.ltr,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(primaryDark),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(
                Icons.monetization_on_outlined,
                // size: 14.33,
                color: Color(primaryDark),
              ),
              radius: 14.33,
            ),
            Text(
              text_mount,
              style: const TextStyle(
                color: Color(primaryDark),
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(
                Icons.currency_exchange_rounded,
                // size: 11,
                color: Color(primaryDark),
              ),
              radius: 14.33,
            ),
            Text(
              text_percentage,
              style: const TextStyle(
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
            style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero)),
            child: const Text(
              'Ir al plan',
              style: TextStyle(
                color: Colors.white,
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
    return Container(
      height: 144,
      width: 170,
      margin: const EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            child: child,
            decoration: BoxDecoration(
              color: const Color(whiteText),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(primaryDark),
                width: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

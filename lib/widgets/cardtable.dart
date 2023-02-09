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
              color: Color(primaryDark),
              title: 'Plan Origen',
              icon: Icons.paid,
              text_mount: 'Desde S/500',
              text_percentage: '12% anual',
            ),
            _SingleCard(
              color: Color(primaryDark),
              icon: Icons.money_off_csred_outlined,
              title: 'Plan Estable',
              text_mount: 'Desde S/1,000',
              text_percentage: '14% anual',
            )
          ]),
          TableRow(children: [
            _SingleCard(
              color: Color(primaryDark),
              icon: Icons.money_off_csred_outlined,
              title: 'Plan Responsable',
              text_mount: 'Desde S/5,000',
              text_percentage: '16% anual',
            ),
            _SingleCard(
              color: Color(primaryDark),
              icon: Icons.money_off_csred_outlined,
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
  final IconData icon;
  final Color color;
  final String text_mount;
  final String text_percentage;

  const _SingleCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.text_mount,
    required this.text_percentage,
  });

  @override
  Widget build(BuildContext context) {
    var column = Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          children: [
            CircleAvatar(
              backgroundColor: color,
              child: Icon(
                icon,
                size: 14.33,
                color: Colors.white,
              ),
              radius: 14.33,
            ),
            Text(
              text_mount,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Row(
          children: [
            CircleAvatar(
              backgroundColor: color,
              child: Icon(
                icon,
                size: 14.33,
                color: Colors.white,
              ),
              radius: 14.33,
            ),
            Text(
              text_percentage,
              style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        CustomButton(
          text: "Ir al plan",
          width: 100,
          height: 23,
        )
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
      margin: EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            child: child,
            decoration: BoxDecoration(
              color: Color(whiteText),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(primaryDark),
                width: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

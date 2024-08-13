import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/tour_modal/button_icon_tour.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/tour_modal/state_tour.dart';
import 'package:flutter/material.dart';

class BodyTour extends StatelessWidget {
  const BodyTour({
    super.key,
    required this.title,
    required this.textColor,
    required this.textBody,
    required this.onPressed,
    required this.onClosePressed,
    required this.indexTour,
  });

  final String title;
  final int textColor;
  final String textBody;
  final VoidCallback? onPressed;
  final VoidCallback? onClosePressed;
  final int indexTour;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        StateTour(
          items: 6,
          indexTour: indexTour,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextPoppins(
            text: title,
            fontSize: 20,
            isBold: true,
            textDark: textColor,
            textLight: textColor,
            align: TextAlign.start,
            lines: 2,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextPoppins(
            text: textBody,
            fontSize: 16,
            isBold: false,
            textDark: textColor,
            textLight: textColor,
            lines: 2,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ButtonCloseTour(
                widthPercent: 0.4,
                onPressed: onClosePressed,
                label: "Saltar",
              ),
              const SizedBox(
                width: 10,
              ),
              ButtonIconTour(
                widthPercent: 0.4,
                onPressed: onPressed,
                label: "Comenzar",
              ),
            ],
          ),
        ),
      ],
    );
  }
}

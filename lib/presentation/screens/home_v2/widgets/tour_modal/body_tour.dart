import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/tour_modal/button_icon_tour.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/tour_modal/state_tour.dart';
import 'package:flutter/material.dart';

class BodyTour extends StatelessWidget {
  const BodyTour({
    super.key,
    required this.pageLength,
    required this.title,
    required this.textColor,
    required this.textBody,
    required this.onPressed,
    required this.onClosePressed,
    required this.indexTour,
    this.eyeRender = false,
    this.isFinal = false,
  });

  final String title;
  final int textColor;
  final String textBody;
  final VoidCallback? onPressed;
  final VoidCallback? onClosePressed;
  final int indexTour;
  final bool eyeRender;
  final bool isFinal;
  final int pageLength;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          eyeRender
              ? Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset(
                    "assets/tour/eye_down_two.png",
                    width: 106,
                    height: 120,
                  ),
                )
              : const SizedBox(),
          isFinal
              ? Positioned(
                  bottom: 10,
                  right: 40,
                  child: Image.asset(
                    "assets/tour/eye_down_two.png",
                    width: 80,
                    height: 120,
                  ),
                )
              : const SizedBox(),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StateTour(
                    items: pageLength,
                    indexTour: indexTour,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextSans(
                      text: title,
                      fontSize: 20,
                      textDark: textColor,
                      textLight: textColor,
                      align: TextAlign.start,
                      lines: 2,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: TextSans(
                      text: textBody,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      textDark: textColor,
                      textLight: textColor,
                      lines: 3,
                      align: TextAlign.start,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  eyeRender
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                label: "Entendido",
                              ),
                            ],
                          ),
                        )
                      : !isFinal
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                    label: "Entendido",
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ButtonIconTour(
                                    widthPercent: 0.4,
                                    onPressed: onClosePressed,
                                    label: "Finalizar",
                                  ),
                                ],
                              ),
                            ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/tour_modal/body_tour.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/tour_modal/button_icon_tour.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TourEight extends StatelessWidget {
  const TourEight({
    super.key,
    required this.onPressed,
    required this.pageLength,
    required this.closedTour,
  });
  final VoidCallback? closedTour;
  final VoidCallback? onPressed;
  final int pageLength;
  @override
  Widget build(BuildContext context) {
    const int textColor = 0xffFFFFFF;
    const int imageContainerColor = 0xffFFFFFF;
    const String title = "Detalle de tu inversión en drafts ";
    const String textBody =
        "Puedes ver a detalle la inversión que no llegaste a finalizar el proceso de inversión";

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BodyTour(
            isFinal: true,
            indexTour: 7,
            title: title,
            textColor: textColor,
            textBody: textBody,
            onPressed: onPressed,
            onClosePressed: closedTour,
            pageLength: pageLength,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: const BoxDecoration(
              color: Color(imageContainerColor),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Image.asset(
              "assets/tour/imagen_tour8.png",
              width: MediaQuery.of(context).size.width * 0.9,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}

class TourSeven extends StatelessWidget {
  const TourSeven({
    super.key,
    required this.onPressed,
    required this.pageLength,
    required this.closedTour,
  });
  final VoidCallback? closedTour;
  final VoidCallback? onPressed;
  final int pageLength;
  @override
  Widget build(BuildContext context) {
    const int textColor = 0xffFFFFFF;
    const int imageContainerColor = 0xffFFFFFF;
    const String title = "Visualiza tus inversiones en drafts";
    const String textBody =
        "Puedes ver en el home cuales son tus inversiones que dejaste incompletas";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BodyTour(
          isFinal: false,
          indexTour: 6,
          title: title,
          textColor: textColor,
          textBody: textBody,
          onPressed: onPressed,
          onClosePressed: closedTour,
          pageLength: pageLength,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Color(imageContainerColor),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Image.asset(
            "assets/tour/imagen_tour7.png",
          ),
        ),
      ],
    );
  }
}

class TourSix extends StatelessWidget {
  const TourSix({
    super.key,
    required this.onPressed,
    required this.pageLength,
    required this.closedTour,
  });
  final VoidCallback? closedTour;
  final VoidCallback? onPressed;
  final int pageLength;
  @override
  Widget build(BuildContext context) {
    const int textColor = 0xffFFFFFF;
    const int imageContainerColor = 0xffFFFFFF;
    const String title = "¡Simula tus próximas inversiones!";
    const String textBody = "Simula tus inversiones en soles y dólares";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BodyTour(
          isFinal: false,
          indexTour: 5,
          title: title,
          textColor: textColor,
          textBody: textBody,
          onPressed: onPressed,
          onClosePressed: closedTour,
          pageLength: pageLength,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.45,
          decoration: const BoxDecoration(
            color: Color(imageContainerColor),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Image.asset(
            "assets/tour/imagen_tour6.png",
          ),
        ),
      ],
    );
  }
}

class TourFive extends StatelessWidget {
  const TourFive({
    super.key,
    required this.onPressed,
    required this.pageLength,
    required this.closedTour,
  });
  final VoidCallback? closedTour;
  final VoidCallback? onPressed;
  final int pageLength;
  @override
  Widget build(BuildContext context) {
    const int textColor = 0xffFFFFFF;
    const int imageContainerColor = 0xffFFFFFF;
    const String title = "Información mas detallada de tus inversiones";
    const String textBody =
        "Visualiza todos los detalles de cada una de tus inversiones";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BodyTour(
          eyeRender: true,
          indexTour: 4,
          title: title,
          textColor: textColor,
          textBody: textBody,
          onPressed: onPressed,
          onClosePressed: closedTour,
          pageLength: pageLength,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.45,
          decoration: const BoxDecoration(
            color: Color(imageContainerColor),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Image.asset(
            "assets/tour/imagen_tour5.png",
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ],
    );
  }
}

class TourFour extends StatelessWidget {
  const TourFour({
    super.key,
    required this.onPressed,
    required this.pageLength,
    required this.closedTour,
  });
  final VoidCallback? closedTour;
  final VoidCallback? onPressed;
  final int pageLength;
  @override
  Widget build(BuildContext context) {
    const int textColor = 0xffFFFFFF;
    const int imageContainerColor = 0xffFFFFFF;
    const String title = "¡Entérate de tus próximos pagos!";
    const String textBody =
        "Visualiza el historial de tus pagos de tus inversiones.";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BodyTour(
          pageLength: pageLength,
          eyeRender: true,
          indexTour: 3,
          title: title,
          textColor: textColor,
          textBody: textBody,
          onPressed: onPressed,
          onClosePressed: closedTour,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: const BoxDecoration(
            color: Color(imageContainerColor),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Image.asset(
            "assets/tour/imagen_tour4.png",
            width: MediaQuery.of(context).size.width * 0.9,
          ),
        ),
      ],
    );
  }
}

class TourThree extends StatelessWidget {
  const TourThree({
    super.key,
    required this.onPressed,
    required this.pageLength,
    required this.closedTour,
  });
  final VoidCallback? closedTour;
  final VoidCallback? onPressed;
  final int pageLength;
  @override
  Widget build(BuildContext context) {
    const int textColor = 0xffFFFFFF;
    const int imageContainerColor = 0xffFFFFFF;
    const String title =
        "¡En Mis inversiones puedes ver historial de sus inversiones !";
    const String textBody = "Conoce el estado de tus inversiones a tiempo real";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BodyTour(
          pageLength: pageLength,
          eyeRender: true,
          indexTour: 2,
          title: title,
          textColor: textColor,
          textBody: textBody,
          onPressed: onPressed,
          onClosePressed: closedTour,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: const BoxDecoration(
            color: Color(imageContainerColor),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Image.asset(
            "assets/tour/imagen_tour3.png",
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.3,
          ),
        ),
        const SizedBox(height: 10),
        Image.asset(
          "assets/tour/investment_button.png",
          width: 120,
          height: MediaQuery.of(context).size.height * 0.1,
        ),
      ],
    );
  }
}

class TourTwo extends StatelessWidget {
  const TourTwo({
    super.key,
    required this.onPressed,
    required this.pageLength,
    required this.closedTour,
  });
  final VoidCallback? closedTour;
  final VoidCallback? onPressed;
  final int pageLength;
  @override
  Widget build(BuildContext context) {
    const int textColor = 0xffFFFFFF;
    const int imageContainerColor = 0xffDEF7FF;
    const String title = "¡Visualiza todos los fondos de inversiones!";
    const String textBody =
        "Conoce los fondos de inversión que tenemos para ti";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BodyTour(
          pageLength: pageLength,
          eyeRender: true,
          indexTour: 1,
          title: title,
          textColor: textColor,
          textBody: textBody,
          onPressed: onPressed,
          onClosePressed: closedTour,
        ),
        Container(
          margin: const EdgeInsets.only(left: 20),
          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Color(imageContainerColor),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          child: Image.asset(
            "assets/tour/imagen_tour2.png",
            width: MediaQuery.of(context).size.width * 0.9,
          ),
        ),
      ],
    );
  }
}

class TourOne extends StatelessWidget {
  const TourOne({
    super.key,
    required this.onPressed,
    required this.pageLength,
    required this.closedTour,
  });
  final VoidCallback? onPressed;
  final VoidCallback? closedTour;
  final int pageLength;
  @override
  Widget build(BuildContext context) {
    const int textColor = 0xffFFFFFF;
    const int imageContainerColor = 0xffFFFFFF;
    const String title =
        "¡Ahora puedes cambiar de fondo de inversión en un click! ";
    const String textBody =
        "Es muy útil para visualizar el gráfico del crecimiento de tu inversión.";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/tour/eye_down_one.png",
          width: 106,
          height: 70,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.35,
          decoration: const BoxDecoration(
            color: Color(imageContainerColor),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Image.asset(
            "assets/tour/imagen_tour1.png",
            width: MediaQuery.of(context).size.width * 0.9,
            fit: BoxFit.fill,
          ),
        ),
        BodyTour(
          pageLength: pageLength,
          eyeRender: false,
          indexTour: 0,
          title: title,
          textColor: textColor,
          textBody: textBody,
          onPressed: onPressed,
          onClosePressed: closedTour,
        ),
      ],
    );
  }
}

class TourInit extends ConsumerWidget {
  const TourInit({
    super.key,
    required this.onPressed,
    required this.closed,
  });
  final VoidCallback? onPressed;
  final VoidCallback? closed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool? seeLaterTour = ref.watch(seeLaterProvider);
    const int textColor = 0xffFFFFFF;
    const int textLinkColor = 0xffA2E6FA;

    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextPoppins(
              text: "Nos renovamos para ti .....",
              fontSize: 24,
              fontWeight: FontWeight.w500,
              textDark: textColor,
              textLight: textColor,
              align: TextAlign.start,
            ),
            const SizedBox(
              height: 10,
            ),
            const TextPoppins(
              text: "Conoce cuales son las nuevas funcionalidades ",
              fontSize: 15,
              textDark: textColor,
              textLight: textColor,
              lines: 2,
            ),
            Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    Center(
                      child: ButtonIconTour(
                        widthPercent: 0.4,
                        onPressed: onPressed,
                        label: "Comenzar",
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (seeLaterTour != true)
                      Center(
                        child: GestureDetector(
                          onTap: closed,
                          child: const Text(
                            'Ver en otro momento',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                              decorationColor: Color(textLinkColor),
                              decorationThickness: 1.0,
                              height: 2,
                              color: Color(textLinkColor),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                Positioned(
                  child: Image.asset(
                    "assets/tour/line_image.png",
                    width: 90,
                    height: 100,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

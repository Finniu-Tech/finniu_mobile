import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/tour_modal/body_tour.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/tour_modal/button_icon_tour.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/tour_modal/state_tour.dart';
import 'package:flutter/material.dart';

void shotTourV2(BuildContext context) {
  const int background = 0xff08273F;
  showDialog(
    barrierColor: const Color(background).withOpacity(0.9),
    context: context,
    builder: (context) => const TourContainer(),
  );
}

class TourContainer extends StatefulWidget {
  const TourContainer({
    super.key,
  });

  @override
  State<TourContainer> createState() => _TourContainerState();
}

class _TourContainerState extends State<TourContainer> {
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: controller,
      children: [
        TourInit(
          onPressed: () => controller.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOutCubic,
          ),
          closed: () => Navigator.pop(context),
        ),
        TourOne(
          onPressed: () => controller.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOutCubic,
          ),
        ),
        TourTwo(
          onPressed: () => controller.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOutCubic,
          ),
        ),
        TourThree(
          onPressed: () => controller.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOutCubic,
          ),
        ),
        TourFour(
          onPressed: () => controller.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOutCubic,
          ),
        ),
        TourFive(
          onPressed: () => controller.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOutCubic,
          ),
        ),
        TourSix(
          onPressed: () => controller.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOutCubic,
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
  });
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    const int textColor = 0xffFFFFFF;
    const int imageContainerColor = 0xffFFFFFF;
    const String title =
        "¡Ahora puedes cambiar de fondo de inversión en un click! ";
    const String textBody =
        "Es muy útil para visualizar el gráfico del crecimiento de tu inversión.";

    void closedTour1(BuildContext context) {
      Navigator.pop(context);
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: const BoxDecoration(
              color: Color(imageContainerColor),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Image.asset(
              "assets/tour/imagen_tour1.png",
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.4,
            ),
          ),
          BodyTour(
            indexTour: 5,
            title: title,
            textColor: textColor,
            textBody: textBody,
            onPressed: onPressed,
            onClosePressed: () => closedTour1(context),
          ),
        ],
      ),
    );
  }
}

class TourFive extends StatelessWidget {
  const TourFive({
    super.key,
    required this.onPressed,
  });

  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    const int textColor = 0xffFFFFFF;
    const int imageContainerColor = 0xffFFFFFF;
    const String title =
        "¡Ahora puedes cambiar de fondo de inversión en un click! ";
    const String textBody =
        "Es muy útil para visualizar el gráfico del crecimiento de tu inversión.";

    void closedTour1(BuildContext context) {
      Navigator.pop(context);
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: const BoxDecoration(
              color: Color(imageContainerColor),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Image.asset(
              "assets/tour/imagen_tour1.png",
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.4,
            ),
          ),
          BodyTour(
            indexTour: 4,
            title: title,
            textColor: textColor,
            textBody: textBody,
            onPressed: onPressed,
            onClosePressed: () => closedTour1(context),
          ),
        ],
      ),
    );
  }
}

class TourFour extends StatelessWidget {
  const TourFour({
    super.key,
    required this.onPressed,
  });

  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    const int textColor = 0xffFFFFFF;
    const int imageContainerColor = 0xffFFFFFF;
    const String title =
        "¡Ahora puedes cambiar de fondo de inversión en un click! ";
    const String textBody =
        "Es muy útil para visualizar el gráfico del crecimiento de tu inversión.";

    void closedTour1(BuildContext context) {
      Navigator.pop(context);
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: const BoxDecoration(
              color: Color(imageContainerColor),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Image.asset(
              "assets/tour/imagen_tour1.png",
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.4,
            ),
          ),
          BodyTour(
            indexTour: 3,
            title: title,
            textColor: textColor,
            textBody: textBody,
            onPressed: onPressed,
            onClosePressed: () => closedTour1(context),
          ),
        ],
      ),
    );
  }
}

class TourThree extends StatelessWidget {
  const TourThree({
    super.key,
    required this.onPressed,
  });
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    const int textColor = 0xffFFFFFF;
    const int imageContainerColor = 0xffFFFFFF;
    const String title =
        "¡Ahora puedes cambiar de fondo de inversión en un click! ";
    const String textBody =
        "Es muy útil para visualizar el gráfico del crecimiento de tu inversión.";

    void closedTour1(BuildContext context) {
      Navigator.pop(context);
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: const BoxDecoration(
              color: Color(imageContainerColor),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Image.asset(
              "assets/tour/imagen_tour1.png",
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.4,
            ),
          ),
          BodyTour(
            indexTour: 2,
            title: title,
            textColor: textColor,
            textBody: textBody,
            onPressed: onPressed,
            onClosePressed: () => closedTour1(context),
          ),
        ],
      ),
    );
  }
}

class TourTwo extends StatelessWidget {
  const TourTwo({
    super.key,
    required this.onPressed,
  });
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    const int textColor = 0xffFFFFFF;
    const int imageContainerColor = 0xffDEF7FF;
    const String title = "¡Visualiza todos los fondos de inversiones!";
    const String textBody =
        "Conoce los fondos de inversión que tenemos para tí";

    void closedTour1(BuildContext context) {
      Navigator.pop(context);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BodyTour(
          indexTour: 1,
          title: title,
          textColor: textColor,
          textBody: textBody,
          onPressed: onPressed,
          onClosePressed: () => closedTour1(context),
        ),
        const SizedBox(
          height: 40,
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
  });
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    const int textColor = 0xffFFFFFF;
    const int imageContainerColor = 0xffFFFFFF;
    const String title =
        "¡Ahora puedes cambiar de fondo de inversión en un click! ";
    const String textBody =
        "Es muy útil para visualizar el gráfico del crecimiento de tu inversión.";

    void closedTour1(BuildContext context) {
      Navigator.pop(context);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: const BoxDecoration(
            color: Color(imageContainerColor),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Image.asset(
            "assets/tour/imagen_tour1.png",
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.4,
          ),
        ),
        BodyTour(
          indexTour: 0,
          title: title,
          textColor: textColor,
          textBody: textBody,
          onPressed: onPressed,
          onClosePressed: () => closedTour1(context),
        ),
      ],
    );
  }
}

class TourInit extends StatelessWidget {
  const TourInit({
    super.key,
    required this.onPressed,
    required this.closed,
  });
  final VoidCallback? onPressed;
  final VoidCallback? closed;

  @override
  Widget build(BuildContext context) {
    const int textColor = 0xffFFFFFF;
    const int textLinkColor = 0xffA2E6FA;

    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextPoppins(
              text: "Nos renovamos para tí .....",
              fontSize: 24,
              isBold: true,
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
              isBold: false,
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
                      height: 10,
                    ),
                    Center(
                      child: TextButton(
                        onPressed: closed,
                        child: const Text(
                          'Ver en otro momento',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
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

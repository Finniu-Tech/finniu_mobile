import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v4/widget/invest_container.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PageSevenTour extends ConsumerWidget {
  const PageSevenTour({
    super.key,
    required this.nextPage,
  });
  final VoidCallback nextPage;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.read(settingsNotifierProvider).isDarkMode;
    void onPress() {
      Navigator.pop(context);
    }

    return GestureDetector(
      onTap: onPress,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 20,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            "assets/home_v4/page_seven_tour${isDarkMode ? "_dark" : "_light"}.png",
          ),
        ),
      ),
    );
  }
}

class PageSixTour extends StatelessWidget {
  const PageSixTour({
    super.key,
    required this.nextPage,
  });
  final VoidCallback nextPage;
  @override
  Widget build(BuildContext context) {
    const String title = "Manténgase al día!";
    const String subTitle = "Descubre lo último sobre inversiones y finanzas.";
    const double columnTop = 80;
    const double columnLeft = 20;
    const double itemTop = 350;
    const double itemLeft = 20;
    const int textColor = 0xff000000;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned(
            top: 210,
            left: 110,
            child: SizedBox(
              width: 65,
              height: 130,
              child: Image.asset("assets/home_v4/page_six_line.png"),
            ),
          ),
          Positioned(
            top: itemTop,
            left: itemLeft,
            child: Container(
              padding: const EdgeInsets.only(
                left: 10,
                bottom: 10,
                top: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width - 40,
              height: 210,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextPoppins(
                    text: "Últimas noticias",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    align: TextAlign.start,
                    textDark: textColor,
                  ),
                  Image.asset(
                    "assets/home_v4/notice_image.png",
                    width: MediaQuery.of(context).size.width - 40,
                    height: 140,
                  ),
                ],
              ),
            ),
          ),
          ColumnStack(
            title: title,
            subTitle: subTitle,
            onPress: nextPage,
            top: columnTop,
            left: columnLeft,
          ),
        ],
      ),
    );
  }
}

class PageFiveTour extends StatelessWidget {
  const PageFiveTour({
    super.key,
    required this.nextPage,
  });
  final VoidCallback nextPage;
  @override
  Widget build(BuildContext context) {
    const String title = "Cambia dólares al mejor tipo!";
    const String subTitle =
        "Aprovecha invertir en dólares, accede a Rextie y para comprar tus dólares ";
    const double columnTop = 150;
    const double columnLeft = 20;
    const double itemTop = 370;
    const double itemLeft = 20;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned(
            top: 280,
            left: 110,
            child: SizedBox(
              width: 61,
              height: 85,
              child: Image.asset("assets/home_v4/page_five_line.png"),
            ),
          ),
          Positioned(
            top: itemTop,
            left: itemLeft,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width - 40,
              height: 160,
              child: Image.asset(
                "assets/home_v4/change_image.png",
                width: MediaQuery.of(context).size.width - 40,
                height: 180,
              ),
            ),
          ),
          ColumnStack(
            title: title,
            subTitle: subTitle,
            onPress: nextPage,
            top: columnTop,
            left: columnLeft,
          ),
        ],
      ),
    );
  }
}

class PageFourTour extends StatelessWidget {
  const PageFourTour({
    super.key,
    required this.nextPage,
  });
  final VoidCallback nextPage;
  @override
  Widget build(BuildContext context) {
    const String title = "Accede más rápido";
    const String subTitle =
        "Con los nuevos botones Quiero invertir y Mis pagos, tomar decisiones nunca fue tan sencillo. 🚀";
    const double columnTop = 170;
    const double columnLeft = 20;
    const double itemTop = 355;
    const double itemLeft = 20;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned(
            top: itemTop,
            left: itemLeft,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              height: 70,
              child: const Row(
                children: [
                  Expanded(
                    child: InterestButton(),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: PaymentsButton(),
                  ),
                ],
              ),
            ),
          ),
          ColumnStack(
            title: title,
            subTitle: subTitle,
            onPress: nextPage,
            top: columnTop,
            left: columnLeft,
          ),
        ],
      ),
    );
  }
}

class PageThreeTour extends StatelessWidget {
  const PageThreeTour({
    super.key,
    required this.nextPage,
  });
  final VoidCallback nextPage;
  @override
  Widget build(BuildContext context) {
    const String title = "Tu inversión, en un vistazo!";
    const String subTitle =
        "Visualiza en un widget tus:\n• Inversiones activas 💸\n• Rentabilidad promedio %\n• Capital invertido 💰\n• Intereses generados 📈";
    const double columnTop = 400;
    final double columnLeft = MediaQuery.of(context).size.width / 4;
    const double itemTop = 140;
    const double itemLeft = 20;
    const bool isLoaded = false;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned(
            top: 290,
            left: 85,
            child: SizedBox(
              width: 15,
              height: 130,
              child: Image.asset("assets/home_v4/page_two_line.png"),
            ),
          ),
          Positioned(
            top: itemTop,
            left: itemLeft,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              height: 200,
              child: const Row(
                children: [
                  Expanded(
                    child: ActiveInvestmentContainer(
                      isLoaded: isLoaded,
                      countPlanesActive: "4",
                      totalBalanceRentability: "14",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: InvestCapital(
                            isLoaded: isLoaded,
                            capitalInCourse: "10.500",
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: Interest(
                            isLoaded: isLoaded,
                            totalBalanceRentabilityIncreased: "134.94",
                            totalBalanceRentabilityActually: "1.40",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ColumnStack(
            title: title,
            subTitle: subTitle,
            onPress: nextPage,
            top: columnTop,
            left: columnLeft,
          ),
        ],
      ),
    );
  }
}

class PageTwoTour extends StatelessWidget {
  const PageTwoTour({
    super.key,
    required this.nextPage,
  });
  final VoidCallback nextPage;
  @override
  Widget build(BuildContext context) {
    const String title = "Tu saldo más protegido";
    const String subTitle =
        "Activa el ojo para ocultar el saldo de tu capital invertido. ¡Más tranquilidad con un toque! ";
    const double columnTop = 200;
    const double columnLeft = 20;
    const double itemTop = 80;
    final double itemLeft = MediaQuery.of(context).size.width - 60;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned(
            top: itemTop + 25,
            left: itemLeft - 180,
            child: SizedBox(
              width: 180,
              height: 90,
              child: Image.asset("assets/home_v4/page_one_line.png"),
            ),
          ),
          Positioned(
            top: itemTop,
            left: itemLeft,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.remove_red_eye_outlined,
                color: Colors.black,
                size: 24,
              ),
            ),
          ),
          ColumnStack(
            title: title,
            subTitle: subTitle,
            onPress: nextPage,
            top: columnTop,
            left: columnLeft,
          ),
        ],
      ),
    );
  }
}

class ColumnStack extends StatelessWidget {
  const ColumnStack({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onPress,
    required this.top,
    required this.left,
  });

  final String title;
  final String subTitle;
  final double top;
  final double left;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: TextContainer(
        title: title,
        subtitle: subTitle,
        onPress: onPress,
      ),
    );
  }
}

class TextContainer extends StatelessWidget {
  const TextContainer({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onPress,
  });
  final String title;
  final String subtitle;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    const int textColor = 0xffFFFFFF;
    const int buttonColor = 0xffA2E6FA;
    const int buttonTextColor = 0xff0D3A5C;
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextPoppins(
            text: title,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            textDark: textColor,
            textLight: textColor,
          ),
          const SizedBox(height: 10),
          TextPoppins(
            text: subtitle,
            lines: 5,
            fontSize: 14,
            textDark: textColor,
            textLight: textColor,
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: onPress,
            child: Container(
              width: 185,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(buttonColor),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              alignment: Alignment.center,
              child: const TextPoppins(
                text: "Siguiente",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                textDark: buttonTextColor,
                textLight: buttonTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

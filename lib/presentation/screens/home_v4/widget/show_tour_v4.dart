import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v4/widget/page_one_tour.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void showTourV4(BuildContext context) {
  const int background = 0xff031625;
  showDialog(
    barrierColor: const Color(background).withOpacity(0.8),
    context: context,
    builder: (context) => const TourContainerV4(),
  );
}

class TourContainerV4 extends StatelessWidget {
  const TourContainerV4({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();

    void initTour() {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }

    void seeLaterTour() {
      Navigator.pop(context);
    }

    final List<Widget> pages = [
      PageOneTour(
        initTour: initTour,
        seeLaterTour: seeLaterTour,
      ),
      const PageTwoTour(),
    ];

    return ExpandablePageView.builder(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      itemCount: 2,
      itemBuilder: (context, index) => pages[index],
    );
  }
}

class PageTwoTour extends ConsumerWidget {
  const PageTwoTour({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onPress() {
      // pageState.value = getDtoTour(page.value + 1);
    }
    const String title = "Tu saldo más protegido";
    const String subTitle =
        "Activa el ojo para ocultar el saldo de tu capital invertido. ¡Más tranquilidad con un toque! ";

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.width * 0.4,
            left: 20,
            child: TextContainer(
              title: title,
              subtitle: subTitle,
              onPress: onPress,
            ),
          ),
        ],
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
            fontSize: 16,
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

import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PageOneInvestTour extends ConsumerWidget {
  const PageOneInvestTour({
    super.key,
    required this.initTour,
    required this.seeLaterTour,
  });
  final VoidCallback initTour;
  final VoidCallback seeLaterTour;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundColorDark = 0xff0E0E0E;
    const int backgroundColorLight = 0xffFFFFFF;
    const String icon = "💸📲";
    const String title = "Descubre como gestionar tus inversiones";
    const String text =
        "Te guiaremos paso a paso para que puedas conocer las nuevas funcionalidades para gestionar tus inversiones";

    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(backgroundColorDark)
            : const Color(backgroundColorLight),
      ),
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextPoppins(
              text: icon,
              fontSize: 64,
            ),
            const SizedBox(height: 15),
            const TextPoppins(
              text: title,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              align: TextAlign.start,
              lines: 2,
            ),
            const SizedBox(height: 15),
            const TextPoppins(
              text: text,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              align: TextAlign.start,
              lines: 3,
            ),
            const SizedBox(height: 100),
            ButtonInvestment(
              text: "Comencemos",
              onPressed: initTour,
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: seeLaterTour,
              child: const Center(
                child: TextPoppins(
                  text: "Ver mas tarde",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  align: TextAlign.start,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PageTwoInvestTour extends ConsumerWidget {
  const PageTwoInvestTour({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned(
            top: 50,
            left: 20,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 240,
              child: Image.asset(
                "assets/tour/invest_tour_1.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageThreeInvestTour extends ConsumerWidget {
  const PageThreeInvestTour({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned(
            top: 50,
            left: 20,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 240,
              child: Image.asset(
                "assets/tour/invest_tour_2.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageFourInvestTour extends ConsumerWidget {
  const PageFourInvestTour({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned(
            top: 100,
            left: 20,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 320,
              child: Image.asset(
                "assets/tour/invest_tour_3.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageFiveInvestTour extends ConsumerWidget {
  const PageFiveInvestTour({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned(
            top: 100,
            right: 20,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 230,
              child: Image.asset(
                "assets/tour/invest_tour_4.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageSixInvestTour extends ConsumerWidget {
  const PageSixInvestTour({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned(
            top: 190,
            right: 20,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              height: 230,
              child: Image.asset(
                "assets/tour/invest_tour_5.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageSevenInvestTour extends ConsumerWidget {
  const PageSevenInvestTour({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned(
            top: 290,
            left: 10,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              height: 280,
              child: Image.asset(
                "assets/tour/invest_tour_6.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageEightInvestTour extends ConsumerWidget {
  const PageEightInvestTour({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned(
            top: 130,
            left: 20,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 260,
              child: Image.asset(
                "assets/tour/invest_tour_7.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageNineInvestTour extends ConsumerWidget {
  const PageNineInvestTour({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned(
            top: 120,
            left: 20,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 410,
              child: Image.asset(
                "assets/tour/invest_tour_8.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageTeenInvestTour extends ConsumerWidget {
  const PageTeenInvestTour({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 20,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                "assets/tour/invest_tour_9.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageElevenInvestTour extends ConsumerWidget {
  const PageElevenInvestTour({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned(
            top: 100,
            left: 20,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Image.asset(
                "assets/tour/invest_tour_10.png",
                height: 360,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageTwelveInvestTour extends ConsumerWidget {
  const PageTwelveInvestTour({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                top: 20,
                left: 20,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Image.asset(
                    "assets/tour/invest_tour_11.png",
                    height: MediaQuery.of(context).size.height * 0.9,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

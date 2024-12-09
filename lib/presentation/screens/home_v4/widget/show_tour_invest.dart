import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:finniu/presentation/screens/home_v4/widget/page_invest_tour.dart';
import 'package:flutter/material.dart';

void showTourInvestV4(BuildContext context) {
  const int background = 0xff031625;
  showDialog(
    barrierColor: const Color(background).withOpacity(0.8),
    context: context,
    builder: (context) => const TourInvestContainerV4(),
  );
}

class TourInvestContainerV4 extends StatelessWidget {
  const TourInvestContainerV4({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();

    void initTour() {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }

    void nextPage() {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }

    void seeLaterTour() {
      Navigator.pop(context);
    }

    final List<Widget> pages = [
      PageOneInvestTour(
        initTour: initTour,
        seeLaterTour: seeLaterTour,
      ),
    ];

    return ExpandablePageView.builder(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      itemCount: pages.length,
      itemBuilder: (context, index) => pages[index],
    );
  }
}

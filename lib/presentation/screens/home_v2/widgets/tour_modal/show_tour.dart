import 'package:finniu/presentation/screens/home_v2/widgets/tour_modal/tours_pages.dart';
import 'package:flutter/material.dart';

void showTourV2(BuildContext context) {
  const int background = 0xff08273F;
  showDialog(
    barrierColor: const Color(background).withOpacity(0.9),
    context: context,
    builder: (context) => const TourContainer(),
  );
}

class TourContainer extends StatefulWidget {
  const TourContainer({super.key});

  @override
  State<TourContainer> createState() => _TourContainerState();
}

class _TourContainerState extends State<TourContainer> {
  List<Widget> childrenList = [];
  final PageController controller = PageController(
    initialPage: 0,
  );
  int itemList = 8;

  @override
  void initState() {
    super.initState();

    childrenList = [
      TourInit(
        onPressed: () => controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
        ),
        closed: () => Navigator.pop(context),
      ),
      TourOne(
        pageLength: itemList,
        onPressed: () => controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
        ),
      ),
      TourTwo(
        pageLength: itemList,
        onPressed: () => controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
        ),
      ),
      TourThree(
        pageLength: itemList,
        onPressed: () => controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
        ),
      ),
      TourFour(
        pageLength: itemList,
        onPressed: () => controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
        ),
      ),
      TourFive(
        pageLength: itemList,
        onPressed: () => controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
        ),
      ),
      TourSix(
        pageLength: itemList,
        onPressed: () => controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
        ),
      ),
      TourSeven(
        pageLength: itemList,
        onPressed: () => controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
        ),
      ),
      TourEight(
        pageLength: itemList,
        onPressed: () => controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      allowImplicitScrolling: true,
      controller: controller,
      children: childrenList,
    );
  }
}

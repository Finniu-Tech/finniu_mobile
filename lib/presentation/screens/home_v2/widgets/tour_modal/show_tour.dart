import 'package:finniu/presentation/screens/home_v2/widgets/tour_modal/helpers_tour.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/tour_modal/tours_pages.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void showTourV2(BuildContext context) {
  const int background = 0xff08273F;
  showDialog(
    barrierColor: const Color(background).withOpacity(0.9),
    context: context,
    builder: (context) => const TourContainer(),
  );
}

class TourContainer extends ConsumerStatefulWidget {
  const TourContainer({super.key});

  @override
  ConsumerState<TourContainer> createState() => _TourContainerState();
}

class _TourContainerState extends ConsumerState<TourContainer> {
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
        closed: () => seeAnotherTime(context, ref),
      ),
      TourOne(
        closedTour: () => seeAnotherTime(context, ref),
        pageLength: itemList,
        onPressed: () => controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
        ),
      ),
      TourTwo(
        closedTour: () => seeAnotherTime(context, ref),
        pageLength: itemList,
        onPressed: () => controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
        ),
      ),
      TourThree(
        closedTour: () => seeAnotherTime(context, ref),
        pageLength: itemList,
        onPressed: () => controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
        ),
      ),
      TourFour(
        closedTour: () => seeAnotherTime(context, ref),
        pageLength: itemList,
        onPressed: () => controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
        ),
      ),
      TourFive(
        closedTour: () => seeAnotherTime(context, ref),
        pageLength: itemList,
        onPressed: () => controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
        ),
      ),
      TourSix(
        closedTour: () => seeAnotherTime(context, ref),
        pageLength: itemList,
        onPressed: () => controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
        ),
      ),
      TourSeven(
        closedTour: () => seeAnotherTime(context, ref),
        pageLength: itemList,
        onPressed: () => controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
        ),
      ),
      TourEight(
        closedTour: () => seeAnotherTime(context, ref, idFinal: true),
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

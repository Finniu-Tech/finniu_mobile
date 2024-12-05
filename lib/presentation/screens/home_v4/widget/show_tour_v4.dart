import 'package:flutter/material.dart';

void showTourV4(BuildContext context) {
  const int background = 0xff08273F;
  showDialog(
    barrierColor: const Color(background).withOpacity(0.9),
    context: context,
    builder: (context) => const TourContainerV4(),
  );
}

class TourContainerV4 extends StatelessWidget {
  const TourContainerV4({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

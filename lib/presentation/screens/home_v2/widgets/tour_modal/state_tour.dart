import 'package:flutter/material.dart';

class StateTour extends StatelessWidget {
  const StateTour({
    super.key,
    required this.indexTour,
    required this.items,
  });
  final int indexTour;
  final int items;

  @override
  Widget build(BuildContext context) {
    const int selectColor = 0xffA2E6FA;
    const int unselectColor = 0xff0E4D7D;

    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(items, (index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: indexTour == index
                    ? const Color(selectColor)
                    : const Color(unselectColor),
              ),
              width: MediaQuery.of(context).size.width * 0.7 / items,
              height: 9,
            );
          }),
        ),
      ),
    );
  }
}

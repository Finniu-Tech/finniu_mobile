import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';

class ShowTourContainer extends StatefulWidget {
  const ShowTourContainer({
    super.key,
  });

  @override
  State<ShowTourContainer> createState() => _ShowTourContainerState();
}

class _ShowTourContainerState extends State<ShowTourContainer> {
  final int backgroundColor = 0xff08273F;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      width: 70,
      height: 56,
      decoration: BoxDecoration(
        color: Color(backgroundColor),
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: const TextPoppins(
        text: "📲",
        fontSize: 30,
        isBold: true,
        align: TextAlign.center,
      ),
    );
  }
}

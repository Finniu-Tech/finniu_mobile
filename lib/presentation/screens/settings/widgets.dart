import 'package:finniu/constants/colors.dart';
import 'package:flutter/material.dart';

class IconContainer extends StatelessWidget {
  final String image;

  const IconContainer({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46.48,
      height: 34.87,
      decoration: BoxDecoration(
        color: Color(primaryDark),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Image.asset(
        image,
        width: 30,
        height: 30,
      ),
    );
  }
}

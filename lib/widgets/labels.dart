import 'package:flutter/material.dart';

class LabelWithRoundedImage extends StatelessWidget {
  const LabelWithRoundedImage({
    super.key,
    required this.containerColor,
    required this.textColor,
    required this.iconColor,
    required this.urlIcon,
    required this.labelText,
  });

  final int containerColor;
  final int textColor;
  final int iconColor;
  final String urlIcon;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          width: 150,
          height: 30,
          padding: const EdgeInsets.only(right: 10),
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(containerColor),
          ),
          child: Text(
            labelText,
            textAlign: TextAlign.end,
            style: TextStyle(
              color: Color(textColor),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Color(iconColor),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Image.network(urlIcon),
            // child: Image.asset(
            //   urlIcon,
            // ),
          ),
        ),
      ],
    );
  }
}

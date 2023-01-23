import 'package:flutter/material.dart';
import 'package:finniu/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final int color_background;
  final int color_text;
  final String text;

  const CustomButton(
      {super.key,
      required this.text,
      this.color_background = primary_dark,
      this.color_text = whitetext});

  //  const CustomButton({super.key, required this._text});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 230,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Color(color_background),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: Color(color_text),
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:finniu/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final int color_background;
  final int color_text;
  final String text;
  final String pushName;

  const CustomButton({
    super.key,
    required this.text,
    this.color_background = primary_dark,
    this.color_text = white_text,
    this.pushName = "",
  });

  //  const CustomButton({super.key, required this._text});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(pushName);
        Navigator.pushNamed(context, pushName);
      },
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

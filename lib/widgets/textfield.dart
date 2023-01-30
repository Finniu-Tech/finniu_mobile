import 'package:flutter/material.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/buttons.dart';

import 'fonts.dart';

class ButtonDecoration extends StatefulWidget {
  final String textLabel;
  final String textHint;

  const ButtonDecoration(
      {super.key, required this.textLabel, required this.textHint});

  @override
  State<ButtonDecoration> createState() => _ButtonDecorationState();
}

class _ButtonDecorationState extends State<ButtonDecoration> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: widget.textHint,
        // hintStyle: fontPoppins(
        //     fontSize: 11, colorHex: gray_text, fontWeight: FontWeight.w600),
        labelText: widget.textLabel,
        // labelStyle: fontInter(
        //     fontSize: 12, colorHex: primary_dark, fontWeight: FontWeight.w600),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/buttons.dart';

import 'fonts.dart';

class ButtomDecoration extends StatefulWidget {
  final String textLabel;
  final String textHint;

  const ButtomDecoration({super.key, required this.textLabel, required this.textHint});

  @override
  State<ButtomDecoration> createState() => _ButtomDecorationState();
}

class _ButtomDecorationState extends State<ButtomDecoration> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: widget.textHint,
        hintStyle: fontPoppins(fontSize: 11, colorHex: gray_text, fontWeight: FontWeight.w600),
        labelText: widget.textLabel,
        labelStyle: fontInter(fontSize: 12, colorHex: primary_dark, fontWeight: FontWeight.w600),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: const Color(primary_dark),
            )),
      ),
    );
  }
}

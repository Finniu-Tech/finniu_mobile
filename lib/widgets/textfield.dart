import 'package:flutter/material.dart';

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
      // keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: widget.textHint,
        // isDense: true,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0,
            10.0), // con esto evitamos un bug cuando el texto es muy largo
        // contentPadding: EdgeInsets.all(0),
        // hintStyle: fontPoppins(
        //     fontSize: 11, colorHex: gray_text, fontWeight: FontWeight.w600),
        labelText: widget.textLabel,
        // labelStyle: fontInter(
        //     fontSize: 12, colorHex: primary_dark, fontWeight: FontWeight.w600),
      ),
    );
  }
}

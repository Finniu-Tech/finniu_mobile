import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/labels.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final int containerColor;
  final int textColor;
  final int iconColor;
  final String urlIcon;
  final String labelText;

  const HeaderWidget({
    super.key,
    required this.containerColor,
    required this.textColor,
    required this.iconColor,
    required this.urlIcon,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        LabelWithRoundedImage(
          containerColor: containerColor,
          textColor: textColor,
          iconColor: iconColor,
          urlIcon: urlIcon,
          labelText: labelText,
        ),
        Spacer(),
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: 5,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(primaryDark),
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:finniu/constants/colors.dart';

class CustomButton extends StatefulWidget {
  final int? colorBackground;
  final int? colorText;
  final String text;
  final String pushName;
  final double width;
  final double height;

  const CustomButton({
    super.key,
    required this.text,
    this.colorBackground,
    this.colorText,
    this.pushName = "",
    this.width = 224,
    this.height = 50,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    Color colorBackground;
    if (widget.colorBackground == null) {
      colorBackground = Theme.of(context).textButtonTheme.style!.backgroundColor!.resolve({MaterialState.pressed})!;
    } else {
      colorBackground = Color(widget.colorBackground!);
    }

    Color textColor;
    if (widget.colorText == null) {
      textColor = Theme.of(context).textButtonTheme.style!.foregroundColor!.resolve({MaterialState.pressed})!;
    } else {
      textColor = Color(widget.colorText!);
    }

    return TextButton(
      style: TextButton.styleFrom(
        fixedSize: Size(widget.width, widget.height),
        backgroundColor: colorBackground,
        foregroundColor: textColor,
      ),
      onPressed: () {
        if (widget.pushName != "") {
          Navigator.pushNamed(context, widget.pushName);
        }
      },
      child: Text(widget.text),
    );
  }
}

class CustomReturnButton extends StatefulWidget {
  final int colorBoxdecoration;
  final int colorIcon;
  const CustomReturnButton({
    super.key,
    this.colorBoxdecoration = primaryDark,
    this.colorIcon = primaryLight,
  });
  @override
  State<CustomReturnButton> createState() => _CustomReturnButtonState();
}

class _CustomReturnButtonState extends State<CustomReturnButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(widget.colorBoxdecoration),
        ),
        child: Center(
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 20,
            color: Color(widget.colorIcon),
          ),
        ),
      ),
    );
  }
}

class CustomButtonRoundedDark extends StatefulWidget {
  @override
  final String pushName;

  const CustomButtonRoundedDark({
    super.key,
    this.pushName = "",
  });
  State<CustomButtonRoundedDark> createState() => _CustomButtonRoundedDarkState();
}

class _CustomButtonRoundedDarkState extends State<CustomButtonRoundedDark> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, widget.pushName);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        // padding: EdgeInsets.all(6),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: const Color(primaryDark),
        ),
        child: const Center(
          child: Icon(
            size: 20,
            color: Color(primaryLight),
            Icons.arrow_forward,
          ),
        ),
      ),
    );
  }
}

class CusttomButtonRoundedLight extends StatefulWidget {
  @override
  final String pushName;
  final bool isReturn;

  const CusttomButtonRoundedLight({
    super.key,
    this.pushName = "",
    this.isReturn = false,
  });
  _CusttomButtonRoundedLightState createState() => _CusttomButtonRoundedLightState();
}

class _CusttomButtonRoundedLightState extends State<CusttomButtonRoundedLight> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isReturn == true) {
          Navigator.of(context).pop();
        } else {
          Navigator.pushNamed(context, widget.pushName);
        }
      },
      child: Container(
        margin: EdgeInsets.all(10),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: const Color(primaryLight),
        ),
        child: const Center(
          child: Icon(size: 20, color: Color(primaryDark), Icons.arrow_back_outlined),
        ),
      ),
    );
  }
}

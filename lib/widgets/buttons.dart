import 'package:flutter/material.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/buttons.dart';

class CustomButton extends StatefulWidget {
  final int colorBackground;
  final int colorText;
  final String text;
  final String pushName;
  final double width;
  final double height;

  const CustomButton({
    super.key,
    required this.text,
    this.colorBackground = primary_dark,
    this.colorText = white_text,
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
    return GestureDetector(
      onTap: () {
        print(widget.pushName);
        Navigator.pushNamed(context, widget.pushName);
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Color(widget.colorBackground),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(color: Color(widget.colorText), fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class CustomReturnButton extends StatefulWidget {
  final int colorBoxdecoration;
  final int colorIcon;
  const CustomReturnButton({super.key, this.colorBoxdecoration = primary_dark, this.colorIcon = primary_light});
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
        child: const Center(
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class CusttomButtomRoundedDart extends StatefulWidget {
  @override
  final String pushName;

  const CusttomButtomRoundedDart({
    super.key,
    this.pushName = "",
  });
  State<CusttomButtomRoundedDart> createState() => _CusttomButtomRoundedDartState();
}

class _CusttomButtomRoundedDartState extends State<CusttomButtomRoundedDart> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, widget.pushName);
      },
      child: Container(
        margin: EdgeInsets.all(10),
        // padding: EdgeInsets.all(6),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Color(primary_dark),
        ),
        child: Center(child: Icon(size: 20, color: Color(primary_light), Icons.arrow_forward)),
      ),
    );
  }
}

class CusttomButtomRoundedLight extends StatefulWidget {
  @override
  final String pushName;

  const CusttomButtomRoundedLight({
    super.key,
    this.pushName = "",
  });
  _CusttomButtomRoundedLightState createState() => _CusttomButtomRoundedLightState();
}

class _CusttomButtomRoundedLightState extends State<CusttomButtomRoundedLight> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, widget.pushName);
      },
      child: Container(
        margin: EdgeInsets.all(10),
        // padding: EdgeInsets.all(6),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Color(primary_light),
        ),
        child: Center(child: Icon(size: 20, color: Color(primary_dark), Icons.arrow_back_outlined)),
      ),
    );
  }
}

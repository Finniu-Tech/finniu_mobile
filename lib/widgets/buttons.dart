import 'package:flutter/material.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/buttons.dart';

class CustomButton extends StatelessWidget {
  final int colorBackground;
  final int colorText;
  final String text;
  final String pushName;

  const CustomButton({
    super.key,
    required this.text,
    this.colorBackground = primary_dark,
    this.colorText = white_text,
    this.pushName = "",
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(pushName);
        Navigator.pushNamed(context, pushName);
      },
      child: Container(
        width: 224,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Color(colorBackground),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: Color(colorText),
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class CustomReturnButton extends StatefulWidget {
  final int colorBoxdecoration;
  final int colorIcon;
  const CustomReturnButton(
      {super.key,
      this.colorBoxdecoration = primary_dark,
      this.colorIcon = primary_light});
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

class CustomButtonRoundedDart extends StatefulWidget {
  @override
  final String pushName;

  const CustomButtonRoundedDart({
    super.key,
    this.pushName = "",
  });
  State<CustomButtonRoundedDart> createState() =>
      _CustomButtonRoundedDartState();
}

class _CustomButtonRoundedDartState extends State<CustomButtonRoundedDart> {
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
        child: Center(
            child: Icon(
                size: 20, color: Color(primary_light), Icons.arrow_forward)),
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
  _CusttomButtomRoundedLightState createState() =>
      _CusttomButtomRoundedLightState();
}

class _CusttomButtomRoundedLightState extends State<CustomButtonRoundedDart> {
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
        child: Center(
            child: Icon(
                size: 20,
                color: Color(primary_dark),
                Icons.arrow_back_outlined)),
      ),
    );
  }
}

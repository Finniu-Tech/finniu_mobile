import 'package:finniu/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:provider/provider.dart';

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
    // final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    print('zzzz');
    print(widget.text);
    print(widget.colorBackground);
    Color colorBackground;
    if (widget.colorBackground == null) {
      colorBackground = Theme.of(context).textButtonTheme.style!.backgroundColor!.resolve({MaterialState.pressed})!;
      print(colorBackground);
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
      style: TextButton.styleFrom(fixedSize: Size(widget.width, widget.height), backgroundColor: colorBackground, foregroundColor: textColor
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(25),
          // ),
          ),
      onPressed: () {
        Navigator.pushNamed(context, widget.pushName);
      },
      child: Text(widget.text),
    );
    // return GestureDetector(
    //   onTap: () {
    //     print(widget.pushName);
    //     Navigator.pushNamed(context, widget.pushName);
    //   },
    //   child: Container(
    //     width: widget.width,
    //     height: widget.height,
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(50),
    //       color: Color(widget.colorBackground),
    //     ),
    //     child: Center(
    //       child: Text(
    //         widget.text,
    //         style: TextStyle(
    //             color: Color(widget.colorText),
    //             fontSize: 16,
    //             fontWeight: FontWeight.bold),
    //       ),
    //     ),
    //   ),
    // );
  }
}

class CustomReturnButton extends StatefulWidget {
  final int colorBoxdecoration;
  final int colorIcon;
  const CustomReturnButton({super.key, this.colorBoxdecoration = primaryDark, this.colorIcon = primaryLight});
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
  State<CustomButtonRoundedDart> createState() => _CustomButtonRoundedDartState();
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
          color: Color(primaryDark),
        ),
        child: Center(child: Icon(size: 20, color: Color(primaryLight), Icons.arrow_forward)),
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
          color: Color(primaryLight),
        ),
        child: Center(child: Icon(size: 20, color: Color(primaryDark), Icons.arrow_back_outlined)),
      ),
    );
  }
}

import 'package:finniu/providers/settings_provider.dart';
import 'package:finniu/screens/investment_question/result.dart';
import 'package:flutter/material.dart';
import 'package:finniu/constants/colors.dart';
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
    this.colorBoxdecoration = primaryLight,
    this.colorIcon = primaryDark,
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

class CustomButtonRoundedDark extends StatelessWidget {
  @override
  final String pushName;

  const CustomButtonRoundedDark({
    super.key,
    this.pushName = "",
  });
  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<SettingsProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        if (pushName != "") {
          Navigator.pushNamed(context, pushName);
        }
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        // padding: EdgeInsets.all(6),
        width: 28.67,
        height: 28.67,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: currentTheme.isDarkMode
              ? Colors.transparent
              : const Color(
                  primaryLight,
                ),
          border: Border.all(
            color: const Color(primaryDark),
          ),
        ),
        child: const Center(
          child: Icon(
            size: 20,
            color: Color(primaryDark),
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
        margin: const EdgeInsets.all(10),
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

class BottomNavigationBarHome extends StatelessWidget {
  const BottomNavigationBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<SettingsProvider>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
          // adjust to your liking
        ),
        color: currentTheme.isDarkMode
            ? const Color(primaryLight)
            : const Color(
                primaryDark,
              ),
      ),
      child: BottomNavigationBar(
        elevation: 0.0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        selectedItemColor: currentTheme.isDarkMode
            ? const Color(primaryDark)
            : const Color(
                primaryLight,
              ),
        unselectedItemColor: currentTheme.isDarkMode
            ? const Color(primaryDark)
            : const Color(
                primaryLight,
              ).withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        onTap: (value) {
          // Respond to item press.
        },
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: InkWell(
              child: Icon(Icons.home_filled),
              onTap: () {
                Navigator.pushNamed(context, '/home_home');
              },
            ),
          ),
          BottomNavigationBarItem(
              label: 'Inversiones',
              icon: InkWell(
                child: Icon(Icons.monetization_on_outlined),
                onTap: () {
                  Navigator.pushNamed(context, '/my_investment');
                },
              )),
          const BottomNavigationBarItem(
            label: 'Simulador',
            icon: Icon(Icons.insert_chart_outlined_rounded),
          ),
          const BottomNavigationBarItem(
            label: 'Finanzas',
            icon: Icon(Icons.wallet),
          ),
        ],
      ),
    );
  }
}

class ButtonQuestions extends StatelessWidget {
  String text;
  PageController controller = PageController();
  ButtonQuestions({super.key, required this.text, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      height: 53,
      child: TextButton(
        onPressed: () {
          if (controller.page == 2.0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ResultInvestment()),
            );
          } else {}
          controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
        },
        style: TextButton.styleFrom(
          backgroundColor: const Color(primaryLightAlternative),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Color(primaryDark),
          ),
        ),
      ),
    );
  }
}

import 'package:finniu/screens/investment_question/result.dart';
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

class CustomButtonRoundedDark extends StatelessWidget {
  @override
  final String pushName;

  const CustomButtonRoundedDark({
    super.key,
    this.pushName = "",
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (pushName != "") {
          Navigator.pushNamed(context, pushName);
        }
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

class BottomNavigationBarHome extends StatelessWidget {
  const BottomNavigationBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0), // adjust to your liking
          topRight: Radius.circular(20.0),
          // adjust to your liking
        ),
        color: Color(primaryDark), // put the color here
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        selectedItemColor: Color(primaryLight),
        unselectedItemColor: Color(primaryLight).withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        onTap: (value) {
          // Respond to item press.
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(
              Icons.home_filled,
              // color: Color(primaryLight),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Inversiones',
            icon: Icon(Icons.monetization_on_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Simulador',
            icon: Icon(Icons.insert_chart_outlined_rounded),
          ),
          BottomNavigationBarItem(
            label: 'Favorites',
            icon: Icon(Icons.wallet),
          ),
        ],
      ),
    );
    //   return Container(
    //     margin: EdgeInsets.only(bottom: 5),
    //     width: 360,
    //     height: 80,
    //     decoration: BoxDecoration(
    //       color: Color(primaryDark),
    //       borderRadius: BorderRadius.circular(10),
    //     ),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Column(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: const [
    //             Icon(Icons.home, color: Colors.white),
    //             Text("Home", style: TextStyle(color: Colors.white)),
    //           ],
    //         ),
    //         Column(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: const [
    //             Icon(Icons.attach_money, color: Colors.white),
    //             Text("Inversiones", style: TextStyle(color: Colors.white)),
    //           ],
    //         ),
    //         Column(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: const [
    //             Icon(Icons.poll, color: Colors.white),
    //             Text("Simulador", style: TextStyle(color: Colors.white)),
    //           ],
    //         ),
    //         Column(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: const [
    //             Icon(Icons.account_balance, color: Colors.white),
    //             Text("Finanzas", style: TextStyle(color: Colors.white)),
    //           ],
    //         ),
    //       ],
    //     ),
    //   );
    //   ;
    //   ;
    // }
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
          // widget.currentStep = widget.currentStep + 1;
          print("page");
          print(controller.page);
          if (controller.page == 2.0) {
            // Navigator.pushReplacementNamed(context, "investment_result");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ResultInvestment()),
            );
          } else {}
          controller.nextPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
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

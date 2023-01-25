import 'package:finniu/widgets/fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/colors.dart';
import '../../widgets/buttons.dart';

class WelcomeFinniu extends StatefulWidget {
  const WelcomeFinniu({super.key});

  @override
  State<WelcomeFinniu> createState() => _WelcomeFinniuState();
}

class _WelcomeFinniuState extends State<WelcomeFinniu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(primary_dark),
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Color(primary_dark),
            leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  // padding: EdgeInsets.all(6),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(primary_light),
                  ),
                  child: Center(
                      child: Icon(
                    size: 20,
                    color: Color(primary_dark),
                    Icons.arrow_back_ios_new_outlined,
                  )),
                ))),
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
              colors: [
                const Color(primary_dark),
                const Color(gradient_primary_alternative)
              ],
            )),
            child: Column(children: <Widget>[
              Container(
                width: 360,
                height: 362,
                child: Image.asset('assets/welcome/welcome1.png'),
              ),
              SizedBox(height: 12),
              TextPoppinsFont(
                text: '¡Bienvenidos a Finniu!',
                colorText: primary_light,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 9),
              TextPoppinsFont(
                text:
                    'Somos un equipo con la misión de ayudar a jóvenes profesionales a invertir su dinero de forma sencilla y transparente. ',
                colorText: white_text,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              Container(
                width: 67,
                height: 75,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
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
                            size: 20,
                            color: Color(primary_light),
                            Icons.arrow_forward)),
                  )),
            ])));
  }
}

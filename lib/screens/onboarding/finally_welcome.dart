import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:flutter/material.dart';

class WelcomeFinally extends StatefulWidget {
  const WelcomeFinally({super.key});

  @override
  State<WelcomeFinally> createState() => _WelcomeFinallyState();
}

class _WelcomeFinallyState extends State<WelcomeFinally> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
              colors: [Color(gradient_secondary), Color(gradient_primary)],
            )),
            child: Column(children: <Widget>[
              SizedBox(height: 100),
              SizedBox(
                child: Image.asset('assets/welcome/welcome4.png'),
              ),
              const SizedBox(height: 6),
              const TextPoppins(
                text: 'Recibe tus pagos de manera segura y puntual',
                colorText: primaryDark,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              const TextPoppins(
                text: 'Recibe tu capital y tus intereses garantizado en la fecha establecida',
                colorText: primaryDark,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(
                width: 10,
                height: 40,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const CusttomButtomRoundedLight(pushName: '/on_boarding_middle'),
                ),
                const SizedBox(
                  width: 80,
                  height: 0,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const CustomButton(
                        text: 'Comenzar',
                        // colorBackground: primaryDark,
                        // colorText: white_text,
                        width: 116,
                        height: 40,
                        pushName: '/investment_start')),
              ])
            ])));
  }
}

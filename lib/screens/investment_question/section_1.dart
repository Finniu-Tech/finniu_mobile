import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';

class Section1 extends StatefulWidget {
  const Section1({super.key});

  @override
  State<Section1> createState() => _Section1State();
}

class _Section1State extends State<Section1> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldReturnLogo(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 180),
              SizedBox(
                child: Image.asset('assets/investment/bill.png'),
              ),
              Container(
                width: 228,
                height: 95,
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: const Text(
                  '¿Has invertido tu dinero anteriormente?',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color(primaryDark),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: _controller,
              children: [
                Container(
                  child: Column(
                    children: const [
                      CustomButton(
                        text: "18-25 años",
                        colorText: primaryDark,
                        colorBackground: primaryLightAlternative,
                        width: 320,
                        height: 53,
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      CustomButton(
                        text: '25-35 años',
                        colorText: primaryDark,
                        colorBackground: primaryLightAlternative,
                        width: 320,
                        height: 53,
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      CustomButton(
                        text: '35-45 años',
                        colorText: primaryDark,
                        colorBackground: primaryLightAlternative,
                        width: 320,
                        height: 53,
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      CustomButton(
                        text: '45-50 años',
                        colorText: primaryDark,
                        colorBackground: primaryLightAlternative,
                        width: 320,
                        height: 53,
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      CustomButton(
                        text: '55-65 años',
                        colorText: primaryDark,
                        colorBackground: primaryLightAlternative,
                        width: 320,
                        height: 53,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

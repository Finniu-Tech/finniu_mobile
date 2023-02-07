import 'package:finniu/constants/colors.dart';
import 'package:finniu/screens/login/start_screen.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:finniu/widgets/step_bar.dart';
import 'package:flutter/material.dart';

class SelectRange extends StatefulWidget {
  const SelectRange({super.key});

  @override
  State<SelectRange> createState() => _SelectRangeState();
}

class _SelectRangeState extends State<SelectRange> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldReturnLogo(
      body: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 180),
            SizedBox(
              child: Image.asset('assets/investment/star.png'),
            ),
            Container(
              width: 228,
              height: 95,
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: const Text(
                'Selecciona tu rango de edad',
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
        Container(
          height: 400,
          child: PageView(
            controller: _controller,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 320,
                    height: 53,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text("18-25 años", style: TextStyle(color: Color(primaryDark))),
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(primaryLightAlternative),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  SizedBox(
                    width: 320,
                    height: 53,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text("25-35 años", style: TextStyle(color: Color(primaryDark))),
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(primaryLightAlternative),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  SizedBox(
                    width: 320,
                    height: 53,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text("35-45 años", style: TextStyle(color: Color(primaryDark))),
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(primaryLightAlternative),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  SizedBox(
                    width: 320,
                    height: 53,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text("45-50 años", style: TextStyle(color: Color(primaryDark))),
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(primaryLightAlternative),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  SizedBox(
                    width: 320,
                    height: 53,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text("55-65 años", style: TextStyle(color: Color(primaryDark))),
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(primaryLightAlternative),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        StepBar(
          currentStep: 1,
          totalSteps: 4,
          activeColor: Color(primaryLightAlternative),
          inactiveColor: Color(primaryDark),
        ),
      ]),
    );
  }
}

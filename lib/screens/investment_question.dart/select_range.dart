import 'package:finniu/constants/colors.dart';
import 'package:finniu/screens/login/start_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    int selectedIndex;
    return CustomScaffoldReturnLogo(
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 90),
            Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 40, left: 20),
                  margin: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: Image.asset('assets/investment/star.png'),
                      ),
                      Expanded(
                        child: Text('Selecciona tu rango de edad',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Color(primaryDark),
                                fontWeight: FontWeight.w600,
                                fontSize: 24)),
                        // child: const TextPoppins(
                        //   text: 'Selecciona tu rango de edad ',
                        //   colorText: primaryDark,
                        //   fontSize: 24,
                        //   fontWeight: FontWeight.w600,
                        // ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SelectRange()),
                      );
                    },
                    child: Container(
                      width: 320,
                      height: 53,
                      decoration: BoxDecoration(
                        color: const Color(primaryLightAlternative),
                        border: Border.all(
                          color: const Color(primaryLightAlternative),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Center(
                        child: TextPoppins(
                          text: '18-25',
                          colorText: primaryDark,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 320,
              height: 53,
              child: InkWell(
                onTap: () => setState(() => selectedIndex = 1),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(primaryLightAlternative),
                    border: Border.all(
                      color: const Color(primaryLightAlternative),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Center(
                    child: TextPoppins(
                      text: '25-35',
                      colorText: primaryDark,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 320,
              height: 53,
              child: InkWell(
                onTap: () => setState(() => selectedIndex = 1),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(primaryLightAlternative),
                    border: Border.all(
                      color: const Color(primaryLightAlternative),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Center(
                    child: TextPoppins(
                      text: '35-45',
                      colorText: primaryDark,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 320,
              height: 53,
              child: InkWell(
                onTap: () => setState(() => selectedIndex = 1),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(primaryLightAlternative),
                    border: Border.all(
                      color: const Color(primaryLightAlternative),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Center(
                    child: TextPoppins(
                      text: '45-50',
                      colorText: primaryDark,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 320,
              height: 53,
              child: InkWell(
                onTap: () => setState(() => selectedIndex = 1),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(primaryLightAlternative),
                    border: Border.all(
                      color: const Color(primaryLightAlternative),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Center(
                    child: TextPoppins(
                      text: '55-65',
                      colorText: primaryDark,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            StepBar(currentStep: 0, totalSteps: 4)
          ],
        ),
      ),
    );
  }
}

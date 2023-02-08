import 'package:finniu/constants/colors.dart';
import 'package:finniu/screens/investment_question/section_1.dart';
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
  int _currentStep = 0;
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldReturnLogo(
        body: Column(children: [
      Container(
        height: 550,
        child: PageView(
          controller: _controller,
          children: const [
            Section1(),
          ],
          onPageChanged: (page) {
            setState(() {
              _currentStep = page;
            });
          },
        ),
      ),
      const StepBar(
        currentStep: 1,
        totalSteps: 4,
        activeColor: Color(primaryLightAlternative),
        inactiveColor: Color(primaryDark),
      )
    ]));
  }
}

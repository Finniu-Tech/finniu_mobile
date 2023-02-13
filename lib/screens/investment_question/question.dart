import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/screens/investment_question/section_1.dart';
import 'package:finniu/screens/investment_question/section_2.dart';
import 'package:finniu/screens/investment_question/section_3.dart';
import 'package:finniu/screens/login/start_screen.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:finniu/widgets/step_bar.dart';
import 'package:flutter/material.dart';

class SelectRange extends StatefulWidget {
  SelectRange({super.key});

  @override
  State<SelectRange> createState() => _SelectRangeState();
}

class _SelectRangeState extends State<SelectRange> {
  int _currentStep = 0;

  // void nextQuestions() {
  //   setState(() {
  //     _currentStep = (_currentStep + 1) % 4;
  //   });
  //   _controller.animateToPage(
  //     _currentStep,
  //     duration: const Duration(milliseconds: 500),
  //     curve: Curves.easeInOut,
  //   );
  // }

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldReturnLogo(
      body: Column(
        children: [
          Container(
            // height: 450,
            child: ExpandablePageView(
              controller: _controller,
              children: [
                Section1(
                  controller: _controller,
                ),
                Section2(
                  controller: _controller,
                ),
                Section3(
                  controller: _controller,
                ),
              ],
              onPageChanged: (page) {
                setState(() {
                  _currentStep = page;
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          StepBar(
            currentStep: _currentStep,
            totalSteps: 3,
            activeColor: Color(primaryLightAlternative),
            inactiveColor: Color(primaryDark),
          ),
        ],
      ),
    );
  }
}

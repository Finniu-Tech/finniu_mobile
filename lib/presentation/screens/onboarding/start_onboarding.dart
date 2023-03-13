import 'package:finniu/constants/colors.dart';
import 'package:finniu/infrastructure/models/auth.dart';
import 'package:finniu/presentation/providers/auth_provider.dart';
import 'package:finniu/presentation/providers/onboarding_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/onboarding/section_1.dart';
import 'package:finniu/presentation/screens/onboarding/section_2.dart';
import 'package:finniu/presentation/screens/onboarding/section_3.dart';
import 'package:finniu/presentation/screens/onboarding/section_4.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/step_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StartOnboarding extends ConsumerStatefulWidget {
  @override
  _StartOnboardingState createState() => _StartOnboardingState();
}

class _StartOnboardingState extends ConsumerState<StartOnboarding> {
  int _currentStep = 0;
  final PageController _controller = PageController();

  void _nextStep() {
    setState(() {
      _currentStep = (_currentStep + 1) % 4;
    });
    _controller.animateToPage(
      _currentStep,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _prevStep() {
    setState(() {
      _currentStep = (_currentStep - 1) % 4;
    });
    _controller.animateToPage(
      _currentStep,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  LinearGradient? _getGradient(int currentStep) {
    switch (currentStep) {
      case 0:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          colors: [Color(primaryDark), Color(gradient_primary_alternative)],
        );
      case 1:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          colors: [Color(gradient_primary), Color(gradient_secondary)],
        );
      case 2:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          colors: [
            Color(gradient_primary_alternative),
            Color(gradient_secondary_alternative),
            Color(gradient_third_alternative)
          ],
        );

      case 3:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          stops: [0.6, 0.95],
          colors: [Color(gradient_secondary), Color(gradient_primary)],
        );
      default:
        return null;
    }
  }

  List<Color> getStepBarColors(int currentStep) {
    Color inactiveColor;
    Color activeColor;
    switch (currentStep) {
      case 0:
        inactiveColor = const Color(0xff4759A2);
        activeColor = const Color(0xffA2E6FA);
        return [inactiveColor, activeColor];
      case 1:
        inactiveColor = const Color(0xffA2E6FA);
        activeColor = const Color(0xff0D3A5C);
        return [inactiveColor, activeColor];
      case 2:
        inactiveColor = const Color(0xff4759A2);
        activeColor = const Color(0xffA2E6FA);
        return [inactiveColor, activeColor];
      case 3:
        inactiveColor = const Color(0xffA2E6FA);
        activeColor = const Color(0xff0D3A5C);
        return [inactiveColor, activeColor];

      default:
        inactiveColor = const Color(0xff4759A2);
        activeColor = const Color(0xffA2E6FA);
        return [inactiveColor, activeColor];
    }
  }

  Row getNextPrevButtons(int currentStep) {
    switch (currentStep) {
      case 0:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(primaryDark),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_forward),
                color: const Color(primaryLight),
                onPressed: () {
                  _nextStep();
                },
              ),
            )
          ],
        );
      case 1:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(0xff89D5EB),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: const Color(primaryDark),
                onPressed: () {
                  _prevStep();
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(primaryDark),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_forward),
                color: const Color(primaryLight),
                onPressed: () {
                  _nextStep();
                },
              ),
            )
          ],
        );
      case 2:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(0xff89D5EB),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: const Color(primaryDark),
                onPressed: () {
                  _prevStep();
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(primaryDark),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_forward),
                color: const Color(primaryLight),
                onPressed: () {
                  _nextStep();
                },
              ),
            )
          ],
        );
      case 3:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(0xff89D5EB),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: const Color(primaryDark),
                onPressed: () {
                  _prevStep();
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: const CustomButton(
                text: 'Comenzar',
                width: 116,
                pushName: '/home_home',
              ),
            )
          ],
        );

      case 4:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(0xff89D5EB),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_forward),
                color: const Color(primaryDark),
                onPressed: () {
                  _nextStep();
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(primaryDark),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_forward),
                color: const Color(primaryLight),
                onPressed: () {
                  // _nextStep();
                },
              ),
            )
          ],
        );
      default:
        return Row();
    }
  }

  Color _getScaffoldColor(int currentStep) {
    switch (currentStep) {
      case 0:
        return const Color(gradient_primary_alternative);
      case 1:
        return const Color(gradient_secondary);
      case 2:
        // return Color.fromARGB(255, 106, 88, 207);
        return const Color(gradient_third_alternative);
      case 3:
        return const Color(0xffA2E6FA);
      default:
        return const Color(0xff4759A2);
    }
  }

  @override
  void initState() {
    super.initState();
    // ref.read(startOnBoardingStateNotifierProvider);

    // ref.read(userProfileFutureProvider.future);
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = ref.watch(userProfileNotifierProvider);
    final login =
        LoginModel(email: userProfile.email!, password: userProfile.password!);
    ref.read(
      authTokenMutationProvider(
        login,
      ),
    );
    List<Color> stepBarColors = getStepBarColors(_currentStep);

    return Scaffold(
      backgroundColor: _getScaffoldColor(_currentStep),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: _getGradient(_currentStep),
          ),
          child: Column(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                ),
                child: PageView(
                  controller: _controller,
                  children: const [
                    Section1(),
                    Section2(),
                    Section3(),
                    Section4()
                  ],
                  onPageChanged: (page) {
                    setState(() {
                      _currentStep = page;
                    });
                  },
                ),
              ),
              StepBar(
                currentStep: _currentStep,
                totalSteps: 4,
                activeColor: stepBarColors[1],
                inactiveColor: stepBarColors[0],
              ),
              getNextPrevButtons(_currentStep),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/onboarding_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/onboarding_question/widgets/page.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:finniu/widgets/step_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Questions extends StatefulHookConsumerWidget {
  const Questions({super.key});

  @override
  ConsumerState<Questions> createState() => _SelectRangeState();
}

class _SelectRangeState extends ConsumerState<Questions> {
  int _currentStep = 0;
  bool lastPage = false;

  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();

    ref.read(startOnBoardingFutureStateNotifierProvider);
  }

  @override
  Widget build(BuildContext context) {
    final onboardingData = ref.watch(onBoardingStateNotifierProvider);
    return CustomScaffoldReturnLogo(
      hideNavBar: true,
      body: HookBuilder(
        builder: (context) {
          final questions = onboardingData.questions;
          if (questions.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ExpandablePageView.builder(
                    controller: pageController,
                    animationDuration: const Duration(milliseconds: 500),
                    itemCount: onboardingData.totalQuestions,
                    onPageChanged: (page) {
                      setState(() {
                        _currentStep = page;
                        if (page == onboardingData.totalQuestions - 1) {
                          lastPage = true;
                        } else {
                          lastPage = false;
                        }
                      });
                    },
                    itemBuilder: (context, index) {
                      return PageQuestion(
                        question: questions[index],
                        controller: pageController,
                        lastPage: lastPage,
                        pageIndex: index,
                      );
                    },
                  ),
                  // ExpandablePageView(
                  //   controller: pageController,
                  //   children: questions
                  //       .map((question) => PageQuestions(
                  //           question: question, controller: pageController))
                  //       .toList(),
                  //   onPageChanged: (page) {
                  //     setState(() {
                  //       _currentStep = page;
                  //     });
                  //   },
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (lastPage) ...[
                    SizedBox(
                      width: 225,
                      height: 50,
                      child: TextButton(
                        child: const Text('Finalizar'),
                        onPressed: () {
                          ref.watch(
                            finishOnboardingFutureStateNotifierProvider,
                          );

                          Navigator.of(context).pushNamed('/investment_result');
                        },
                      ),
                    ),
                  ] else ...[
                    StepBar(
                      currentStep: _currentStep,
                      totalSteps: onboardingData.totalQuestions,
                      activeColor: const Color(primaryLightAlternative),
                      inactiveColor: const Color(primaryDark),
                    ),
                  ]
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

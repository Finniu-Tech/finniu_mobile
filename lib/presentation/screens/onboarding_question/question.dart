import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/domain/entities/onboarding_entities.dart';
import 'package:finniu/presentation/providers/onboarding_provider.dart';
import 'package:finniu/presentation/screens/onboarding_question/widgets/page.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:finniu/widgets/step_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelectRange extends StatefulHookConsumerWidget {
  const SelectRange({super.key});

  @override
  ConsumerState<SelectRange> createState() => _SelectRangeState();
}

class _SelectRangeState extends ConsumerState<SelectRange> {
  int _currentStep = 0;
  bool lastPage = false;

  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();

    ref.read(startOnBoardingStateNotifierProvider);
  }

  @override
  Widget build(BuildContext context) {
    final onboardingData = ref.watch(onBoardingStateNotifierProvider);
    return CustomScaffoldReturnLogo(
      body: HookBuilder(
        builder: (context) {
          // final onboarding = ref.watch(
          //   startOnboardingQuestionsFutureProvider(
          //     ref.watch(userProfileNotifierProvider).id!,
          //   ).future,
          // );
          print('onboarding: $onboardingData');
          print(onboardingData.totalQuestions);
          print(onboardingData.totalCompletedQuestions);
          print(onboardingData.questions);
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
                      // updateOnboardingStateNotifierProvider(
                      //   ref,
                      //   onboardingData.copyWith(
                      //     totalCompletedQuestions: page + 1,
                      //   ),
                      // );

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
                      return PageQuestions(
                        question: questions[index],
                        controller: pageController,
                        lastPage: lastPage,
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
                        child: Text('Finalizar'),
                        onPressed: () {
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

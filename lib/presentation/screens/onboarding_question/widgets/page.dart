// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:finniu/presentation/providers/onboarding_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:finniu/constants/colors.dart';
import 'package:finniu/domain/entities/onboarding_entities.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/onboarding_question/result.dart';

class PageQuestions extends ConsumerWidget {
  final PageController controller;
  final OnboardingQuestionEntity question;
  final bool lastPage;
  const PageQuestions({
    super.key,
    required this.question,
    required this.controller,
    required this.lastPage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    // final currentTheme = Provider.of<SettingsProvider>(context, listen: false);
    return Column(
      children: [
        const SizedBox(height: 30),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 95,
          child: Text(
            question.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: currentTheme.isDarkMode
                  ? const Color(0xffA2E6FA)
                  : const Color(primaryDark),
            ),
          ),
        ),
        Center(
          child: SizedBox(
            width: 120,
            height: 90,
            child: Image.network(
              question.questionImageUrl,
              fit: BoxFit.contain,
            ),
            // child: Image.asset(
            //   'assets/investment/bills.png',
            //   fit: BoxFit.contain,
            // ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        if (question.answers.isNotEmpty) ...[
          for (var i = 0; i < question.answers.length; i++)
            ButtonQuestions(
              questionUuid: question.uuid,
              answer: question.answers[i],
              controller: controller,
            ),
        ]
      ],
    );
  }
}

class ButtonQuestions extends ConsumerWidget {
  final PageController controller;
  final String questionUuid; // TODO: get from
  final AnswerEntity answer;

  const ButtonQuestions({
    super.key,
    required this.controller,
    required this.answer,
    required this.questionUuid,
  });

  @override
  Widget build(BuildContext context, ref) {
    final user = ref.watch(userProfileNotifierProvider);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 53,
        child: TextButton(
          onPressed: () {
            ref.watch(
              updateOnboardingStateNotifierProvider(
                UserAnswerEntity(
                  questionUuid: questionUuid,
                  answerUuid: answer.uuid,
                  userID: user.id!,
                ),
              ),
            );

            // if (totalQuestions ==   2) {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => ResultInvestment()),
            //   );
            // } else {}
            controller.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
          style: TextButton.styleFrom(
            backgroundColor: const Color(primaryLightAlternative),
          ),
          child: Text(
            answer.text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(primaryDark),
            ),
          ),
        ),
      ),
    );
  }
}

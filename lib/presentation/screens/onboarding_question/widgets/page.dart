// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:finniu/presentation/providers/onboarding_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:finniu/constants/colors.dart';
import 'package:finniu/domain/entities/onboarding_entities.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';

class PageQuestion extends HookConsumerWidget {
  final PageController controller;
  final OnboardingQuestionEntity question;
  final bool lastPage;
  final int pageIndex;
  const PageQuestion({
    super.key,
    required this.question,
    required this.controller,
    required this.lastPage,
    required this.pageIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedAnswerIndex = useState(-1);
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
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        if (question.answers.isNotEmpty) ...[
          for (var i = 0; i < question.answers.length; i++)
            ButtonQuestion(
              questionUuid: question.uuid,
              answer: question.answers[i],
              controller: controller,
              answerIndex: i,
              pageIndex: pageIndex,
              // selectedAnswerIndex: selectedAnswerIndex,
            ),
        ]
      ],
    );
  }
}

class ButtonQuestion extends HookConsumerWidget {
  final PageController controller;
  final String questionUuid; // TODO: get from
  final AnswerEntity answer;
  final int answerIndex;
  final int pageIndex;
  // final ValueNotifier<int> selectedAnswerIndex;

  const ButtonQuestion({
    super.key,
    required this.controller,
    required this.answer,
    required this.questionUuid,
    required this.answerIndex,
    required this.pageIndex,
    // required this.selectedAnswerIndex,
  });

  @override
  Widget build(BuildContext context, ref) {
    final user = ref.watch(userProfileNotifierProvider);
    final selectedAnswerIndex = ref
        .watch(SelectedAnswerListStateNotifier.provider.notifier)
        .getSelectedAnswerForPageIndex(pageIndex)
        .answerIndex;
    // print(selectedAnswerIndex.value);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 53,
        child: TextButton(
          onPressed: () {
            ref.watch(
              updateOnboardingFutureStateNotifierProvider(
                UserAnswerEntity(
                  questionUuid: questionUuid,
                  answerUuid: answer.uuid,
                  userID: user.id!,
                ),
              ),
            );
            ref
                .read(SelectedAnswerListStateNotifier.provider.notifier)
                .updateSelectedAnswerForPageIndex(pageIndex, answerIndex);
            // final totalQuestions = ref.watch(onboardingNotifierProvider).length;
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
            backgroundColor: Color(
              selectedAnswerIndex == answerIndex
                  ? primaryDarkAlternative
                  : primaryLightAlternative,
            ),
          ),
          child: Text(
            answer.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(
                selectedAnswerIndex == answerIndex ? whiteText : primaryDark,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

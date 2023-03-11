import 'package:finniu/domain/entities/onboarding_entities.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/onboarding_repository_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final startOnBoardingStateNotifierProvider = FutureProvider<OnboardingEntity>(
  (ref) async {
    final client = ref.watch(gqlClientProvider).value;
    final userId = ref.watch(userProfileNotifierProvider).id;
    final onboardingData = ref
        .watch(onboardingRepositoryProvider)
        .getOnboardingData(client: client!, userId: userId!);
    onboardingData.then(
      (value) {
        ref.read(onBoardingStateNotifierProvider.notifier).updateFields(
              totalQuestions: value.totalQuestions,
              totalCompletedQuestions: value.totalCompletedQuestions,
              questions: value.questions,
            );
      },
    );
    return onboardingData;
  },
);

final updateOnboardingStateNotifierProvider =
    FutureProvider.family<OnboardingEntity, UserAnswerEntity>(
  (ref, UserAnswerEntity userAnswer) async {
    print('update onboarding state notifier provider');
    final client = ref.watch(gqlClientProvider).value;
    final userId = ref.watch(userProfileNotifierProvider).id;

    final onboardingData =
        ref.watch(onboardingRepositoryProvider).updateOnboardingData(
              client: client!,
              userId: userAnswer.userID,
              questionId: userAnswer.questionUuid,
              answerId: userAnswer.answerUuid,
            );
    onboardingData.then(
      (value) {
        print('value!!!!');
        print(value);
        print(value.totalCompletedQuestions);
        print(value.currentQuestion);

        ref.read(onBoardingStateNotifierProvider.notifier).updateFields(
              totalQuestions: value.totalQuestions,
              totalCompletedQuestions: value.totalCompletedQuestions,
              questions: value.questions,
            );
      },
    );

    return onboardingData;
  },
);

final onBoardingStateNotifierProvider =
    StateNotifierProvider<OnboardingStateNotifier, OnboardingEntity>(
  (ref) => OnboardingStateNotifier(
    OnboardingEntity(
      totalQuestions: 0,
      totalCompletedQuestions: 0,
      questions: [],
    ),
  ),
);

class OnboardingStateNotifier extends StateNotifier<OnboardingEntity> {
  OnboardingStateNotifier(OnboardingEntity state) : super(state);

  void updateFields({
    int? totalQuestions,
    int? totalCompletedQuestions,
    List<OnboardingQuestionEntity>? questions,
  }) {
    state = state.copyWith(
      totalQuestions: totalQuestions,
      totalCompletedQuestions: totalCompletedQuestions,
      questions: questions,
    );
  }
}

import 'package:finniu/domain/entities/onboarding_entities.dart';
import 'package:finniu/domain/entities/plan_entities.dart';
import 'package:finniu/infrastructure/models/onboarding_finish_response.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/onboarding_repository_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final startOnBoardingFutureStateNotifierProvider =
    FutureProvider<OnboardingEntity>(
  (ref) async {
    final client = ref.watch(gqlClientProvider).value;
    String userId = ref.watch(userProfileNotifierProvider).id!;

    final onboardingData =
        ref.watch(onboardingRepositoryProvider).getOnboardingData(
              client: client!,
              userId: userId,
            );
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

final updateOnboardingFutureStateNotifierProvider =
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

final finishOnboardingFutureStateNotifierProvider = FutureProvider<bool>(
  (ref) async {
    final client = ref.watch(gqlClientProvider).value;
    final userId = ref.watch(userProfileNotifierProvider).id;
    final recommendedPlan = ref
        .watch(onboardingRepositoryProvider)
        .finishOnboarding(client: client!, userId: userId!);
    bool success = false;
    final data = await recommendedPlan;
    if (data.name.isNotEmpty) {
      success = true;

      ref.read(recommendedPlanStateNotifierProvider.notifier).updateFields(
            uuid: data.uuid,
            name: data.name,
            description: data.description,
            imageUrl: data.imageUrl,
            minAmount: data.minAmount,
            value: data.value,
            twelveMonthsReturn: data.twelveMonthsReturn,
            sixMonthsReturn: data.sixMonthsReturn,
          );
      ref.read(hasCompletedOnboardingProvider.notifier).state = true;
    }
    return success;
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

final recommendedPlanStateNotifierProvider =
    StateNotifierProvider<RecommendedPlanStateNotifier, PlanEntity>(
  (ref) => RecommendedPlanStateNotifier(
    PlanEntity(
      uuid: '',
      name: '',
      description: '',
      imageUrl: '',
      minAmount: 0,
      value: 0,
      twelveMonthsReturn: 0,
      sixMonthsReturn: 0,
    ),
  ),
);

class RecommendedPlanStateNotifier extends StateNotifier<PlanEntity> {
  RecommendedPlanStateNotifier(PlanEntity state) : super(state);

  void updateFields({
    String? uuid,
    String? name,
    String? description,
    String? imageUrl,
    double? minAmount,
    double? value,
    double? twelveMonthsReturn,
    double? sixMonthsReturn,
  }) {
    state = state.copyWith(
      uuid: uuid,
      name: name,
      description: description,
      imageUrl: imageUrl,
      minAmount: minAmount,
      value: value,
      twelveMonthsReturn: twelveMonthsReturn,
      sixMonthsReturn: sixMonthsReturn,
    );
  }
}

// final selectedAnswersProvider =
//     StateProvider<List<SelectedAnswer>>((ref) => []);

class SelectedAnswerStateNotifier extends StateNotifier<SelectedAnswer> {
  SelectedAnswerStateNotifier(SelectedAnswer state) : super(state);

  void updateFields({
    int? pageIndex,
    int? answerIndex,
  }) {
    state = state.copyWith(
      pageIndex: pageIndex,
      answerIndex: answerIndex,
    );
  }
}

// StateNotifier to provide methods for getting and updating SelectedAnswerList state
class SelectedAnswerListStateNotifier
    extends StateNotifier<List<SelectedAnswer>> {
  SelectedAnswerListStateNotifier(List<SelectedAnswer> state) : super(state);
  static final provider = StateNotifierProvider<SelectedAnswerListStateNotifier,
      List<SelectedAnswer>>((ref) {
    return SelectedAnswerListStateNotifier([]);
  });

  // Method to get the SelectedAnswer for a given page index
  SelectedAnswer getSelectedAnswerForPageIndex(int pageIndex) {
    return state.firstWhere(
        (selectedAnswer) => selectedAnswer.pageIndex == pageIndex,
        orElse: () => SelectedAnswer(-1, -1));
  }

  // Method to update the SelectedAnswer for a given page index
  void updateSelectedAnswerForPageIndex(int pageIndex, int answerIndex) {
    final selectedAnswerIndex = state
        .indexWhere((selectedAnswer) => selectedAnswer.pageIndex == pageIndex);
    if (selectedAnswerIndex == -1) {
      state = [...state, SelectedAnswer(pageIndex, answerIndex)];
    } else {
      final selectedAnswer = state[selectedAnswerIndex];
      state[selectedAnswerIndex] =
          selectedAnswer.copyWith(answerIndex: answerIndex);
    }
  }
}

final hasCompletedOnboardingProvider = StateProvider((ref) => false);

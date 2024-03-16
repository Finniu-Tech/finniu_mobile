import 'package:finniu/domain/entities/onboarding_entities.dart';
import 'package:finniu/infrastructure/models/onboarding_response.dart';

class OnboardingMapper {
  static OnboardingEntity toEntity(StartOnboardingGraphqlModel model) {
    return OnboardingEntity(
      totalQuestions: model.totalQuestions ?? 0,
      totalCompletedQuestions: model.questionsCompleted ?? 0,
      questions: model.questions!
          .map(
            (e) => OnboardingQuestionEntity(
              text: e.text ?? '',
              uuid: e.uuid ?? '',
              questionImageUrl: e.questionImageUrl ?? '',
              answers: e.answers!
                  .map(
                    (e) => AnswerEntity(
                      text: e.text ?? '',
                      uuid: e.uuid ?? '',
                      value: e.value ?? 0,
                    ),
                  )
                  .toList(),
              value: '',
            ),
          )
          .toList(),
    );
  }
}

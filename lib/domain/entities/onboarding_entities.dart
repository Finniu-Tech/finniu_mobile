class OnboardingEntity {
  final bool? completed;
  final int totalQuestions;
  final int? currentQuestion;
  final List<OnboardingQuestionEntity> questions;
  final int? totalCompletedQuestions;

  OnboardingEntity({
    this.completed,
    required this.totalQuestions,
    this.currentQuestion,
    required this.questions,
    required this.totalCompletedQuestions,
  });

  OnboardingEntity copyWith({
    bool? completed,
    int? totalQuestions,
    int? currentQuestion,
    List<OnboardingQuestionEntity>? questions,
    int? totalCompletedQuestions,
  }) {
    return OnboardingEntity(
      completed: completed ?? this.completed,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      currentQuestion: currentQuestion ?? this.currentQuestion,
      questions: questions ?? this.questions,
      totalCompletedQuestions:
          totalCompletedQuestions ?? this.totalCompletedQuestions,
    );
  }
}

class OnboardingQuestionEntity {
  final String uuid;
  final String text;
  final String value;
  final String questionImageUrl;
  final List<AnswerEntity> answers;

  OnboardingQuestionEntity({
    required this.uuid,
    required this.text,
    required this.value,
    required this.questionImageUrl,
    required this.answers,
  });

  OnboardingQuestionEntity copyWith({
    String? uuid,
    String? text,
    String? value,
    String? questionImageUrl,
    List<AnswerEntity>? answers,
  }) {
    return OnboardingQuestionEntity(
      uuid: uuid ?? this.uuid,
      text: text ?? this.text,
      value: value ?? this.value,
      questionImageUrl: questionImageUrl ?? this.questionImageUrl,
      answers: answers ?? this.answers,
    );
  }
}

class AnswerEntity {
  final String uuid;
  final String text;
  final int value;

  AnswerEntity({
    required this.uuid,
    required this.text,
    required this.value,
  });

  AnswerEntity copyWith({
    String? uuid,
    String? text,
    int? value,
  }) {
    return AnswerEntity(
      uuid: uuid ?? this.uuid,
      text: text ?? this.text,
      value: value ?? this.value,
    );
  }
}

class UserAnswerEntity {
  final String userID;
  final String questionUuid;
  final String answerUuid;

  UserAnswerEntity({
    required this.questionUuid,
    required this.answerUuid,
    required this.userID,
  });

  UserAnswerEntity copyWith({
    String? questionUuid,
    String? answerUuid,
    String? userID,
  }) {
    return UserAnswerEntity(
      questionUuid: questionUuid ?? this.questionUuid,
      answerUuid: answerUuid ?? this.answerUuid,
      userID: userID ?? this.userID,
    );
  }
}

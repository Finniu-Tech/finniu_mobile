// To parse this JSON data, do
//
//     final scanModel = scanModelFromJson(jsonString);

import 'dart:convert';

class StartOnboardingGraphqlModel {
  StartOnboardingGraphqlModel({
    this.success,
    this.successRegisterResponse,
    this.totalQuestions,
    this.questionsCompleted,
    this.questions,
  });

  bool? success;
  bool? successRegisterResponse;
  int? totalQuestions;
  int? questionsCompleted;
  List<QuestionGraphqlModel>? questions;

  factory StartOnboardingGraphqlModel.fromJson(Map<String, dynamic> json) =>
      StartOnboardingGraphqlModel(
        success: json["success"],
        successRegisterResponse: json["successRegisterResponse"],
        totalQuestions: json["totalQuestions"],
        questionsCompleted: json["questionsCompleted"],
        questions: json["questions"] == null
            ? []
            : List<QuestionGraphqlModel>.from(json["questions"]!
                .map((x) => QuestionGraphqlModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "successRegisterResponse": successRegisterResponse,
        "totalQuestions": totalQuestions,
        "questionsCompleted": questionsCompleted,
        "questions": questions == null
            ? []
            : List<dynamic>.from(questions!.map((x) => x.toJson())),
      };
}

class QuestionGraphqlModel {
  QuestionGraphqlModel({
    this.text,
    this.uuid,
    this.questionImageUrl,
    this.answers,
    this.answerMarked,
  });

  String? text;
  String? uuid;
  String? questionImageUrl;
  List<AnswerGraphqlModel>? answers;
  dynamic answerMarked;

  factory QuestionGraphqlModel.fromJson(Map<String, dynamic> json) =>
      QuestionGraphqlModel(
        text: json["text"],
        uuid: json["uuid"],
        questionImageUrl: json["questionImageUrl"],
        answers: json["answers"] == null
            ? []
            : List<AnswerGraphqlModel>.from(
                json["answers"]!.map((x) => AnswerGraphqlModel.fromJson(x))),
        answerMarked: json["answerMarked"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "uuid": uuid,
        "questionImageUrl": questionImageUrl,
        "answers": answers == null
            ? []
            : List<dynamic>.from(answers!.map((x) => x.toJson())),
        "answerMarked": answerMarked,
      };
}

class AnswerGraphqlModel {
  AnswerGraphqlModel({
    this.uuid,
    this.value,
    this.text,
  });

  String? uuid;
  int? value;
  String? text;

  factory AnswerGraphqlModel.fromJson(Map<String, dynamic> json) =>
      AnswerGraphqlModel(
        uuid: json["uuid"],
        value: json["value"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "value": value,
        "text": text,
      };
}

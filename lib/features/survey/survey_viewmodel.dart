import 'dart:convert';

import 'package:flutter/services.dart';

import 'question_model.dart';

class SurveyViewModel {
  List<QuestionModel> questions = [];

  final Map<int, int> answers = {};

  Future<void> loadQuestions() async {
    final jsonString =
        await rootBundle.loadString(
      'assets/json/questions.json',
    );

    final List<dynamic> data =
        json.decode(jsonString);

    questions = data
        .map(
          (e) => QuestionModel.fromJson(e),
        )
        .toList();
  }

  void saveAnswer(
    int questionId,
    int value,
  ) {
    answers[questionId] = value;
  }

  bool get allAnswered {
    return answers.length ==
        questions.length;
  }

  String buildEmailBody() {
    return questions
        .map(
          (q) =>
              "${q.question}: ${answers[q.id]}",
        )
        .join("\r\n");
  }
}
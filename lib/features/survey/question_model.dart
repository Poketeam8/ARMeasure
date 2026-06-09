class QuestionModel {
  final int id;
  final String question;
  final int min;
  final int max;

  QuestionModel({
    required this.id,
    required this.question,
    required this.min,
    required this.max,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json["id"],
      question: json["question"],
      min: json["min"],
      max: json["max"],
    );
  }
}
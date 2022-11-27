class Question {
  String? questionId;
  String? question;
  List<String?>? answers;
  int? correct;
  Question({this.questionId, this.question, this.answers, this.correct});

  factory Question.fromJson(Map<String, dynamic>? data, String dataId) {
    final String content = data?['content'];
    return Question(
        question: content, questionId: dataId, answers: [], correct: -1);
  }
}

class Answers {
  String? content;
  bool? correct;
  Answers({this.content, this.correct});
  factory Answers.fromJson(Map<String, dynamic>? data) {
    final String content = data?['content'];
    final bool correct = data?['correct'];
    return Answers(content: content, correct: correct);
  }
}

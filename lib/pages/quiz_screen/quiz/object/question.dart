class QuizQuestion {
  String? questionId;
  String? question;
  List<String?>? answers;
  int? correct;
  QuizQuestion({this.questionId, this.question, this.answers, this.correct});

  factory QuizQuestion.fromJson(Map<String, dynamic>? data, String dataId) {
    final String content = data?['content'];
    return QuizQuestion(
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

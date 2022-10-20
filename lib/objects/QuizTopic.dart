import 'package:flutter_interview_preparation/objects/Quiz.dart';

class QuizTopic{
  String? topic;
  List<Quiz>? listQuiz;
  bool? favourite;
  QuizTopic(this.topic,this.listQuiz,this.favourite);
}
List<QuizTopic> listQuizTopic=[
  QuizTopic('HTML & XML1', listQuiz, true),
  QuizTopic('HTML & XML2', listQuiz, false),
  QuizTopic('HTML & XML3', listQuiz, true),
  QuizTopic('HTML & XML4', listQuiz, true),
  QuizTopic('HTML & XML5', listQuiz, false),
  QuizTopic('HTML & XML6', listQuiz, true),
  QuizTopic('HTML & XML1', listQuiz, true),
  QuizTopic('HTML & XML2', listQuiz, false),
  QuizTopic('HTML & XML3', listQuiz, true),
  QuizTopic('HTML & XML4', listQuiz, true),
  QuizTopic('HTML & XML5', listQuiz, false),
];

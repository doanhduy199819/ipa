import 'package:flutter_interview_preparation/objects/QuizTopic.dart';

class QuizSet{
  String? topic;
  bool? favourite;
  List<QuizTopic>? listQuizTopic;
  QuizSet(this.topic,this.favourite,this.listQuizTopic);
}
List<QuizSet> listQuizSet=[
  QuizSet('Aptitude', true, listQuizTopic),
  QuizSet('Web technologies', true, listQuizTopic),
  QuizSet('Engineering Mathematics', true, listQuizTopic),
  QuizSet('Web technologies', true, listQuizTopic),
  QuizSet('Engineering Mathematics', true, listQuizTopic),
];
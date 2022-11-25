import 'package:flutter_interview_preparation/objects/QuizTopic.dart';
import 'package:flutter_interview_preparation/objects/StackCustom.dart';

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
  QuizSet('Mobile technologies', true, listQuizTopic),
  QuizSet('Java', true, listQuizTopic),
  QuizSet('C++', true, listQuizTopic),
  QuizSet('C#', true, listQuizTopic),
];

List<QuizSet> recentlyQuizSet=[
  QuizSet('Aptitude', true, listQuizTopic),
  QuizSet('Web technologies', true, listQuizTopic),
  QuizSet('Engineering Mathematics', true, listQuizTopic),
];
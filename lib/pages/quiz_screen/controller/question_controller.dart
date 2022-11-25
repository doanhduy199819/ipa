import 'package:flutter/material.dart';
import '../quiz/object/question.dart';

class QuesionController {
  static late List<Question> listQuestion;
  static late List<int> myAnswers;
  static int index = 0;
  static double process = 0;
  static late int numberQuestion;

  void increaseProcess() {
    process = process + 1.0 / numberQuestion;
  }

  int checkStatusAnswerOption(int option) {
    if (myAnswers[index] > -1) {
      if (option == listQuestion[index].correct) return 1;
      if (option == myAnswers[index]) return -1;
      return 0;
    }
    return 2;
  }

  int checkStatusAnswerQuestion(int index) {
    if (myAnswers[index] > -1) {
      if (myAnswers[index] == listQuestion[index].correct) return 1;
      return -1;
    }
    return 0;
  }

  int getScoreQuiz() {
    int score = 0;
    for (int i = 0; i < listQuestion.length; i++) {
      if (listQuestion[i].correct == myAnswers[i]) score += 10;
    }
    return score;
  }

  int getNumberAnswersCorrect() {
    int res = 0;
    for (int i = 0; i < listQuestion.length; i++) {
      if (listQuestion[i].correct == myAnswers[i]) res += 1;
    }
    return res;
  }

  int getNumberAnswersWrong() {
    int res = 0;
    for (int i = 0; i < listQuestion.length; i++) {
      if (myAnswers[i] > -1 && listQuestion[i].correct != myAnswers[i])
        res += 1;
    }
    return res;
  }

  void reset() {
    listQuestion = [];
    myAnswers = [];
    index = 0;
    numberQuestion = 0;
    process = 0;
  }

  void addDataTemplate() {
    Question question1 = Question(
        "1 What do you understand by HTML?",
        [
          " HTML describes the structure of a webpage",
          " HTML is the standard markup language mainly used to create web pages",
          "HTML consists of a set of elements that helps the browser how to view the content",
          "All of the above"
        ],
        0);
    Question question2 = Question(
        "2 What do you understand by HTML?",
        [
          " HTML describes the structure of a webpage",
          " HTML is the standard markup language mainly used to create web pages",
          "HTML consists of a set of elements that helps the browser how to view the content",
          "All of the above"
        ],
        1);
    Question question3 = Question(
        "3 What do you understand by HTML?",
        [
          " HTML describes the structure of a webpage",
          " HTML is the standard markup language mainly used to create web pages",
          "HTML consists of a set of elements that helps the browser how to view the content",
          "All of the above"
        ],
        2);
    Question question4 = Question(
        "4 What do you understand by HTML?",
        [
          " HTML describes the structure of a webpage",
          " HTML is the standard markup language mainly used to create web pages",
          "HTML consists of a set of elements that helps the browser how to view the content",
          "All of the above"
        ],
        3);
    listQuestion = [question1, question2, question3, question4];
    myAnswers = [-1, -1, -1, -1];
    numberQuestion = listQuestion.length;
  }
}

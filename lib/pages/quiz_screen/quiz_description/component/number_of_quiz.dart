import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/Helper.dart';
import 'package:flutter_interview_preparation/pages/quiz_screen/controller/question_controller.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';

import '../../../../objects/SetOfQuiz.dart';
import '../../object/categories.dart';
import '../../quiz/object/question.dart';
import 'big_text_in_achievement.dart';

class NumberOfQuiz extends StatelessWidget {
  const NumberOfQuiz(
      {Key? key, required this.dataBoxCategories, required this.setOfQuiz})
      : super(key: key);
  final DataBoxCategories dataBoxCategories;
  final SetOfQuiz setOfQuiz;

  Widget buildItem(int number) {
    return BigTextInAchievement(
        frontText: number.toString(), behindText: 'Quizz');
  }

  Future<List<QuizQuestion>?> loadData() async {
    QuesionController.listQuestion = await DatabaseService().getQuestionOfQuiz(
        dataBoxCategories.jobid, dataBoxCategories.categoriesid, setOfQuiz.id);
    for (int i = 0; i < QuesionController.listQuestion!.length; i++) {
      List<Answers>? listAnswer = await DatabaseService()
          .getAnswersWithQuestion(
              dataBoxCategories.jobid,
              dataBoxCategories.categoriesid,
              setOfQuiz.id,
              QuesionController.listQuestion![i].questionId);
      List<String?> answers = [];
      for (int j = 0; j < listAnswer!.length; j++) {
        answers.add(listAnswer[j].content);
        if (listAnswer[j].correct == true) {
          QuesionController.listQuestion![i].correct = j;
        }
      }
      QuesionController.listQuestion![i].answers = answers;
    }
    return QuesionController.listQuestion;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadData(),
      builder: (context, AsyncSnapshot<List<QuizQuestion>?> snapshot) {
        return Helper.handleSnapshot(snapshot) ??
            buildItem((snapshot.data ?? []).length);
      },
    );
  }
}

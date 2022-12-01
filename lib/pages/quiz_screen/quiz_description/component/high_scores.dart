import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/Helper.dart';
import 'package:flutter_interview_preparation/pages/quiz_screen/controller/question_controller.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';

import '../../../../objects/SetOfQuiz.dart';
import '../../object/categories.dart';
import '../../quiz/object/question.dart';
import 'big_text_in_achievement.dart';

class HighScores extends StatelessWidget {
  const HighScores(
      {Key? key, required this.dataBoxCategories, required this.setOfQuiz})
      : super(key: key);
  final DataBoxCategories dataBoxCategories;
  final SetOfQuiz setOfQuiz;

  Widget buildItem(int number) {
    return BigTextInAchievement(
        frontText: number.toString(),
        behindText: "/" +
            ((QuesionController.listQuestion ?? []).length * 10).toString());
  }

  Future<int> loadData() async {
    int result = 0;
    result = await DatabaseService().getHightScoreQuiz(
        dataBoxCategories.jobid, dataBoxCategories.categoriesid, setOfQuiz.id);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadData(),
      builder: (context, AsyncSnapshot<int> snapshot) {
        if (snapshot.hasError) {
          print("Error: ${snapshot.error.toString()}");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return buildItem(snapshot.data ?? 0);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
